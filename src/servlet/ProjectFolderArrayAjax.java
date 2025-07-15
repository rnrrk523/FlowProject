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

import dao.ProjectALLDao;
import dto.MyProjectViewDto;

@WebServlet("/ProjectFolderArrayAjax")
public class ProjectFolderArrayAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = Integer.parseInt(request.getParameter("idx"));
	     int array = Integer.parseInt(request.getParameter("array"));
	     int filter = Integer.parseInt(request.getParameter("filter"));
	     int folderIdx = Integer.parseInt(request.getParameter("folderIdx"));
	    

	    ProjectALLDao pdao = new ProjectALLDao();
	    ArrayList<MyProjectViewDto> list = null;
	    try {
	        list = pdao.MyProjectViewFolderView(idx, array, filter,folderIdx);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    response.setCharacterEncoding("utf-8");
	    response.setContentType("application/json");
	    PrintWriter out = response.getWriter();
	    JSONArray array1 = new JSONArray();
	    int count = 0;
       for (MyProjectViewDto dto : list) {
           JSONObject obj1 = new JSONObject();
           obj1.put("projectIdx", dto.getProjectIdx());
           try {
				count = pdao.ProjectParticipantsNum(dto.getProjectIdx());
			} catch (Exception e) {
				e.printStackTrace();
			}
           obj1.put("ParticipantsNum", count);
           obj1.put("projectName", dto.getProjectName());
           obj1.put("projectColor", dto.getProjectColor());
           char favoriteYN = dto.getFavoritesYN();
           String favoriteYNString = Character.toString(favoriteYN);
           obj1.put("favoritesYN", favoriteYNString);
           obj1.put("CategoryIdx", dto.getCategoryIdx());
           char ApprovalYN = dto.getApprovalYN();
           String ApprovalYNString = Character.toString(ApprovalYN);
           obj1.put("ApprovalYN", ApprovalYNString);
           char CompanyProjectYN = dto.getCompanyProjectYN();
           String CompanyProjectYNString = Character.toString(CompanyProjectYN);
           obj1.put("CompanyProjectYN", CompanyProjectYNString);
           array1.add(obj1);
       }
	    out.println(array1);
	    
	}

}
