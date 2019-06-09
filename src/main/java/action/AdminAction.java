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
import java.util.TreeMap;



@Controller
@ParentPackage("struts-default")
@Namespace("/")
@Data
public class AdminAction extends ActionSupport{
    private Admin admin;
    private Borrower borrower;
    private BookProfile profile;
    private BookCopy copy;

    private BorrowerType type;
    Map<String,Object> sess = ActionContext.getContext().getSession();
    
    private int copyid;
    private double price;
    private String booktype;
    private String username;
    private String password;
    private int userid;
    private String newpassword;

    @Autowired
    AdminService asi;
    @Autowired
    UserService usi;

    
    @Action(value = "AdminLogin",
            results = {@Result(name = "success", type = "dispatcher", location = "/Admin.jsp"),
                    @Result(name = "fall", type = "dispatcher", location = "/AdminLogIn.jsp" )})
    public String AdminLogIn(){
        if(asi.login(username,password) == null){
            addActionError("用户名或密码错误，请重新输入。");
            return "fail";
        }else{
        	admin = asi.login(username,password);
            sess.put("adminid",admin.getId());
            return "success";
        }
    }
    
    
    @Action(value = "AddAdmin",
            results = {@Result(name = "success", type = "dispatcher", location = "/test.jsp" ),
                    @Result(name = "fall", type = "dispatcher", location = "/main.jsp" )})
    public String AddAdmin(){
    	Admin build = Admin.builder().name(username).password(password).build();
        if(asi.addAdmin(build) == null){
        	 addActionError("该管理员已存在，请重新输入用户名。");
        	return "fall";
        }else{
            return "success";
        }
    }
    
    
    @Action(value = "RemoveAdmin",
            results = {@Result(name = "success", type = "dispatcher", location = "/Admin.jsp" ),
                    @Result(name = "fall", type = "dispatcher", location = "/RemoveAdmin.jsp" )})
    public String RemoveAdmin(){
    	admin = asi.findAdmin((int)sess.get("adminid"));

        if(asi.removeAdmin(admin) == false){
        	return "fall";
        }else{
            return "success";
        }
    }
    
    
    @Action(value = "RemoveUser",
            results = {@Result(name = "success", type = "dispatcher", location = "/Admin.jsp" ),
                    @Result(name = "fall", type = "dispatcher", location = "/Admin.jsp" )})
    public String RemoveUser(){
        borrower = asi.findUser((int)ActionContext.getContext().get("userid"));
        if(asi.removeUser(borrower) == false){
        	return "fall";
        }else{
            return "success";
        }
    }
    
    
    @Action(value = "RemoveBookProfile",
            results = {@Result(name = "success", type = "dispatcher", location = "/Admin.jsp" ),
                    @Result(name = "fall", type = "dispatcher", location = "/Admin.jsp" )})
    public String RemoveBookProfile(){
    	profile = asi.findBookProfile((int)sess.get("bookid"));
        if(asi.removeBookProfile(profile) == false){
            addActionMessage("删除图书失败请重新操作。");
        	return "fall";
        }else{
            addActionMessage("删除图书成功。");
            return "success";
        }
    }
    
    
    @Action(value = "RemoveBookCopy",
            results = {@Result(name = "success", type = "dispatcher", location = "/Admin.jsp" ),
                    @Result(name = "fall", type = "dispatcher", location = "/Admin.jsp" )})
    public String RemoveBookCopy(){
    	copy = asi.findBookCopy(1);
        if(asi.removeBookCopy(copy) == false){
            addActionMessage("删除图书失败请重新操作。");
        	return "fall";
        }else{
            addActionMessage("删除图书成功。");
            return "success";
        }
    }
    
    
    @Action(value = "UpdateAdmin",
            results = {@Result(name = "success", type = "dispatcher", location = "/Admin.jsp"),
                        @Result(name = "fall", type = "dispatcher", location = "/Admin.jsp")})
    public String UpdateAdmin(){
    	admin = asi.findAdmin((int)sess.get("adminid"));
    	if(admin.getPassword().equals(password)) {
            admin.setPassword(newpassword);
            asi.updateAdmin(admin);
            addActionMessage("修改成功。");
            return "success";
        }else {
    	    addActionMessage("密码错误，请重新操作。");
    	    return "fall";
        }
    }


	@Action(value = "UpdateBookProfile",
            results = @Result(name = "success", type = "dispatcher", location = "/BookProfileList.jsp"))
    public String UpdateBookProfile(){
    	profile = asi.findBookProfile((int)sess.get("BookProfileid"));
    	asi.updateBookProfile(profile);
        return "success";
    }

    @Action(value = "AdminAddUser",
            results = {@Result(name = "success", type = "dispatcher", location = "/Admin.jsp"),
                    @Result(name = "fall", type = "dispatcher", location = "/Admin.jsp")})
    public String AdminAddUser(){
        Borrower build = Borrower.builder().id(userid).name(username).password(password).type(type).build();
        if(asi.addUser(build) == null){
            addActionError("用户名已存在，请重新输入。");
            return "fall";
        }else {
            asi.updateUser(build);
            addActionMessage("添加用户成功");
            return "success";
        }
    }

    @Action(value = "AdminUpdateUser",
            results = @Result(name = "success", type = "dispatcher", location = "/Admin.jsp"))
    public String AdminUpdateUser(){
        borrower = asi.findUser((int)ActionContext.getContext().get("userid"));
        borrower.setPassword(password);
        usi.update(borrower);
        return "success";
    }


    @Action(value = "Admin",
            results = @Result(name = "success", type = "dispatcher", location = "/Admin.jsp"))
    public String execute(){return "success";}

    public List<BookProfile> getBookInformation(){
        return asi.findBookByCriteria(new TreeMap<>());
    }
    public List<Record> getRecordInformation(){
        return asi.findRecordByCriteria(new TreeMap<>());
    }
    public List<Borrower> getUserInformation(){ return asi.findUserByCriteria(new TreeMap<>()); }

}

