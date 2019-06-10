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
import java.util.Map;
import java.util.TreeMap;

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

    private int novelPage;
    private int PRPage;
    private int TAPage;
    private int sciencePage;
    private int historyPage;


    private static final int PER_PAGE = 9;

    @Autowired
    AdminService asi;
    @Autowired
    UserService usi;

    @Action(value = "AddBook",
            results = {@Result(name = "success", type = "dispatcher", location = "/Admin.jsp"),
                    @Result(name = "fall", type = "dispatcher", location = "/Admin.jsp")})
    public String AddBook(){
        BookProfile build = BookProfile.builder().isbn((long)id).name(bookname).author(author).type(type).price(price).summary(summary).issueOn(LocalDate.now()).build();
        if(asi.addBookProfile(build) == null){
            addActionError("图书已存在，请重新输入图书信息。");
            return "fall";
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

    public Page<BookProfile> getBookListNovel(){
        return asi.findBookByCriteria(criteriaOf("type", "小说"), new PageRequest(novelPage, PER_PAGE));
    }

    public Page<BookProfile> getBookListPhilosophicalReligion(){
        return asi.findBookByCriteria(criteriaOf("type", "哲学/宗教"), new PageRequest(PRPage, PER_PAGE));
    }


    public Page<BookProfile> getBookListScience(){
        return asi.findBookByCriteria(criteriaOf("type", "科技"), new PageRequest(sciencePage, PER_PAGE));
    }

    public Page<BookProfile> getBookListTeachingAssistant(){
        return asi.findBookByCriteria(criteriaOf("type", "外语"), new PageRequest(TAPage, PER_PAGE));
    }

    public Page<BookProfile> getBookListHistory(){
        return asi.findBookByCriteria(criteriaOf("type", "历史"), new PageRequest(historyPage, PER_PAGE));
    }

    @Action(value = "BookInformation",
            results = @Result(name = "success", type = "dispatcher", location = "/BookInformation.jsp"))
    public String executeBookInformation(){return "success";}
    public BookProfile getBookInformation(){
        return asi.findBookProfile((int)ActionContext.getContext().get("bookId"));
    }




}
