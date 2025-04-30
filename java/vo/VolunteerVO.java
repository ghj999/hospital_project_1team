package vo;

import org.springframework.web.multipart.MultipartFile;

/*
 * 
-- 시퀀스 -- 
create sequence seq_volunteer_idx;

-- 테이블 --
CREATE TABLE volunteer (
	vol_idx		 	 NUMBER(3)	 	 primary key,
	vol_title		 VARCHAR2(300)	 ,
	vol_content	 	 CLOB		 	 ,
	vol_date 		 DATE			 ,
	vol_hits   		 NUMBER(9)	 	 ,
	vol_file		 VARCHAR2(200)	 NULL,
	ref				 NUMBER(3)		 ,
	step			 NUMBER(2)		 ,
	depth			 NUMBER(3)		 ,
	vol_start_date 	 DATE,
	vol_end_date  	 DATE	 
);

 */

public class VolunteerVO {
	private int vol_idx, vol_hits, ref, step, depth;
	private String vol_title, vol_content, vol_date, vol_file, vol_start_date, vol_end_date;
	private MultipartFile photo;
	private int pat_idx;
	
	public MultipartFile getPhoto() {
		return photo;
	}
	public void setPhoto(MultipartFile photo) {
		this.photo = photo;
	}
	public int getPat_idx() {
		return pat_idx;
	}
	public void setPat_idx(int pat_idx) {
		this.pat_idx = pat_idx;
	}
	public String getVol_start_date() {
		return vol_start_date;
	}
	public void setVol_start_date(String vol_start_date) {
		this.vol_start_date = vol_start_date;
	}
	public String getVol_end_date() {
		return vol_end_date;
	}
	public void setVol_end_date(String vol_end_date) {
		this.vol_end_date = vol_end_date;
	}
	public int getVol_idx() {
		return vol_idx;
	}
	public void setVol_idx(int vol_idx) {
		this.vol_idx = vol_idx;
	}
	public int getVol_hits() {
		return vol_hits;
	}
	public void setVol_hits(int vol_hits) {
		this.vol_hits = vol_hits;
	}
	public int getRef() {
		return ref;
	}
	public void setRef(int ref) {
		this.ref = ref;
	}
	public int getStep() {
		return step;
	}
	public void setStep(int step) {
		this.step = step;
	}
	public int getDepth() {
		return depth;
	}
	public void setDepth(int depth) {
		this.depth = depth;
	}
	public String getVol_title() {
		return vol_title;
	}
	public void setVol_title(String vol_title) {
		this.vol_title = vol_title;
	}
	public String getVol_content() {
		return vol_content;
	}
	public void setVol_content(String vol_content) {
		this.vol_content = vol_content;
	}
	public String getVol_date() {
		return vol_date;
	}
	public void setVol_date(String vol_date) {
		this.vol_date = vol_date;
	}
	public String getVol_file() {
		return vol_file;
	}
	public void setVol_file(String vol_file) {
		this.vol_file = vol_file;
	}
	
	
}
