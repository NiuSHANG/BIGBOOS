package action;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import javax.sql.DataSource;

@Controller
@ParentPackage("struts-default")
@Namespace("/")
public class TestAction {
    @Autowired
    DataSource dataSource;

    @Action(value = "test",
            results = @Result(name = "success", type = "dispatcher", location = "/test.jsp"))
    public String execute() {
        return "success";
    }
}
