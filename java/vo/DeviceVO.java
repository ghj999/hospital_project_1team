package vo;

import org.springframework.web.multipart.MultipartFile;

public class DeviceVO {
	private int dev_idx;
	private String dev_name, dev_content, dev_filename;
	private MultipartFile photo;
		
	
	public String getDev_filename() {
		return dev_filename;
	}
	public void setDev_filename(String dev_filename) {
		this.dev_filename = dev_filename;
	}
	public int getDev_idx() {
		return dev_idx;
	}
	public void setDev_idx(int dev_idx) {
		this.dev_idx = dev_idx;
	}
	public String getDev_name() {
		return dev_name;
	}
	public void setDev_name(String dev_name) {
		this.dev_name = dev_name;
	}
	public String getDev_content() {
		return dev_content;
	}
	public void setDev_content(String dev_content) {
		this.dev_content = dev_content;
	}
	public MultipartFile getPhoto() {
		return photo;
	}
	public void setPhoto(MultipartFile photo) {
		this.photo = photo;
	}	
}
