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
import dto.MemberCompanyDepartmentDto;

@WebServlet("/memberSearch2Ajax")
public class memberSearch2Ajax extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		int companyIdx = Integer.parseInt(request.getParameter("companyIdx"));
		String standard = request.getParameter("standard");
		String str = request.getParameter("str");
		String stateStr = request.getParameter("stateStr");
		System.out.println(stateStr);
		MemberDao mDao = new MemberDao();
		ArrayList<MemberCompanyDepartmentDto> memberList = null;
		try {
			memberList = mDao.getMemberSearch(companyIdx, standard, str, stateStr);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		
		JSONArray jsonList = new JSONArray();
		for(MemberCompanyDepartmentDto dto : memberList) {
			JSONObject obj = new JSONObject();
			obj.put("memberIdx", dto.getMemberIdx());
			obj.put("companyName", dto.getCompanyName());
			obj.put("name", dto.getName());
			obj.put("departmentName", dto.getDepartmentName());
			obj.put("position", dto.getPosition());
			obj.put("email", dto.getEmail());
			obj.put("phone", dto.getPhone());
			obj.put("hireDate", dto.getHireDate().substring(0, 16));
			obj.put("state", dto.getState());
			obj.put("adminYN", (dto.getAdminYN()+""));
			jsonList.add(obj);
		}
		out.println(jsonList);
	}
}
