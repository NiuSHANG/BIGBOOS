package action;

import lombok.Setter;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;
import service.AdminService;

import javax.imageio.ImageIO;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;

public class ImageAction {
    @Setter
    private Long isbn;
    @Autowired
    private AdminService asi;

    @Action(value = "Image",
            results = @Result(name = "success", type = "stream", params = {
                    "contentType", "image/png",
                    "inputName", "image"
            }))
    public String execute() {
        return "success";
    }
    public InputStream getImage() throws IOException {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        ImageIO.write(asi.getCoverImage(isbn), "png", baos);
        return new ByteArrayInputStream(baos.toByteArray());
    }
}
