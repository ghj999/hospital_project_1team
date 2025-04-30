package vo;

public class ReservationVO {
	/*
	--예약테이블
	CREATE TABLE reservation (
		res_idx 		NUMBER(4) 	NOT NULL,
		pat_idx 		NUMBER(3) 	NULL,
		pro_idx	 	NUMBER(3) 	NULL,
		res_time 		DATE	 	NULL,
		res_chk 		NUMBER(1) 	NULL,
		pay_chk 		NUMBER(1) 	NULL
	);
	--시퀀스
	create sequence res_idx_seq;
	--DB insert 예시
	res_idx	pat_idx	pro_idx	res_time			res_chk	pay_chk
	1	-	-	2024-03-05 15:00		0	0
	2	-	-	2024-03-05 15:30		0	0
	3	-	-	2024-03-05 16:00		0	0
	4	-	-	2024-03-05 16:30		0	0

	50	12	24	2024-03-05 15:30		1	0 
	 */
	public int res_idx, pat_idx, pro_idx, res_chk, pay_chk;
	public String res_time;

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
}

