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

import java.util.List;
import java.util.stream.Collectors;

@Controller
@ParentPackage("struts-default")
@Namespace("/")
@Data
public class ManageStockAction extends ActionSupport {
    @Autowired
    private AdminService adminService;

    private long isbn;
    private Integer addCopies;
    private Integer subCopies;

    @Action(value = "ManageStock",
            results = {@Result(name = "success", type = "redirectAction", location = "Admin"),
                       @Result(name = "error", type = "dispatcher", location = "/uniErr.jsp")})
    public String execute() {
        BookProfile bookProfile = adminService.findBookProfile(isbn);

        if (addCopies != null) {
            for (int i = 0; i < addCopies; i++)
                adminService.addBookCopy(BookCopy.builder().profile(bookProfile).build());
        } else if (subCopies != null) {
            List<BookCopy> available = bookProfile.getCopies().stream().filter(copy -> copy.getBorrower() == null).collect(Collectors.toList());
            if (available.size() < subCopies) {
                addActionMessage("not enough copies.");
                return "error";
            }
            for (int i = 0; i < subCopies; i++)
                adminService.removeBookCopy(available.get(i));
        }

        return "success";
    }
}
