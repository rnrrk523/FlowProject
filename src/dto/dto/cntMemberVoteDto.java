package dto;

public class cntMemberVoteDto {
	private int countPerContent;
	private int voteContent;
	public cntMemberVoteDto(int countPerContent, int voteContent) {
		this.countPerContent = countPerContent;
		this.voteContent = voteContent;
	}
	public int getCountPerContent() {
		return countPerContent;
	}
	public void setCountPerContent(int countPerContent) {
		this.countPerContent = countPerContent;
	}
	public int getVoteContent() {
		return voteContent;
	}
	public void setVoteContent(int voteContent) {
		this.voteContent = voteContent;
	}

}
