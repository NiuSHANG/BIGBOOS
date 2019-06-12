package action;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import entity.BookCopy;
import entity.BookProfile;
import lombok.Data;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import service.AdminService;
import service.UserService;

import java.time.LocalDate;
import java.util.*;
import java.util.stream.Collectors;

@Controller
@ParentPackage("struts-default")
@Namespace("/")
@Data
public class BookAction extends ActionSupport {
    private long id;
    private String bookname;
    private String author;
    private String type;
    private String summary;
    private LocalDate date;
    private Double price;
    private int number;
    private long isbn;

    private static final int PER_PAGE = 9;

    @Autowired
    AdminService asi;
    @Autowired
    UserService usi;

    @Action(value = "AddBook",
            results = {@Result(name = "success", type = "dispatcher", location = "/Admin.jsp"),
                    @Result(name = "fail", type = "dispatcher", location = "/Admin.jsp")})
    public String AddBook(){
        BookProfile build = BookProfile.builder().isbn((long)id).name(bookname).author(author).type(type).price(price).summary(summary).issueOn(LocalDate.now()).build();
        if(asi.addBookProfile(build) == null){
            addActionError("图书已存在，请重新输入图书信息。");
            return "fail";
        }else {
            asi.addBookProfile(build);
            addActionMessage("图书添加成功。");
            for(int i=0; i<number; i++){
                asi.addBookCopy(BookCopy.builder().profile(build).build());
            }
            return "success";
        }
    }
    @Action(value = "UpdateBook",
            results = @Result(name = "success", type = "dispatcher", location = "/Admin.jsp"))
    public String UpdateBook(){
        BookProfile build = BookProfile.builder().isbn((long)id).name(bookname).author(author).price(price).
                            type(type).issueOn(LocalDate.now()).build();
        asi.updateBookProfile(build);
        return "success";
    }

    @Action(value = "BookNumber",
            results = @Result(name = "success", type = "dispatcher", location = "/main.jsp"))
    public String AddBookNumber(){
        for(int i=0; i<number; i++) {
            asi.addBookCopy(BookCopy.builder()
                    .profile(asi.findBookProfile((int)ActionContext.getContext().get("bookId")))
                    .build());
        }
        return "success";
    }

    private String currentType;
    @Action(value = "Main",
            results = @Result(name = "success", type = "dispatcher", location = "/main.jsp"))
    public String execute() {
        System.out.println(getBookList().getContent().get(0).getCopies());
        return "success";
    }

    private Map<String, Object> criteriaOf(String... values) {
        TreeMap<String, Object> criteria = new TreeMap<>();
        for (int i = 0; i / 2 < values.length / 2; i += 2)
            criteria.put(values[i], values[i + 1]);
        return criteria;
    }

    public Page<BookProfile> getBookList(){
        return asi.findBookByCriteria(new TreeMap<>(), new PageRequest(0, Integer.MAX_VALUE)); // TODO
    }

    private Map<String, Page<BookProfile>> profileByType;
    public Map<String, Page<BookProfile>> getProfileByType() {
        if (profileByType == null) {
            profileByType = new TreeMap<>();
            List<String> types = asi.findBookByCriteria(new HashMap<>()).stream().map(BookProfile::getType).distinct().collect(Collectors.toList());
            for (String type : types)
                profileByType.put(type, asi.findBookByCriteria(criteriaOf("type", type), new PageRequest(getPageOfType().getOrDefault(type, 0), PER_PAGE)));
        }
        return profileByType;
    }

    private Map<String, Integer> pageOfType = new TreeMap<>();
    public Map<String, Integer> getPageOfType() {
        return new Map<String, Integer>() {
            @Override
            public int size() {
                return pageOfType.size();
            }

            @Override
            public boolean isEmpty() {
                return pageOfType.isEmpty();
            }

            @Override
            public boolean containsKey(Object key) {
                return true;
            }

            @Override
            public boolean containsValue(Object value) {
                return value.equals(0) || pageOfType.containsValue(value);
            }

            @Override
            public Integer get(Object key) {
                return Optional.ofNullable(pageOfType.get(key)).orElse(0);
            }

            @Override
            public Integer put(String key, Integer value) {
                return pageOfType.put(key, value);
            }

            @Override
            public Integer remove(Object key) {
                return pageOfType.remove(key);
            }

            @Override
            public void putAll(Map<? extends String, ? extends Integer> m) {
                pageOfType.putAll(m);
            }

            @Override
            public void clear() {
                pageOfType.clear();
            }

            @Override
            public Set<String> keySet() {
                return pageOfType.keySet();
            }

            @Override
            public Collection<Integer> values() {
                return pageOfType.values();
            }

            @Override
            public Set<Entry<String, Integer>> entrySet() {
                return pageOfType.entrySet();
            }
        };
    }
    public void setPageOfType(String[] statements) {
        for (String statement : statements) {
            int sep = statement.lastIndexOf(',');
            if (sep == -1) continue;

            String type = statement.substring(0, sep);
            int page = Integer.parseInt(statement.substring(sep + 1));
            pageOfType.put(type, page);
        }
    }

    private long bookId;

    @Action(value = "BookInformation",
            results = @Result(name = "success", type = "dispatcher", location = "/BookInformation.jsp"))
    public String executeBookInformation() {
        return "success";
    }
    public BookProfile getBookInfo(){
        return asi.findBookProfile(bookId);
    }

    public long getAvailable() {
        return getBookInfo().getCopies().stream().filter(copy -> copy.getBorrower() == null).count();
    }


}
