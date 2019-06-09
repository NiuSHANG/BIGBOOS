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
import org.springframework.stereotype.Controller;
import service.AdminService;
import service.UserService;

import java.time.LocalDate;
import java.util.List;
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
                    .profile(asi.findBookProfile((int)ActionContext.getContext().get("bookid")))
                    .build());
        }
        return "success";
    }

    @Action(value = "Main",
            results = @Result(name = "success", type = "dispatcher", location = "/main.jsp"))
    public String execute(){return "success";}

    public List<BookProfile> getBookList(){
        return asi.findBookByCriteria(new TreeMap<>());
    }
    public List<BookProfile> getBookListNovel(){
        TreeMap<String, Object> criteria = new TreeMap<>();
        criteria.put("type","小说");
        return asi.findBookByCriteria(criteria);
    }
    public List<BookProfile> getBookListPhilosophicalReligion(){
        TreeMap<String, Object> criteria = new TreeMap<>();
        criteria.put("type","哲学/宗教");
        return asi.findBookByCriteria(criteria);
    }
    public List<BookProfile> getBookListScience(){
        TreeMap<String, Object> criteria = new TreeMap<>();
        criteria.put("type","科技书");
        return asi.findBookByCriteria(criteria);
    }
    public List<BookProfile> getBookListTeachingAssistant(){
        TreeMap<String, Object> criteria = new TreeMap<>();
        criteria.put("type","外语");
        return asi.findBookByCriteria(criteria);
    }
    public List<BookProfile> getBookListSocialScience(){
        TreeMap<String, Object> criteria = new TreeMap<>();
        criteria.put("type","历史");
        return asi.findBookByCriteria(criteria);
    }

    @Action(value = "BookInformation",
            results = @Result(name = "success", type = "dispatcher", location = "/BookInformation.jsp"))
    public String executeBookInformation(){return "success";}
    public BookProfile getBookInformation(){
        return asi.findBookProfile((int)ActionContext.getContext().get("bookid"));
    }

}
