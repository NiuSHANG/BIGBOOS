import entity.BookProfile;
import lombok.extern.slf4j.Slf4j;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;

import java.io.IOException;
import java.time.LocalDate;
import java.util.stream.Stream;

@Slf4j
public class Crawler {
    public static void main(String[] args) throws IOException {
        System.out.println(toBookProfile(25300595));
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
                .map(Integer::parseInt)
                .findFirst()
                .ifPresent(out::setIsbn);
        if (out.getIsbn() == null) {
            log.error("Unable to figure out ISBN! Use breakpoint to see more information");
            return null;
        }

        // name
        out.setName(document.getElementById("product_info").getElementsByTag("h1").first().text());

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
                    if (split.length < 3) return;
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
