package vo;

/*
--환자테이블
CREATE TABLE patient (
		pat_idx		 NUMBER(3)	NOT NULL,
		pat_name	 VARCHAR2(30)	NOT NULL,
		pat_id		 VARCHAR2(100)	NOT NULL,
		pat_pwd		 VARCHAR2(100)	NOT NULL,
		pat_email 	 VARCHAR2(200)	NOT NULL,
		pat_address_post	 NUMBER(10)	NULL,
		pat_address_road	 VARCHAR2(100)	NULL,
		pat_address_detail	 VARCHAR2(100)	NULL,
		pat_phone	 VARCHAR2(20)	NULL,
		pat_phone2	 VARCHAR2(20)	NULL,
		pat_birthday	 DATE 		NULL,
		pat_gender	 VARCHAR2(10)	NOT NULL
);

--시퀀스
create sequence pat_idx_seq;
*/

public class PatientVO {
	
	private int pat_idx;
	private String pat_name, pat_id, pat_pwd, pat_email,
				pat_address_post, pat_address_road, pat_address_detail,
				pat_phone, pat_phone2, pat_birthday, pat_gender;
	
	public int getPat_idx() {
		return pat_idx;
	}
	public void setPat_idx(int pat_idx) {
		this.pat_idx = pat_idx;
	}
	public String getPat_name() {
		return pat_name;
	}
	public void setPat_name(String pat_name) {
		this.pat_name = pat_name;
	}
	public String getPat_id() {
		return pat_id;
	}
	public void setPat_id(String pat_id) {
		this.pat_id = pat_id;
	}
	public String getPat_pwd() {
		return pat_pwd;
	}
	public void setPat_pwd(String pat_pwd) {
		this.pat_pwd = pat_pwd;
	}
	public String getPat_email() {
		return pat_email;
	}
	public void setPat_email(String pat_email) {
		this.pat_email = pat_email;
	}
	public String getPat_address_post() {
		return pat_address_post;
	}
	public void setPat_address_post(String pat_address_post) {
		this.pat_address_post = pat_address_post;
	}
	public String getPat_address_road() {
		return pat_address_road;
	}
	public void setPat_address_road(String pat_address_road) {
		this.pat_address_road = pat_address_road;
	}
	public String getPat_address_detail() {
		return pat_address_detail;
	}
	public void setPat_address_detail(String pat_address_detail) {
		this.pat_address_detail = pat_address_detail;
	}
	public String getPat_phone() {
		return pat_phone;
	}
	public void setPat_phone(String pat_phone) {
		this.pat_phone = pat_phone;
	}
	public String getPat_phone2() {
		return pat_phone2;
	}
	public void setPat_phone2(String pat_phone2) {
		this.pat_phone2 = pat_phone2;
	}
	public String getPat_birthday() {
		return pat_birthday;
	}
	public void setPat_birthday(String pat_birthday) {
		this.pat_birthday = pat_birthday;
	}
	public String getPat_gender() {
		return pat_gender;
	}
	public void setPat_gender(String pat_gender) {
		this.pat_gender = pat_gender;
	}
}
