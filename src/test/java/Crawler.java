import entity.BookProfile;
import lombok.extern.slf4j.Slf4j;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;

import java.io.IOException;
import java.time.LocalDate;
import java.util.LinkedList;
import java.util.List;
import java.util.Scanner;
import java.util.stream.Stream;

@Slf4j
public class Crawler {
    public static void main(String[] args) throws IOException {
        System.out.println("========================================");
        System.out.println("       Crawler of Library Manager       ");
        System.out.println("   as a component of the Final Handout  ");
        System.out.println("========================================");
        System.out.println();
        System.out.println("Input a number or url to convert it to BookProfile and store it temporarily.");
        System.out.println("Input \"show\" (without quotes) to list all stored BookProfiles.");
        System.out.println("Input \"insert\" (without quotes) to add all stored BookProfiles to the database " +
                                        "(will establish a connection if there isn't any available).");
        System.out.println("Input \"exit\" (without quotes) to exit.");
        System.out.println("========================================");
        System.out.println("Please begin your performance. (๑•̀ㅂ•́)و✧");

        Scanner sc = new Scanner(System.in);
        while (sc.hasNextLine()) {
            if (!CLI.process(sc.nextLine()))
                return;
        }
    }

    private static class CLI {
        private static List<BookProfile> books = new LinkedList<>();

        public static boolean process(String input) {
            try {
                if (input == null) {
                    System.out.println("`input` can't be null!");
                } else if (input.equals("show")) {
                    books.forEach(System.out::println);
                } else if (input.equals("insert")) {
                    System.out.println("Not implemented."); // TODO
                } else if (input.equals("exit")) {
                    System.out.println("Exiting...");
                    return false; // terminate the program
                } else {
                    if (input.trim().matches("-?\\d+(\\.\\d+)?")) {
                        System.out.println("Trying to add a BookProfile to temp list by id ...");
                        books.add(toBookProfile(Integer.parseInt(input)));
                    } else if (input.trim().matches("^https?://[-a-zA-Z0-9+&@#/%?=~_|!:,.;]*[-a-zA-Z0-9+&@#/%=~_|]")) {
                        System.out.println("Trying to add a BookProfile to temp list by url ...");
                        books.add(toBookProfile(input));
                    } else {
                        System.out.println("Doesn't understand.");
                    }
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }

            return true; // allow next input
        }
    }

    private static BookProfile toBookProfile(int id) throws IOException {
        return toBookProfile(String.format("http://product.dangdang.com/%d.html", id));
    }

    private static BookProfile toBookProfile(String url) throws IOException {
        BookProfile out = toBookProfile(Jsoup.connect(url).get());
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
