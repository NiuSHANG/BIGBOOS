package action;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import entity.Borrower;
import entity.BorrowerType;
import lombok.Data;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import service.AdminService;
import service.UserService;

import java.util.Map;

@Controller
@ParentPackage("struts-default")
@Namespace("/")
@Data
public class BorrowerAction extends ActionSupport {
    private Borrower borrower;
    private String username;
    private String password;
    private BorrowerType type;
    Map<String,Object> sess = ActionContext.getContext().getSession();

    @Autowired
    AdminService asi;
    @Autowired
    UserService usi;

    @Action(value = "BorrowerRegister",
            results = {@Result(name = "success", type = "dispatcher", location = "/BorrowLogIn.jsp"),
                    @Result(name = "fall", type = "dispatcher", location = "/BorrowerRegister.jsp")})
    public String UserRegister(){
        Borrower build = Borrower.builder().name(username).password(password).type(type).build();
        if(asi.addUser(build) == null){
            addActionError("用户名已存在，请重新输入用户名。");
            return "fall";
        }else {
            return "success";
        }
    }

    @Action(value = "BorrowerLogIn",
            results = {@Result(name = "success", type = "dispatcher", location = "/Main.jsp" ),
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

    @Action(value = "BorrowerUpdate",
            results = @Result(name = "success", type = "dispatcher", location = "/UpdateSuccess.jsp"))
    public String UserUpdate(){
        borrower = asi.findUser((int)sess.get("userid"));
        borrower.setPassword(password);
        usi.update(borrower);
        return "success";
    }




}
