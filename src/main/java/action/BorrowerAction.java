package action;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import entity.*;
import lombok.Data;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import service.AdminService;
import service.UserService;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import static entity.BorrowerType.STUDENT;

@Controller
@ParentPackage("struts-default")
@Namespace("/")
@Data
public class BorrowerAction extends ActionSupport {
    private Borrower borrower;
    private Record record;
    private String username;
    private String password;
    private int userid;
    private BorrowerType type;
    private List<Record> records;

    private int bookid;

    Map<String,Object> sess = ActionContext.getContext().getSession();

    @Autowired
    AdminService asi;
    @Autowired
    UserService usi;

    //用户注册
    @Action(value = "BorrowerRegister",
            results = {@Result(name = "success", type = "dispatcher", location = "/BorrowerLogIn.jsp"),
                    @Result(name = "fall", type = "dispatcher", location = "/BorrowerRegister.jsp")})
    public String UserRegister(){
        Borrower build = Borrower.builder().name(username).password(password).type(type).build();
        if(usi.register(build) == null){
//            addActionError("用户名已存在，请重新输入。");
            return "fall";
        }else {
            return "success";
        }
    }


    //用户登入
    @Action(value = "BorrowerLogIn",
            results = {@Result(name = "success", type = "dispatcher", location = "/MainFirst.jsp" ),
                    @Result(name = "fall", type = "dispatcher", location = "/BorrowerLogIn.jsp" )})
    public String UserLogIn(){
        if(usi.login(username,password) == null){
            addActionError("用户名或密码错误，请重新输入。");
            return "fall";
        }else{
            borrower = usi.login(username,password);
            sess.put("userid",borrower.getId());
            return "success";
        }
    }


    //用户登出
    @Action(value = "BorrowerLogOut",
            results = @Result(name = "success", type = "dispatcher", location = "/BorrowerLogIn.jsp" ))
    public String UserLogOut(){
        sess.clear();
        return "success";
    }



    //用户更新信息
    @Action(value = "BorrowerUpdate",
            results = @Result(name = "success", type = "dispatcher", location = "/UpdateSuccess.jsp"))
    public String UserUpdate(){
        borrower = asi.findUser((int)sess.get("userid"));
        borrower.setPassword(password);
        usi.update(borrower);
        return "success";
    }



    //用户借书(not test)
    @Action(value = "BorrowBook",
            results = {@Result(name = "success", type = "dispatcher", location = "/BorrowBookInformation.jsp"),
                    @Result(name = "fall", type = "dispatcher", location = "/BorrowBookInformation.jsp")})
    public String BorrowBook(){
        Borrower user = asi.findUser((int) sess.get("userid"));

        final int MAX_POSSIBLE = user.getType() == STUDENT ? 8 : 12;
        if (user.getBorrowed().size() > MAX_POSSIBLE) {
            addActionMessage("您所借阅图书已达最大数量,无法继续借阅。");
            return "fall";
        }

        BookProfile bookProfile = asi.findBookProfile(bookid);
        Optional<BookCopy> candidate = bookProfile.getCopies().stream().filter(p -> p.getBorrower() == null).findAny();

        if (!candidate.isPresent()) {
            addActionMessage("该书已被借完。");
            return "fall";
        }

        usi.borrow(user, candidate.get());
        addActionMessage("借阅成功。");
        //链接网页传值：bookid。
        return "success";
    }


    //用户还书(not test)
    @Action(value = "ReturnBook",
            results = @Result(name = "success", type = "dispatcher", location = "/ReturnBookSuccess.jsp"))
    public String ReturnBook(){
        usi.returnBack(asi.findUser(userid),asi.findBookCopy(bookid));
        //链接网页传值：bookid。
        return "success";
    }


    //用户借书记录(not test)
    @Action(value = "MyRecord",
            results = @Result(name = "success", type = "dispatcher", location = "/MyRecord.jsp"))
    public String execute(){return "success";}
    public List<Record> getMyRecord(){
        return usi.findRecordOfSomeone((int)sess.get("userid"));
    }


    //AdminAction(not test)
    @Action(value = "FindSomeoneRecord",
            results = @Result(name = "success", type = "dispatcher", location = "/SomeoneRecord.jsp"))
    public String SomeoneRecord(){
        records = usi.findRecordOfSomeone((int)sess.get("userid"));
        return "success";
    }




}
