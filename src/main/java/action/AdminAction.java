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

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import java.util.stream.Collectors;


@Controller
@ParentPackage("struts-default")
@Namespace("/")
@Data
public class AdminAction extends ActionSupport{
    private Admin admin;
    private Borrower borrower;
    private BookProfile profile;
    private BookCopy copy;

    Map<String,Object> sess = ActionContext.getContext().getSession();
    
    private int copyId;
    private int userId;
    private int adminId;
    private Long bookId;
    private double price;
    private String bookName;
    private String bookType;
    private String userName;
    private String adminName;
    private String password;
    private String newPassword;
    private String rePassword;
    private String author;
    private String summary;
    private String issueOn;
    private BorrowerType userType;


    @Autowired
    AdminService asi;
    @Autowired
    UserService usi;

    
    @Action(value = "AdminLogIn",
            results = {@Result(name = "success", type = "redirectAction", location = "Admin"), // TODO verify
                    @Result(name = "fail", type = "dispatcher", location = "/AdminLogIn.jsp" )})
    public String AdminLogIn(){
        if(asi.login(adminName,password) == null){
            addActionError("用户名或密码错误，请重新输入。");
            return "fail";
        }else{
            sess.put("adminId",asi.login(adminName,password).getId());
            return "success";
        }
    }
    
    
    @Action(value = "AdminRegister",
            results = {@Result(name = "success", type = "dispatcher", location = "/AdminLogIn.jsp" ),
                    @Result(name = "fail", type = "dispatcher", location = "/AdminRegister.jsp" )})
    public String AddAdmin(){
    	Admin build = Admin.builder().name(adminName).password(password).build();
        if(asi.addAdmin(build) == null){
        	 addActionError("该管理员已存在，请重新输入用户名。");
        	return "fail";
        }else{
            addActionMessage("注册成功。");
            return "success";
        }
    }
    
    
    @Action(value = "RemoveAdmin",
            results = {@Result(name = "success", type = "dispatcher", location = "/Admin.jsp" ),
                    @Result(name = "fail", type = "dispatcher", location = "/RemoveAdmin.jsp" )})
    public String RemoveAdmin(){
    	admin = asi.findAdmin(adminId);

        if(asi.removeAdmin(admin) == false){
        	return "fail";
        }else{
            return "success";
        }
    }
    
    
    @Action(value = "RemoveUser",
            results = {@Result(name = "success", type = "redirectAction", location = "Admin" ),
                    @Result(name = "fail", type = "redirectAction", location = "Admin" )})
    public String RemoveUser(){
        borrower = asi.findUser(userId);
        if(asi.removeUser(borrower) == false){
        	return "fail";
        }else{
            return "success";
        }
    }
    
    
    @Action(value = "RemoveBookProfile",
            results = {@Result(name = "success", type = "redirectAction", location = "Admin" ),
                    @Result(name = "fail", type = "redirectAction", location = "Admin" )})
    public String RemoveBookProfile(){
    	profile = asi.findBookProfile(bookId);
        if(asi.removeBookProfile(profile) == false){
            addActionMessage("删除图书失败请重新操作。");
        	return "fail";
        }else{
            addActionMessage("删除图书成功。");
            return "success";
        }
    }
    
//
//    @Action(value = "RemoveBookCopy",
//            results = {@Result(name = "success", type = "dispatcher", location = "/Admin.jsp" ),
//                    @Result(name = "fail", type = "dispatcher", location = "/Admin.jsp" )})
//    public String RemoveBookCopy(){
//    	copy = asi.findBookCopy(1);
//        if(asi.removeBookCopy(copy) == false){
//            addActionMessage("删除图书失败请重新操作。");
//        	return "fail";
//        }else{
//            addActionMessage("删除图书成功。");
//            return "success";
//        }
//    }
    
    
    @Action(value = "UpdateAdmin",
            results = {@Result(name = "success", type = "redirectAction", location = "Admin"),
                        @Result(name = "fail", type = "redirectAction", location = "Admin")})
    public String UpdateAdmin(){
    	admin = asi.findAdmin((Integer) sess.get("adminId"));
    	if(admin.getPassword().equals(password)) {
    	        if(newPassword.equals(rePassword)) {
                    admin.setPassword(newPassword);
                    asi.updateAdmin(admin);
                    addActionMessage("修改成功。");
                    return "success";
                }else {
    	            return "fail";
                }
        }else {
    	    addActionMessage("密码错误，请重新操作。");
    	    return "fail";
        }
    }


	@Action(value = "UpdateBookProfile",
            results = {@Result(name = "success", type = "redirectAction", location = "Admin"),
                    @Result(name = "input", type = "dispatcher", location = "/uniErr.jsp")})
    public String UpdateBookProfile(){
        BookProfile bp = asi.findBookProfile(bookId);
        bp.setName(bookName);
        bp.setAuthor(author);
        bp.setIssueOn(LocalDate.parse(issueOn));
        bp.setType(bookType);
        bp.setSummary(summary);
        bp.setPrice(price);
//        asi.updateBookProfile(bookProfile);

        asi.updateBookProfile(bp);
        return "success";
    }

    @Action(value = "AdminAddUser",
            results = {@Result(name = "success", type = "redirectAction", location = "Admin"),
                    @Result(name = "fail", type = "redirectAction", location = "Admin")})
    public String AdminAddUser(){
        Borrower build = Borrower.builder().id(userId).name(userName).password(password).type(userType).build();
        if(asi.updateUser(build) == null){
            addActionError("用户名已存在，请重新输入。");
            return "fail";
        }else {
            addActionMessage("添加用户成功");
            return "success";
        }
    }

    @Action(value = "AdminUpdateUser",
            results = @Result(name = "success", type = "dispatcher", location = "/Admin.jsp"))
    public String AdminUpdateUser(){
        borrower = asi.findUser(userId);
        borrower.setPassword(password);
        borrower.setType(userType);
        usi.update(borrower);
        return "success";
    }


    @Action(value = "Admin",
            results = @Result(name = "success", type = "dispatcher", location = "/Admin.jsp"))
    public String execute() {
        initAvailableAndUnavailableProfilesOfIsbn();
        return "success";
    }

    public List<BookProfile> getBookInformation(){
        return asi.findBookByCriteria(new TreeMap<>());
    }
    public List<Record> getRecordInformation(){
        return asi.findRecordByCriteria(new TreeMap<>());
    }
    public List<Borrower> getUserInformation(){ return asi.findUserByCriteria(new TreeMap<>()); }

    private Map<Long, List<BookCopy>> availableProfilesOfIsbn;
    private Map<Long, List<BookCopy>> unavailableProfilesOfIsbn;
    private void initAvailableAndUnavailableProfilesOfIsbn() {
        availableProfilesOfIsbn = new HashMap<>();
        unavailableProfilesOfIsbn = new HashMap<>();
        asi.findBookByCriteria(new HashMap<>()).forEach(profile -> availableProfilesOfIsbn.put(profile.getIsbn(), profile.getCopies().stream().filter(copy -> copy.getBorrower() == null).collect(Collectors.toList())));
        asi.findBookByCriteria(new HashMap<>()).forEach(profile -> unavailableProfilesOfIsbn.put(profile.getIsbn(), profile.getCopies().stream().filter(copy -> copy.getBorrower() != null).collect(Collectors.toList())));
    }
}

