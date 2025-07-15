package dto.dto;

public class ProjectUserFolder {
	private int folderIdx;
	private String name;
	public ProjectUserFolder(int folderIdx, String name) {
		this.folderIdx = folderIdx;
		this.name = name;
	}
	public int getFolderIdx() {
		return folderIdx;
	}
	public void setFolderIdx(int folderIdx) {
		this.folderIdx = folderIdx;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
}
