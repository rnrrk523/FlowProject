package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import dao.AdminChangeHistoryDao;
import dao.DepartmentDao;
import dao.MemberDao;
import dto.DepartmentDto;
import dto.MemberCompanyDepartmentDto;

@WebServlet("/memberAddAjax")
public class memberAddAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		MemberDao mdao = new MemberDao();
		int companyIdx = Integer.parseInt(request.getParameter("companyIdx"));
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String pw = request.getParameter("pw");
		String departmentName = request.getParameter("departmentName");
		String position = request.getParameter("position");
		String phone = request.getParameter("phone");
		int changerIdx = Integer.parseInt(request.getParameter("changerIdx"));
		
		
//		멤버 추가
		DepartmentDao dDao = new DepartmentDao();
		ArrayList<DepartmentDto> departmentList = null;
		try {
			departmentList = dDao.getDepartmentInfo(companyIdx);
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		int departmentIdx = 0;
		boolean addYN = false;
		if(departmentName != null) {
			for(DepartmentDto dto : departmentList) {
				if(departmentName.equals(dto.getName())) {
					departmentIdx = dto.getDepartmentIdx();
					try {
						mdao.addMember(companyIdx, name, email, pw, departmentIdx, position, phone);
						addYN = true;
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
			if(departmentIdx == 0) {
				try {
					mdao.addMember(companyIdx, name, email, pw, null, position, phone);
					addYN = true;
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}else {
			try {
				mdao.addMember(companyIdx, name, email, pw, null, position, phone);
				addYN = true;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		
//		관리자 변경 이력 추가
		int recentMemberIdx = 0;
		try {
			recentMemberIdx = mdao.getRecentMemberIdx(companyIdx);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		MemberCompanyDepartmentDto memberInfo = null;
		try {
			memberInfo = mdao.getMemberInfo(recentMemberIdx);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		String targetName = memberInfo.getName();
		String targetEmail = memberInfo.getEmail();
		String target = targetName+"("+targetEmail+")";
		
		AdminChangeHistoryDao adao = new AdminChangeHistoryDao();
		try {
			adao.addAdminChangeRecord(changerIdx, "사용자 관리", "사용자 등록", target, "");
		} catch (Exception e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		JSONObject obj = new JSONObject();
		obj.put("addYN", addYN);
		out.println(obj);
	}
}