package vo;

/*
CREATE TABLE volcomment (
	comm_idx	 NUMBER(3)	 PRIMARY KEY,
	vol_idx	 NUMBER(3),
	comm_content	 CLOB		 NULL,
	comm_date	 DATE	 	 NULL,
	pat_idx	 	 NUMBER(3)	 NULL
);

--시퀀스--
create sequence comm_idx_seq; 
 */

public class VolcommentVO {
	public int comm_idx, pat_idx, vol_idx;
	public String comm_content, comm_date, comm_name;
	
	
	public String getComm_name() {
		return comm_name;
	}
	public void setComm_name(String comm_name) {
		this.comm_name = comm_name;
	}
	public int getVol_idx() {
		return vol_idx;
	}
	public void setVol_idx(int vol_idx) {
		this.vol_idx = vol_idx;
	}
	public int getComm_idx() {
		return comm_idx;
	}
	public void setComm_idx(int comm_idx) {
		this.comm_idx = comm_idx;
	}
	public int getPat_idx() {
		return pat_idx;
	}
	public void setPat_idx(int pat_idx) {
		this.pat_idx = pat_idx;
	}
	public String getComm_content() {
		return comm_content;
	}
	public void setComm_content(String comm_content) {
		this.comm_content = comm_content;
	}
	public String getComm_date() {
		return comm_date;
	}
	public void setComm_date(String comm_date) {
		this.comm_date = comm_date;
	}
	
	
}
