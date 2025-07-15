package jstl;

import dto.MemberCompanyDepartmentDto;

public class ProjectAdminInfo {
	private int projectIdx;
	private int adminCnt;
	private String adminName;
	private MemberCompanyDepartmentDto memberInfo;
	
	public ProjectAdminInfo(int projectIdx, int adminCnt, String adminName, MemberCompanyDepartmentDto memberInfo) {
		this.projectIdx = projectIdx;
		this.adminCnt = adminCnt;
		this.adminName = adminName;
		this.memberInfo = memberInfo;
	}
	
	public int getProjectIdx() {
		return projectIdx;
	}
	public void setProjectIdx(int projectIdx) {
		this.projectIdx = projectIdx;
	}
	public int getAdminCnt() {
		return adminCnt;
	}
	public void setAdminCnt(int adminCnt) {
		this.adminCnt = adminCnt;
	}
	public String getAdminName() {
		return adminName;
	}
	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}
	public MemberCompanyDepartmentDto getMemberInfo() {
		return memberInfo;
	}
	public void setMemberInfo(MemberCompanyDepartmentDto memberInfo) {
		this.memberInfo = memberInfo;
	}
}
