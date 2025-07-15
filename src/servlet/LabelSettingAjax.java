package servlet;

import java.io.BufferedReader;
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
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import dao.ProjectALLDao;
import dto.MemberProjectFolderDto;

@WebServlet("/LabelSettingAjax")
public class LabelSettingAjax extends HttpServlet {
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

    	// 'array' 값 처리
    	JSONArray arr1 = (JSONArray) json.get("array");
    	ArrayList<Integer> arrayList = new ArrayList<>();
    	for (Object obj : arr1) {
    	    if (obj instanceof Long) {
    	        arrayList.add(((Long) obj).intValue());
    	    } else {
    	        System.out.println("Warning: The object is not of type Long");
    	    }
    	}

    	// 'label' 값 처리
    	JSONArray labelsArray = (JSONArray) json.get("label");
    	ArrayList<Integer> labelsList = new ArrayList<>();
    	for (Object labelObj : labelsArray) {
    	    if (labelObj instanceof Long) {
    	        labelsList.add(((Long) labelObj).intValue());
    	    } else {
    	        System.out.println("Warning: The object is not of type Long in label array");
    	    }
    	}
    	
    	JSONArray NonlabelsArray = (JSONArray) json.get("Nonlabel");
    	ArrayList<Integer> NonlabelsList = new ArrayList<>();
    	for (Object labelObj : NonlabelsArray) {
    	    if (labelObj instanceof Long) {
    	        NonlabelsList.add(((Long) labelObj).intValue());
    	    } else {
    	        System.out.println("Warning: The object is not of type Long in label array");
    	    }
    	}

    	Long idx = (Long) json.get("idx");

    	System.out.println("arr1 (Project idxs): " + arr1);
    	System.out.println("Selected labels: " + labelsList);
    	System.out.println("Selected Nonlabels: " + NonlabelsList);
    	System.out.println("Idx from JSP: " + idx);

    	ProjectALLDao dao = new ProjectALLDao();
    	int idxs = Long.valueOf(idx).intValue();
    	System.out.println(idxs);
    	ArrayList<MemberProjectFolderDto> mpfdlist = null;
    	for (int i = 0; i < labelsList.size(); i++) {
    	    int label = labelsList.get(i);
    	    System.out.println("Processing label: " + label);

    	    for (int j = 0; j < arrayList.size(); j++) {
    	        int num = arrayList.get(j);
    	        System.out.println("Processing num: " + num);

    	        // 폴더 확인 (mpfdlist가 비어 있으면 중복체크 없이 바로 설정)
    	        try {
    	            mpfdlist = dao.folderviewCheck(idxs, num);
    	        } catch (Exception e1) {
    	            e1.printStackTrace();
    	        }

    	        // mpfdlist가 비어있을 경우에만 중복 체크 없이 folderSetting 실행
    	        if (mpfdlist == null || mpfdlist.isEmpty()) {
    	            // 중복 체크 없이 folderSetting 실행
    	            try {
    	                dao.folderSetting(label, idxs, num);
    	                System.out.println("folderSetting executed with label: " + label + ", idx: " + idxs + ", num: " + num);
    	            } catch (Exception e) {
    	                e.printStackTrace();
    	            }
    	        } else {
    	            // mpfdlist가 비어있지 않으면 중복 체크
    	            boolean isDuplicate = false;
    	            for (MemberProjectFolderDto dto : mpfdlist) {
    	                System.out.println("Comparing label: " + label + " with folderIdx: " + dto.getFloderIdx());
    	                if (label == (int)(dto.getFloderIdx())) {
    	                    System.out.println("Skipping folderSetting as label is already set.");
    	                    isDuplicate = true;
    	                    break;
    	                }
    	            }

    	            // 중복이 없다면 folderSetting 실행
    	            if (!isDuplicate) {
    	                try {
    	                    dao.folderSetting(label, idxs, num);
    	                    System.out.println("folderSetting executed with label: " + label + ", idx: " + idxs + ", num: " + num);
    	                } catch (Exception e) {
    	                    e.printStackTrace();
    	                }
    	            }
    	        }
    	    }
    	}
    	for (int i = 0; i < NonlabelsList.size(); i++) {
    	    int label = NonlabelsList.get(i);
    	    System.out.println("Processing label: " + label);

    	    for (int j = 0; j < arrayList.size(); j++) {
    	        int num = arrayList.get(j);
    	        System.out.println("Processing num: " + num);

    	        // 폴더 확인 (mpfdlist가 비어 있으면 중복체크 없이 바로 설정)
    	        try {
    	            mpfdlist = dao.folderviewCheck(idxs, num);
    	        } catch (Exception e1) {
    	            e1.printStackTrace();
    	        }

    	        // mpfdlist가 비어있을 경우에는 멈춤
    	        if (mpfdlist == null || mpfdlist.isEmpty()) {
    	            break;
    	        } else {
    	            // mpfdlist가 비어있지 않으면 중복 체크
    	            boolean isDuplicate = false;
    	            for (MemberProjectFolderDto dto : mpfdlist) {
    	                System.out.println("Comparing label: " + label + " with folderIdx: " + dto.getFloderIdx());
    	                if (label == (int)(dto.getFloderIdx())) {
    	                    isDuplicate = true;
    	                    try {
								dao.folderDeleteSetting(label, idxs, num);
							} catch (Exception e) {
								e.printStackTrace();
							}
    	                }
    	            }
    	            // 중복이 없다면 folderSetting 실행
    	            if (!isDuplicate) {
    	                break;
    	            }
    	        }
    	    }
    	}

    	response.setCharacterEncoding("utf-8");
    	response.setContentType("application/json");
    	PrintWriter out = response.getWriter();
    	out.println("{\"message\":\"완료\"}");
    }
}
