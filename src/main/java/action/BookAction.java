package action;

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

@Controller
@ParentPackage("struts-default")
@Namespace("/")
@Data
public class BookAction extends ActionSupport {
    private long id;
    private String bookname;
    private String author;
    private String type;
    private LocalDate date;
    private Double price;
    private int number;

    @Autowired
    AdminService asi;
    @Autowired
    UserService usi;

    @Action(value = "AddBook",
            results = {@Result(name = "success", type = "dispatcher", location = "/AddBookSuccess.jsp"),
                    @Result(name = "fall", type = "dispatcher", location = "/AddBook.jsp")})
    public String AddBook(){
        BookProfile build = BookProfile.builder().isbn(id).name(bookname).author(author).type(type).price(price).issueOn(LocalDate.now()).build();
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
            results = @Result(name = "success", type = "dispatcher", location = "/UpdateBook.jsp"))
    public String UpdateBook(){
        BookProfile build = BookProfile.builder().isbn(id).name(bookname).author(author).price(price).
                            type(type).issueOn(LocalDate.now()).build();
        asi.addBookProfile(build);
        for(int i=0; i<number; i++){
            asi.addBookCopy(BookCopy.builder().profile(build).build());
        }
        addActionMessage("更新图书成功。");
        return "success";
    }


}
