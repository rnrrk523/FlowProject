package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.AccountEmailMemberShipAction;
import action.AccountMemberShipAction;
import action.Action;
import action.AdminPage10Action;
import action.AdminPage11Action;
import action.AdminPage12Action;
import action.AdminPage13Action;
import action.AdminPage14Action;
import action.AdminPage15Action;
import action.AdminPage1Action;
import action.AdminPage2Action;
import action.AdminPage3Action;
import action.AdminPage4Action;
import action.AdminPage5Action;
import action.AdminPage6Action;
import action.AdminPage7Action;
import action.AdminPage8Action;
import action.AdminPage9Action;
import action.CompanyAction;
import action.DashboardAction;
import action.EmailAction;
import action.EmailPinAction;
import action.FeedAction;
import action.LoginAction;
import action.MyProjectAction;
import action.ProjectAlarmAction;
import action.ProjectCalrendarAction;
import action.ProjectFolderAction;
import action.PublicProjectAction;
import action.SideBookmarkAction;
import action.SideMyBoardAction;
import action.TaskAction;
import action.UserImformationAction;


@WebServlet("/Controller")
public class Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String command = request.getParameter("command");
		Action action = null;
		switch(command) {
		case "FEED": action = new FeedAction(); break;
		case "Myprojects": action = new MyProjectAction(); break;
		case "Task": action = new TaskAction(); break;
		case "Dashboard": action = new DashboardAction(); break;
		case "ProjectFolder": action = new ProjectFolderAction(); break;
		case "Login": action = new LoginAction(); break;
		case "AccountMemberShip": action = new AccountMemberShipAction(); break;
		case "AccountEmailMemberShip": action = new AccountEmailMemberShipAction(); break;
		case "account-email" : action = new EmailAction(); break;
		case "account-emailPin" : action = new EmailPinAction(); break;
		case "account-userImformation" : action = new UserImformationAction(); break;
		case "account-company" : action = new CompanyAction(); break;
		case "admin_page1":
			action = new AdminPage1Action();
			break;
		case "admin_page2":
			action = new AdminPage2Action();
			break;
		case "admin_page3":
			action = new AdminPage3Action();
			break;
		case "admin_page4":
			action = new AdminPage4Action();
			break;
		case "admin_page5":
			action = new AdminPage5Action();
			break;
		case "admin_page6":
			action = new AdminPage6Action();
			break;
		case "admin_page7":
			action = new AdminPage7Action();
			break;
		case "admin_page8":
			action = new AdminPage8Action();
			break;
		case "admin_page9":
			action = new AdminPage9Action();
			break;
		case "admin_page10":
			action = new AdminPage10Action();
			break;
		case "admin_page11":
			action = new AdminPage11Action();
			break;
		case "admin_page12":
			action = new AdminPage12Action();
			break;
		case "admin_page13":
			action = new AdminPage13Action();
			break;
		case "admin_page14":
			action = new AdminPage14Action();
			break;
		case "admin_page15":
			action = new AdminPage15Action();
			break;
		case "project_alarm":
			action = new ProjectAlarmAction();
			break;
		case "project_calendar":
			action = new ProjectCalrendarAction();
			break;
		case "sidetab_bookmark":
			action = new SideBookmarkAction();
			break;
		case "sidetab_myboard":
			action = new SideMyBoardAction();
			break;
		case "public_project":
			action = new PublicProjectAction();
			break;
		}
		action.execute(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		doGet(request, response);
	}

}
