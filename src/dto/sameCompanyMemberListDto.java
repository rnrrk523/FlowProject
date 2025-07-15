package dto;

public class sameCompanyMemberListDto {

		private int companyIdxresult;
		private String name;
		private String profileImg;
		private String companyName;
		private String memberIdx;
		public int getCompanyIdxresult() {
			return companyIdxresult;
		}
		public void setCompanyIdxresult(int companyIdxresult) {
			this.companyIdxresult = companyIdxresult;
		}
		public String getCompanyName() {
			return companyName;
		}
		public void setCompanyName(String companyName) {
			this.companyName = companyName;
		}
		public String getMemberIdx() {
			return memberIdx;
		}
		public void setMemberIdx(String memberIdx) {
			this.memberIdx = memberIdx;
		}
		public sameCompanyMemberListDto(int companyIdxresult, String name, String profileImg , String companyName , String memberIdx) {
			this.companyIdxresult = companyIdxresult;
			this.name = name;
			this.profileImg = profileImg;
			this.companyName = companyName;
			this.memberIdx = memberIdx;
		}
		public int getCompanyIdx() {
			return companyIdxresult;
		}
		public void setCompanyIdx(int companyIdxresult) {
			this.companyIdxresult = companyIdxresult;
		}
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		public String getProfileImg() {
			return profileImg;
		}
		public void setProfileImg(String profileImg) {
			this.profileImg = profileImg;
		}
		
}


