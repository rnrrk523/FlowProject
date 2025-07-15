package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import dao.MemberDao;
import dao.ProjectALLDao;
import dto.MemberDto;

@WebServlet("/InviteProjectAjax")
public class InviteProjectAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int projectIdx = Integer.parseInt(request.getParameter("projectIdx"));
		String pmnoValuesJson = request.getParameter("pmnoValues");
        JSONParser parser = new JSONParser();
        ProjectALLDao dao = new ProjectALLDao();
        MemberDao mdao = new MemberDao();
        List<Integer> pmnoValues = new ArrayList<>();
        try {
            JSONArray jsonArray = (JSONArray) parser.parse(pmnoValuesJson);
            
            for (Object obj : jsonArray) {
            	pmnoValues.add(((Long) obj).intValue());
            }
        } catch (ParseException e) {
            e.printStackTrace();
            response.getWriter().write("Error parsing JSON");
        }
        int count = 0;
        for (int i = 0; i < pmnoValues.size(); i++) {
            int value = pmnoValues.get(i);
            try {
				count = dao.searchMemberProject(projectIdx,value);
			} catch (Exception e) {
				e.printStackTrace();
			}
            if(count == 0) {
            	MemberDto dto = null;
            	try {
            		dto = mdao.GetProfile(value);
            		int projectColor = 12;
            		if(dto.getProjectColorFix() == 'N') {
            			projectColor = (int) (Math.random() * 12) + 1;
            		}
					dao.InviteProjectMember(projectIdx, value, projectColor);
				} catch (Exception e) {
					e.printStackTrace();
				}
            }
        }
		try {
			dao.ProjectUpdate(projectIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
