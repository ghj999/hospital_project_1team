package vo;

import org.springframework.web.multipart.MultipartFile;

/*
CREATE TABLE notice (
	not_idx		 NUMBER(3)	 PRIMARY KEY,
	not_title		 VARCHAR2(300)	 NULL,
	not_content	 CLOB		 NULL,
	not_date		 DATE	 	 NULL,
	not_hits		 NUMBER(9)	 NULL,
	not_file		 VARCHAR2(200)	 NOT NULL
);

--시퀀스--
create sequence not_idx_seq;

 */

public class NoticeVO {
	public int not_idx, not_hits;
	public String not_title, not_content, not_date, not_file;
	private MultipartFile photo;
	
	public MultipartFile getPhoto() {
		return photo;
	}
	public void setPhoto(MultipartFile photo) {
		this.photo = photo;
	}
	public int getNot_idx() {
		return not_idx;
	}
	public void setNot_idx(int not_idx) {
		this.not_idx = not_idx;
	}
	public int getNot_hits() {
		return not_hits;
	}
	public void setNot_hits(int not_hits) {
		this.not_hits = not_hits;
	}
	public String getNot_title() {
		return not_title;
	}
	public void setNot_title(String not_title) {
		this.not_title = not_title;
	}
	public String getNot_content() {
		return not_content;
	}
	public void setNot_content(String not_content) {
		this.not_content = not_content;
	}
	public String getNot_date() {
		return not_date;
	}
	public void setNot_date(String not_date) {
		this.not_date = not_date;
	}
	public String getNot_file() {
		return not_file;
	}
	public void setNot_file(String not_file) {
		this.not_file = not_file;
	}
	
	
}
