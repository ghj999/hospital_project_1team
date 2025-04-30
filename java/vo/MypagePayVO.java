package vo;

/*
--select
SELECT 
	pat.pat_idx AS pat_idx, 			--환자번호
	pat.pat_name AS pat_name,			--환자이름
	pat.pat_email AS pat_email,			--환자이메일
	pat.pat_phone AS pat_phone,			--환자전화번호
    dept.dept_name AS dept_name,		--진료과
    dept.dept_payment AS dept_payment,	--진료비
    pro.pro_name AS pro_name,			--교수이름
    pro.pro_file AS pro_file,			--교수사진
    res.res_idx AS res_idx,				--예약번호
    TO_CHAR(res.res_time, 'YYYY-MM-DD HH24:MI') AS res_time		--예약날짜,시간
FROM 
    reservation res
JOIN 
    professor pro ON res.pro_idx = pro.pro_idx
JOIN 
    department dept ON pro.dept_idx = dept.dept_idx
JOIN 
    patient pat ON res.pat_idx = pat.pat_idx
WHERE 
    pat.pat_idx = 16
*/

//진료비내역조회VO
public class MypagePayVO {
	private String pat_name, pat_email, pat_phone, dept_name, pro_name, pro_file, res_time;
	private int res_idx, pat_idx, dept_payment;
	
	@Override
	public String toString() {
	    return "MypagePayVO{" +
	            "resIdx='" + res_idx + '\'' +
	            ", resTime='" + res_time + '\'' +
	            ", deptName='" + dept_name + '\'' +
	            ", deptPayment=" + dept_payment +
	            '}';
	}
	

	public String getPat_name() {
		return pat_name;
	}
	public void setPat_name(String pat_name) {
		this.pat_name = pat_name;
	}
	public String getPat_email() {
		return pat_email;
	}
	public void setPat_email(String pat_email) {
		this.pat_email = pat_email;
	}
	public String getPat_phone() {
		return pat_phone;
	}
	public void setPat_phone(String pat_phone) {
		this.pat_phone = pat_phone;
	}
	public String getDept_name() {
		return dept_name;
	}
	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}
	public String getPro_name() {
		return pro_name;
	}
	public void setPro_name(String pro_name) {
		this.pro_name = pro_name;
	}
	public String getPro_file() {
		return pro_file;
	}
	public void setPro_file(String pro_file) {
		this.pro_file = pro_file;
	}
	public String getRes_time() {
		return res_time;
	}
	public void setRes_time(String res_time) {
		this.res_time = res_time;
	}
	public int getRes_idx() {
		return res_idx;
	}
	public void setRes_idx(int res_idx) {
		this.res_idx = res_idx;
	}
	public int getPat_idx() {
		return pat_idx;
	}
	public void setPat_idx(int pat_idx) {
		this.pat_idx = pat_idx;
	}
	public int getDept_payment() {
		return dept_payment;
	}
	public void setDept_payment(int dept_payment) {
		this.dept_payment = dept_payment;
	}
}
