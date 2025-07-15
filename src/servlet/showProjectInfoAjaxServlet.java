package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import dao.ProjectDao;
import dto.PermissionSettingDto;

@WebServlet("/showProjectInfoAjaxServlet")
public class showProjectInfoAjaxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int projectIdx = Integer.parseInt(request.getParameter("projectIdx"));
		
		ProjectDao pDao = new ProjectDao();
		PermissionSettingDto pDto = null;
		try {
			pDto = pDao.getPermissionSetting(projectIdx);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		
		JSONObject obj = new JSONObject();
		obj.put("pIdx", pDto.getpIdx());
		obj.put("pName", pDto.getpName());
		obj.put("commentGrant", pDto.getCommentGrant());
		obj.put("editPostGrant", pDto.getEditPostGrant());
		obj.put("postViewGrant", pDto.getPostViewGrant());
		obj.put("writingGrant", pDto.getWritingGrant());
		out.println(obj);
	}
}
