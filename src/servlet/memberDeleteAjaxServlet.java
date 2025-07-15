package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import dao.AdminChangeHistoryDao;
import dao.MemberDao;
import dto.MemberCompanyDepartmentDto;

@WebServlet("/memberDeleteAjaxServlet")
public class memberDeleteAjaxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int memberIdx = Integer.parseInt(request.getParameter("memberIdx"));
		int changerIdx = Integer.parseInt(request.getParameter("changerIdx"));
		
		MemberDao mDao = new MemberDao();
		MemberCompanyDepartmentDto memberInfo = null;
		try {
			memberInfo = mDao.getMemberInfo(memberIdx);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		AdminChangeHistoryDao adao = new AdminChangeHistoryDao();
		String targetName = memberInfo.getName();
		String targetEmail = memberInfo.getEmail();
		String target = targetName+"("+targetEmail+")";
		try {
			adao.addAdminChangeRecord(changerIdx, "사용자 관리", "계정 삭제", target, "계정 삭제");
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		
		try {
			mDao.deleteMember(memberIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("email", memberInfo.getEmail());
		
		try {
			mDao.deleteMember(memberIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		out.println(jsonObj);
	}
}