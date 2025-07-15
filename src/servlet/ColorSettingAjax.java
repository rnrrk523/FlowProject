package servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;


import dao.ProjectALLDao;

@WebServlet("/ColorSettingAjax")
public class ColorSettingAjax extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BufferedReader reader = request.getReader();
        StringBuilder jsonString = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            jsonString.append(line);
        }

        JSONParser parser = new JSONParser();
        JSONObject json = null;
        try {
            json = (JSONObject) parser.parse(jsonString.toString());
        } catch (ParseException e2) {
            e2.printStackTrace();
        }

        String arrayString = (String) json.get("array");

        JSONParser arrayParser = new JSONParser();
        JSONArray arr1 = null;
        try {
            arr1 = (JSONArray) arrayParser.parse(arrayString);
        } catch (ParseException e1) {
            e1.printStackTrace();
        }

        ArrayList<Integer> arrayList = new ArrayList<>();
        for (Object obj : arr1) {
            if (obj instanceof Long) {
                arrayList.add(((Long) obj).intValue());
            } else {
                System.out.println("Warning: The object is not of type Long");
            }
        }

        Long color = (Long) json.get("color");
        Long idx = (Long) json.get("idx");

        System.out.println("arr1 (Project idxs): " + arr1);
        System.out.println("Selected color: " + color);
        System.out.println("Idx from JSP: " + idx);

        ProjectALLDao dao = new ProjectALLDao();
        int num = 0;
        int colors = Long.valueOf(color).intValue();
        int idxs = Long.valueOf(idx).intValue();

        // 색상 변경된 프로젝트 정보
        List<Map<String, Object>> updatedProjects = new ArrayList<>();

        // arrayList에서 Integer 값 출력
        for (int i = 0; i < arrayList.size(); i++) {
            num = arrayList.get(i);
            try {
                // 색상 설정
                dao.colorSetting(colors, num, idxs);

                // 변경된 프로젝트 정보 저장
                Map<String, Object> projectInfo = new HashMap<>();
                projectInfo.put("projectIdx", num);
                projectInfo.put("newColor", colors);
                updatedProjects.add(projectInfo);

            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // 변경된 프로젝트 정보를 JSON으로 반환
        JSONObject responseJson = new JSONObject();
        responseJson.put("status", "success");
        responseJson.put("projects", updatedProjects);

        // JSON 응답
        response.setContentType("application/json");
        response.getWriter().write(responseJson.toJSONString());
    }
}
