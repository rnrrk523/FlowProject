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

import dao.CompanyDao;
import dto.FileDownloadRecordDto;

@WebServlet("/fileDownRecordSearchAjaxServlet")
public class fileDownRecordSearchAjaxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int companyIdx = Integer.parseInt(request.getParameter("companyIdx"));
		String standard = request.getParameter("standard");
		String str = request.getParameter("str");
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		
		CompanyDao cDao = new CompanyDao();
		ArrayList<FileDownloadRecordDto> fileDownRecordList = new ArrayList<FileDownloadRecordDto>();
		try {
			fileDownRecordList = cDao.getFileDownloadRecord(companyIdx, standard, str, startDate, endDate);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		
		JSONArray jsonList = new JSONArray();
		for(FileDownloadRecordDto dto : fileDownRecordList) {
			JSONObject obj = new JSONObject();
			obj.put("downDate", dto.getDownDate());
			obj.put("fileName", dto.getFileName());
			obj.put("capacity", dto.getFileCapacity());
			obj.put("downloader", dto.getDownloader());
			jsonList.add(obj);
		}
		out.println(jsonList);
	}
}
