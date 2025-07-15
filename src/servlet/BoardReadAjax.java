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

import dao.BoardALLDao;
import dto.ProjectInviteViewDto;

@WebServlet("/BoardReadAjax")
public class BoardReadAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int boardIdx = Integer.parseInt(request.getParameter("boardIdx"));
		int projectIdx = Integer.parseInt(request.getParameter("projectIdx"));
		BoardALLDao dao = new BoardALLDao();
		int readCount = 0;
		int nonReadCount = 0;
		try {
			readCount = dao.ReadMemberCount(boardIdx);
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		try {
			nonReadCount = dao.NonReadMemberCount(projectIdx, boardIdx);
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		System.out.println(readCount);
		System.out.println(nonReadCount);
		response.setCharacterEncoding("utf-8");
 	    response.setContentType("application/json");
 	    PrintWriter out = response.getWriter();
 	    JSONArray array1 = new JSONArray();
 	    ArrayList<ProjectInviteViewDto> list = null;
 			   try {
				list = dao.ReadMember(boardIdx);
			} catch (Exception e) {
				e.printStackTrace();
			}
		   for(ProjectInviteViewDto dto : list) {
			   JSONObject obj1 = new JSONObject();
			   obj1.put("readCount",readCount);
			   obj1.put("nonReadCount",nonReadCount);
			   obj1.put("memberIdx",dto.getMemberIdx());
			   obj1.put("companyName",dto.getCompanyName());
			   obj1.put("departmentName",dto.getDepartmentName());
			   obj1.put("name",dto.getName());
			   obj1.put("position",dto.getPosition());
			   obj1.put("profileImg",dto.getProfileImg());
			   obj1.put("readDate",dto.getReadDate());
			   array1.add(obj1);
		   }
		   out.println(array1);
 	    
	}

}
