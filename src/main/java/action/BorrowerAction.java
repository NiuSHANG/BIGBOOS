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
    private String userName;
    private String password;
    private int userId;
    private int id;
    private BorrowerType type;
    private List<Record> records;

    private int bookId;
    private int copyId;

    Map<String,Object> sess = ActionContext.getContext().getSession();

    @Autowired
    AdminService asi;
    @Autowired
    UserService usi;

    //用户注册
    @Action(value = "BorrowerRegister",
            results = {@Result(name = "success", type = "dispatcher", location = "/BorrowerLogIn.jsp"),
                    @Result(name = "fail", type = "dispatcher", location = "/BorrowerRegister.jsp")})
    public String UserRegister(){
        Borrower build = Borrower.builder().name(userName).password(password).type(type).id(userId).build();
        if(usi.register(build) == null){
//            addActionError("用户名已存在，请重新输入。");
            return "fail";
        }else {
            return "success";
        }
    }


    //用户登入
    @Action(value = "BorrowerLogIn",
            results = {@Result(name = "success", type = "dispatcher", location = "/MainFirst.jsp" ),
                    @Result(name = "fail", type = "dispatcher", location = "/BorrowerLogIn.jsp" )})
    public String UserLogIn(){
        if(usi.login(userName,password) == null){
            addActionError("用户名或密码错误，请重新输入。");
            return "fail";
        }else{
            borrower = usi.login(userName,password);
            sess.put("userId",borrower.getId());
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
        borrower = asi.findUser((int)sess.get("userId"));
        borrower.setPassword(password);
        usi.update(borrower);
        return "success";
    }



    //用户借书(not test)
    @Action(value = "BorrowBook",
            results = {@Result(name = "success", type = "dispatcher", location = "/BorrowBookInformation.jsp"),
                    @Result(name = "fail", type = "dispatcher", location = "/BorrowBookInformation.jsp")})
    public String BorrowBook(){
        Borrower user = asi.findUser((int) sess.get("userId"));

        final int MAX_POSSIBLE = user.getType() == STUDENT ? 8 : 12;
        if (user.getBorrowed().size() > MAX_POSSIBLE) {
            addActionMessage("您所借阅图书已达最大数量,无法继续借阅。");
            return "fail";
        }

        BookProfile bookProfile = asi.findBookProfile(bookId);
        Optional<BookCopy> candidate = bookProfile.getCopies().stream().filter(p -> p.getBorrower() == null).findAny();

        if (!candidate.isPresent()) {
            addActionMessage("该书已被借完。");
            return "fail";
        }

        usi.borrow(user, candidate.get());
        addActionMessage("借阅成功。");
        //链接网页传值：bookId。
        return "success";
    }


    //用户还书(not test)
    @Action(value = "ReturnBook",
            results = @Result(name = "success", type = "dispatcher", location = "/ReturnBookSuccess.jsp"))
    public String ReturnBook(){
        usi.returnBack(asi.findUser((int) sess.get("userId")), asi.findBookCopy(copyId));

        //链接网页传值：bookId。
        return "success";
    }


    //用户借书记录(not test)
    @Action(value = "MyRecord",
            results = @Result(name = "success", type = "dispatcher", location = "/MyRecord.jsp"))
    public String execute(){return "success";}
    public List<Record> getMyRecord(){
        return usi.findRecordOfSomeone((int)sess.get("userId"));
    }


    //AdminAction(not test)
    @Action(value = "FindSomeoneRecord",
            results = @Result(name = "success", type = "dispatcher", location = "/SomeoneRecord.jsp"))
    public String SomeoneRecord(){
        records = usi.findRecordOfSomeone((int)sess.get("userId"));
        return "success";
    }




}
