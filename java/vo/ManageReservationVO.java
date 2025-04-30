package vo;

public class ManageReservationVO {
	
	public int res_idx, pat_idx, pro_idx, res_chk, pay_chk;
	public String res_time, pat_name, pro_name, dept_name;
	
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
	public int getPro_idx() {
		return pro_idx;
	}
	public void setPro_idx(int pro_idx) {
		this.pro_idx = pro_idx;
	}
	public int getRes_chk() {
		return res_chk;
	}
	public void setRes_chk(int res_chk) {
		this.res_chk = res_chk;
	}
	public int getPay_chk() {
		return pay_chk;
	}
	public void setPay_chk(int pay_chk) {
		this.pay_chk = pay_chk;
	}
	public String getRes_time() {
		return res_time;
	}
	public void setRes_time(String res_time) {
		this.res_time = res_time;
	}
	public String getPat_name() {
		return pat_name;
	}
	public void setPat_name(String pat_name) {
		this.pat_name = pat_name;
	}
	public String getPro_name() {
		return pro_name;
	}
	public void setPro_name(String pro_name) {
		this.pro_name = pro_name;
	}
	public String getDept_name() {
		return dept_name;
	}
	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}
}

