package action;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import entity.Borrower;
import entity.BorrowerType;
import entity.Record;
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
    private BorrowerType type;
    ActionContext ac = ActionContext.getContext();
    Map<String,Object> sess = ac.getSession();
    private int someoneId;

    @Autowired
    AdminService asi;
    @Autowired
    UserService usi;

    //ç”¨æˆ·æ³¨å†Œ
    @Action(value = "BorrowerRegister",
            results = {@Result(name = "success", type = "dispatcher", location = "/BorrowerLogIn.jsp"),
                    @Result(name = "fall", type = "dispatcher", location = "/BorrowerRegister.jsp")})
    public String UserRegister(){
        Borrower build = Borrower.builder().name(username).password(password).type(type).build();
        if(asi.addUser(build) == null){
            addActionError("ÓÃ»§ÃûÒÑ´æÔÚ£¬ÇëÖØĞÂÊäÈëÓÃ»§Ãû¡£");
            return "fall";
        }else {
            return "success";
        }
    }


    //ç”¨æˆ·ç™»å…¥
    @Action(value = "BorrowerLogIn",
            results = {@Result(name = "success", type = "dispatcher", location = "/Main.jsp" ),
                    @Result(name = "fall", type = "dispatcher", location = "/BorrowerLogIn.jsp" )})
    public String UserLogIn(){
        if(usi.login(username,password) == null){
            addActionError("ÓÃ»§Ãû»òÃÜÂë´íÎó£¬ÇëÖØĞÂÊäÈë¡£");
            return "fall";
        }else{
            borrower = usi.login(username,password);
            sess.put("userid",borrower.getId());
            return "success";
        }
    }


    //ç”¨æˆ·ç™»å‡º
    @Action(value = "BorrowerLogOut",
            results = @Result(name = "success", type = "dispatcher", location = "/First.jsp" ))
    public String UserLogOut(){
        sess.clear();
        return "success";
    }



    //ç”¨æˆ·æ›´æ–°ä¿¡æ¯
    @Action(value = "BorrowerUpdate",
            results = @Result(name = "success", type = "dispatcher", location = "/UpdateSuccess.jsp"))
    public String UserUpdate(){
        borrower = asi.findUser((int)sess.get("userid"));
        borrower.setPassword(password);
        usi.update(borrower);
        return "success";
    }



    //ç”¨æˆ·å€Ÿä¹¦(not test)
    @Action(value = "BorrowBook",
            results = {@Result(name = "success", type = "dispatcher", location = "/BorrowBookSuccess.jsp"),
                    @Result(name = "fall", type = "dispatcher", location = "/BorrowBookFall.jsp")})
    public String BorrowBook(){
        int uid = (int)sess.get("userid");
        if(asi.findUser(uid).getType() == STUDENT){
            if(usi.findRecordOfSomeone(uid).size() > 8) {
                addActionMessage("æ‚¨æ‰€å€Ÿé˜…å›¾ä¹¦å·²è¾¾æœ€å¤§æ•°é‡,æ— æ³•ç»§ç»­å€Ÿé˜…ã€‚");
                return "fall";
            }else {
                usi.borrow(asi.findUser(uid),asi.findBookCopy((int)ac.get("bookid")));
                return "success";
            }
        }else{
            if(usi.findRecordOfSomeone(uid).size() > 12) {
                addActionMessage("æ‚¨æ‰€å€Ÿé˜…å›¾ä¹¦å·²è¾¾æœ€å¤§æ•°é‡,æ— æ³•ç»§ç»­å€Ÿé˜…ã€‚");
                return "fall";
            }else {
                usi.borrow(asi.findUser(uid),asi.findBookCopy((int)ac.get("bookid")));
                return "success";
            }
        }
    }


    //ç”¨æˆ·è¿˜ä¹¦(not test)
    @Action(value = "ReturnBook",
            results = @Result(name = "success", type = "dispatcher", location = "/ReturnBookSuccess.jsp"))
    public String ReturnBook(){
        usi.returnBack(asi.findUser((int)sess.get("userid")),asi.findBookCopy((int)ac.get("bookid")));
        return "success";
    }


    //ç”¨æˆ·å€Ÿä¹¦è®°å½•(not test)
    @Action(value = "FindMyRecord",
            results = @Result(name = "success", type = "dispatcher", location = "/MyRecord.jsp"))
    public String MyRecord(){
        List<Record> myRecord = usi.findRecordOfSomeone((int)sess.get("userid"));
        for(int i=0;i<myRecord.size();i++) {
            sess.put("MyRecord" + i,myRecord.get(i));
        }
        return "success";
    }


    //AdminAction(not test)
    @Action(value = "FindSomeoneRecord",
            results = @Result(name = "success", type = "dispatcher", location = "/SomeoneRecord.jsp"))
    public String SomeoneRecord(){
        List<Record> SomeoneRecord = usi.findRecordOfSomeone(someoneId);
        for(int i=0;i<SomeoneRecord.size();i++) {
            sess.put("SomeRecord" + i,SomeoneRecord.get(i));
        }
        return "success";
    }




}
