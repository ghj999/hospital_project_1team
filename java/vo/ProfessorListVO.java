package vo;

public class ProfessorListVO {
	public int pro_idx, dept_idx;
	public String pro_name, pro_field, pro_file, dept_name;

	public int getPro_idx() {
		return pro_idx;
	}

	public void setPro_idx(int pro_idx) {
		this.pro_idx = pro_idx;
	}

	public int getDept_idx() {
		return dept_idx;
	}

	public void setDept_idx(int dept_idx) {
		this.dept_idx = dept_idx;
	}

	public String getPro_name() {
		return pro_name;
	}

	public void setPro_name(String pro_name) {
		this.pro_name = pro_name;
	}

	public String getPro_field() {
		return pro_field;
	}

	public void setPro_field(String pro_field) {
		this.pro_field = pro_field;
	}

	public String getPro_file() {
		return pro_file;
	}

	public void setPro_file(String pro_file) {
		this.pro_file = pro_file;
	}

	public String getDept_name() {
		return dept_name;
	}

	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}
}
