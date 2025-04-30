package vo;

import org.springframework.web.multipart.MultipartFile;

/*
CREATE TABLE patBoard (
	board_idx	 NUMBER(10)	 PRIMARY KEY,
	pat_idx		 NUMBER(3)	 NOT NULL,
	board_title	 VARCHAR2(300)	 NULL,
	board_content	 CLOB	 	 NULL,
	board_file	 VARCHAR2(200)	 NULL,
	board_email	 VARCHAR2(200)	 NULL,
	board_phone	 VARCHAR2(20)	 NULL,
	board_type	 VARCHAR2(100)	 NULL,
	board_date	 DATE		 NULL,
	board_name	 VARCHAR2(30)	 NULL
);
	
-- 시퀀스 --
create sequence board_idx_seq;
	
*/

public class PatBoardVO {

	private int board_idx, pat_idx;
	private String board_title, board_content, board_file, board_email, 
							board_phone, board_type, board_date, board_name;

	private MultipartFile photo;
	
	
	public MultipartFile getPhoto() {
		return photo;
	}
	public void setPhoto(MultipartFile photo) {
		this.photo = photo;
	}
	
	public String getBoard_name() {
		return board_name;
	}
	public void setBoard_name(String board_name) {
		this.board_name = board_name;
	}
	public String getBoard_date() {
		return board_date;
	}
	public void setBoard_date(String board_date) {
		this.board_date = board_date;
	}
	public String getBoard_phone() {
		return board_phone;
	}
	public void setBoard_phone(String board_phone) {
		this.board_phone = board_phone;
	}
	public int getBoard_idx() {
		return board_idx;
	}
	public void setBoard_idx(int board_idx) {
		this.board_idx = board_idx;
	}
	public int getPat_idx() {
		return pat_idx;
	}
	public void setPat_idx(int pat_idx) {
		this.pat_idx = pat_idx;
	}
	public String getBoard_title() {
		return board_title;
	}
	public void setBoard_title(String board_title) {
		this.board_title = board_title;
	}
	public String getBoard_content() {
		return board_content;
	}
	public void setBoard_content(String board_content) {
		this.board_content = board_content;
	}
	public String getBoard_file() {
		return board_file;
	}
	public void setBoard_file(String board_file) {
		this.board_file = board_file;
	}
	public String getBoard_email() {
		return board_email;
	}
	public void setBoard_email(String board_email) {
		this.board_email = board_email;
	}
	public String getBoard_type() {
		return board_type;
	}
	public void setBoard_type(String board_type) {
		this.board_type = board_type;
	}
	
	
	
	
}
