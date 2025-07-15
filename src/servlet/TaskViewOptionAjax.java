package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import dao.TaskALLDao;


@WebServlet("/TaskViewOptionAjax")
public class TaskViewOptionAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String codeArray = request.getParameter("codeArray");
		System.out.println(codeArray);
		int memberIdx = Integer.parseInt(request.getParameter("memberIdx"));
		TaskALLDao dao = new TaskALLDao();
        JSONParser parser = new JSONParser();
        JSONArray codesArray = null;
        try {
            codesArray = (JSONArray) parser.parse(codeArray);
        } catch (ParseException e) {
            e.printStackTrace();
            response.getWriter().write("{\"status\":\"error\", \"message\":\"JSON 파싱 오류\"}");
            return;
        }
        int[] codesArray2 = new int[codesArray.size()]; 
        for (int i = 0; i < codesArray.size(); i++) {
            Long codeValue = (Long) codesArray.get(i);  
            codesArray2[i] = codeValue.intValue();  
        }
        char code1 = 'N';char code2 = 'N';char code3 = 'N';char code4 = 'N';
        char code5 = 'N';char code6 = 'N';char code7 = 'N';char code8 = 'N';
        char code9 = 'N';char code10 = 'N';char code11 = 'N';
        for(int i = 0; i< codesArray2.length; i++) {
        	if(codesArray2[i] == 1) code1 = 'Y';
        	if(codesArray2[i] == 2) code2 = 'Y';
        	if(codesArray2[i] == 3) code3 = 'Y';
        	if(codesArray2[i] == 4) code4 = 'Y';
        	if(codesArray2[i] == 5) code5 = 'Y';
        	if(codesArray2[i] == 6) code6 = 'Y';
        	if(codesArray2[i] == 7) code7 = 'Y';
        	if(codesArray2[i] == 8) code8 = 'Y';
        	if(codesArray2[i] == 9) code9 = 'Y';
        	if(codesArray2[i] == 10) code10 = 'Y';
        	if(codesArray2[i] == 11) code11 = 'Y';
        }
        try {
			dao.UpdateViewSetting(code1,code2,code3,code4,code5,code6,code7,code8,code9,code10,code11,memberIdx);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
