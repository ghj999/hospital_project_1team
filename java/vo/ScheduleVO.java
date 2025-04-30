package vo;

public class ScheduleVO {
	private int pro_idx, weekday;
	
	public ScheduleVO() {
	}
	public int getPro_idx() {
		return pro_idx;
	}

	public void setPro_idx(int pro_idx) {
		this.pro_idx = pro_idx;
	}

	public int getWeekday() {
		return weekday;
	}

	public void setWeekday(int weekday) {
		this.weekday = weekday;
	}
	// toString 메서드 (디버깅 용도)
    @Override
    public String toString() {
        return "ScheduleVO{" +
                "pro_Idx=" + pro_idx +
                ", weekday=" + weekday +
                '}';
    }

}
