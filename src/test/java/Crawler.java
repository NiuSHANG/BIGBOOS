import config.SpringConfig;
import dao.BookProfileRepository;
import entity.BookProfile;
import lombok.extern.slf4j.Slf4j;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.Scanner;
import java.util.TreeMap;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Slf4j
public class Crawler {
    private static ApplicationContext applicationContext;

    public static void main(String[] args) {
        System.out.println("========================================");
        System.out.println("       Crawler of Library Manager       ");
        System.out.println("   as a component of the Final Handout  ");
        System.out.println("========================================");
        System.out.println("Initializing ...");
        applicationContext = new AnnotationConfigApplicationContext(SpringConfig.class);
        System.out.println("========================================");
        System.out.println("Input a number or url to convert it to BookProfile and store it temporarily.");
        System.out.println("Input \"page [full url]\" (without quotes) to get all links, " +
                                        "and select those usable to convert to BookProfiles and store.");
        System.out.println("Input \"show\" (without quotes) to list all stored BookProfiles.");
        System.out.println("Input \"insert\" (without quotes) to add all stored BookProfiles to the database " +
                                        "(will establish a connection if there isn't any available).");
        System.out.println("Input \"exit\" (without quotes) to exit.");
        System.out.println("BookProfile with duplicated isbn will replace the old one.");
        System.out.println("========================================");
        System.out.println("Enjoy it! (゜-゜)つロ");
        System.out.println("========================================");

        Scanner sc = new Scanner(System.in);
        while (sc.hasNextLine()) {
            if (!CLI.process(sc.nextLine()))
                return;
        }
    }

    private static class CLI {
        private static Map<Long, BookProfile> books = new TreeMap<>();

        static boolean process(String input) {
            try {
                if (input == null) {
                    System.out.println("`input` can't be null!");
                } else if (input.equals("show")) {
                    books.forEach((k, v) -> System.out.println(String.format("%13d: %s", k, v.toString())));
                    System.out.println("Count: " + books.size());
                } else if (input.equals("insert")) {
                    System.out.println("Saving ...");
                    BookProfileRepository profileRepo = applicationContext.getBean(BookProfileRepository.class);
                    profileRepo.save(books.values());
                    System.out.println("Done.");
                } else if (input.equals("exit")) {
                    System.out.println("Exiting...");
                    return false; // terminate the program
                } else if (input.startsWith("page ")) {
                    String url = input.substring("page ".length());
                    System.out.println("Parsing page [" + url + "] ...");
                    List<String> urls = parseListPage(url);
                    System.out.println(urls.size());
                    for (String s : urls) {
                        try {
                            System.out.println("Trying [" + s + "] ...");
                            BookProfile profile = toBookProfile(s);
                            books.put(profile.getIsbn(), profile);
                        } catch (Exception ex) {
                            ex.printStackTrace();
                        }
                    }
                    System.out.println("Finished.");
                } else {
                    if (input.trim().matches("-?\\d+(\\.\\d+)?")) {
                        System.out.println("Trying to add a BookProfile by id [" + input + "] ...");
                        BookProfile profile = toBookProfile(Integer.parseInt(input));
                        books.put(profile.getIsbn(), profile);
                    } else if (isUri(input)) {
                        System.out.println("Trying to add a BookProfile by url [" + input + "]...");
                        BookProfile profile = toBookProfile(input);
                        books.put(profile.getIsbn(), profile);
                    } else {
                        System.out.println("Doesn't understand.");
                    }
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }

            return true; // allow next input
        }

        private static boolean isUri(String input) {
            return input.trim().matches("^https?://[-a-zA-Z0-9+&@#/%?=~_|!:,.;]*[-a-zA-Z0-9+&@#/%=~_|]");
        }
    }

    private static List<String> parseListPage(String page) throws IOException {
        return Jsoup.connect(page).get().getElementsByTag("a")
                .stream()
                .map(a -> a.attr("href"))
                .filter(s -> s.matches("https?://product.dangdang.com/(\\d+).html"))
                .distinct()
                .collect(Collectors.toList());
    }

    private static BookProfile toBookProfile(int id) throws IOException {
        return toBookProfile(String.format("http://product.dangdang.com/%d.html", id));
    }

    private static BookProfile toBookProfile(String url) throws IOException {
        BookProfile out = toBookProfile(Jsoup.connect(url).timeout(1000).get());
        if (out == null) log.error("`null` while url == \"" + url + "\".");
        return out;
    }

    private static BookProfile toBookProfile(Document document) {
        BookProfile out = new BookProfile();
        Element body = document.body();

        // isbn
        body.getElementById("detail_describe").getElementsByTag("li")
                .stream()
                .map(Element::text)
                .filter(s -> s.trim().contains("国际标准书号ISBN："))
                .map(s -> s.substring(s.length() - 13))
                .map(Long::parseLong)
                .findFirst()
                .ifPresent(out::setIsbn);
        if (out.getIsbn() == null) {
            log.error("Unable to figure out ISBN! Use breakpoint to see more information");
            return null;
        }

        // name
        out.setName(body.getElementById("product_info").getElementsByTag("h1").first().text());

        // summary
        out.setSummary(body.getElementsByClass("head_title_name").first().text());

        // author
        out.setAuthor(body.getElementById("author").children().last().text());

        // type
        out.setType(body.getElementById("breadcrumb").getElementsByTag("a").get(1).text());

        // issueOn
        body.getElementById("product_info").getElementsByClass("messbox_info")
                .stream()
                .flatMap(e -> e.children().stream()).map(Element::text)
                .filter(s -> s.startsWith("出版时间:"))
                .findFirst()
                .ifPresent(str -> {
                    String[] split = str.substring(5).trim().split("[年月]");
                    if (split.length < 2) return;
                    out.setIssueOn(LocalDate.of(Integer.parseInt(split[0]), Integer.parseInt(split[1]), 1));
                });

        // price
        Stream.of(new StringBuilder())
              .peek(sb -> body.getElementById("original-price").text()
                              .chars()
                              .filter(i -> i == '.' || Character.isDigit(i))
                              .forEach(i -> sb.append((char) i)))
              .map(StringBuilder::toString)
              .mapToDouble(Double::parseDouble)
              .forEach(out::setPrice);

        return out;
    }
}
