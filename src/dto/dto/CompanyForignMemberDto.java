package dto;

public class CompanyForignMemberDto {
	private int memberIdx;
	public CompanyForignMemberDto(int memberIdx) {
		this.memberIdx = memberIdx;
	}
	public int getMemberIdx() {
		return memberIdx;
	}
	public void setMemberIdx(int memberIdx) {
		this.memberIdx = memberIdx;
	}
}
