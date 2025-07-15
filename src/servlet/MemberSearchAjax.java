package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import dao.MemberDao;
import dao.ProjectALLDao;
import dto.MemberDto;
import dto.ProjectMemberViewDto;


@WebServlet("/MemberSearchAjax")
public class MemberSearchAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String searchMember = request.getParameter("searchMember");
		int projectIdx = Integer.parseInt(request.getParameter("projectIdx"));
		ProjectALLDao pdao = new ProjectALLDao();
		MemberDao Mdao = new MemberDao();
		
				ArrayList<MemberDto> list = null;
				try {
					list = pdao.TaskMemberSearch(projectIdx, searchMember);
				} catch (Exception e) {
					e.printStackTrace();
				}
				response.setCharacterEncoding("utf-8");
				response.setContentType("application/json");
				PrintWriter out = response.getWriter();
				JSONArray array1 = new JSONArray();
				for(MemberDto dto : list) {
					JSONObject obj1 = new JSONObject();
					ProjectMemberViewDto dto2 = null;
					try {
						dto2 = Mdao.projectMemberValueMemberIdx(dto.getMemberIdx(),projectIdx);
					} catch (Exception e) {
						e.printStackTrace();
					}
					obj1.put("profileIMG", dto2.getProfileImg());
					obj1.put("name", dto2.getName());
					obj1.put("companyName", dto2.getCompanyName());
					obj1.put("memberIdx", dto2.getMemberIdx());
					obj1.put("position", dto2.getPosition());
					obj1.put("departmentName", dto2.getDepartmentName());
					obj1.put("adminYN", dto2.getAdminYN()+"");
					array1.add(obj1);
				}
				out.println(array1);
		
	}

}
