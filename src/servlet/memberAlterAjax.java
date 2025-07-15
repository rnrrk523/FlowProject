package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.DepartmentDao;
import dao.MemberDao;
import dto.DepartmentDto;

@WebServlet("/memberAlterAjax")
public class memberAlterAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int companyIdx = Integer.parseInt(request.getParameter("companyIdx"));
		int memberIdx = Integer.parseInt(request.getParameter("memberIdx"));
		String name = request.getParameter("name");
		String departmentName = request.getParameter("departmentName");
		String position = request.getParameter("position");
		String phone = request.getParameter("phone");
		String pwResetYN = request.getParameter("pwResetYN");
		DepartmentDao dDao = new DepartmentDao();
		
		MemberDao mDao = new MemberDao();
		if(pwResetYN.equals("Y")) {
			try {
				mDao.resetMemberPw(memberIdx);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		ArrayList<DepartmentDto> departmentList = null;
		try {
			departmentList = dDao.getDepartmentInfo(companyIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		int departmentIdx = 0;
		for(DepartmentDto dto : departmentList) {
			if(dto.getName().equals(departmentName)) {
				departmentIdx = dto.getDepartmentIdx();
			}
		}
		
		if(departmentIdx != 0) {
			try {
				mDao.setMemberInfo(memberIdx, name, departmentIdx, position, phone);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else {
			try {
				mDao.setMemberInfo(memberIdx, name, null, position, phone);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
}