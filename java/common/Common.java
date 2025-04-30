package common;

public class Common {
	public static class main{
		public static final String VIEW_PATH = "/WEB-INF/views/main/";
	}

	public static class login{
		public static final String VIEW_PATH = "/WEB-INF/views/login/";
	}

	public static class mypage{
		public static final String VIEW_PATH = "/WEB-INF/views/mypage/";
	}

	public static class info{
		public static final String VIEW_PATH = "/WEB-INF/views/info/";
	}

	public static class Menu{
		public static final String VIEW_PATH = "/WEB-INF/views/menu/";
	}
	public static class reservation{
		public static final String VIEW_PATH = "/WEB-INF/views/reservation/";

		//한 페이지의 보여줄 게시글 수
		public final static int BLOCKLIST = 5;

		//하단 페이지 페이지의 수
		public final static int BLOCKPAGE = 3;
	}
	public static class dept{
		public static final String VIEW_PATH = "/WEB-INF/views/dept/";
	}
	public static class join{
		public static final String VIEW_PATH = "/WEB-INF/views/join/";
	}
	public static class Diagnosis{
		public static final String VIEW_PATH = "/WEB-INF/views/SelfDiagnosis/";
	}
	public static class Device{
		public static final String VIEW_PATH = "/WEB-INF/views/MedicalDevice/";

		// 한 페이지에 보여줄 게시글 수
		public final static int BLOCKLIST = 4;

		// 하단 페이지 메뉴의 수
		public final static int BLOCKPAGE = 3;
	}	

	//감사, 건의 게시판 페이징 
	public static class Board{

		public final static int BLOCKLIST = 9;

		public final static int BLOCKPAGE = 3;

	}

	//자원봉사, 공지사항 페이징 
	public static class VolNot{

		public final static int BLOCKLIST =8;

		public final static int BLOCKPAGE = 5;

	}

	//자원봉사 댓글 페이징 
	public static class VolComm{

		public final static int BLOCKLIST = 6;

		public final static int BLOCKPAGE = 3;

	}

	//상담예약 페이징 
	public static class Call{

		public final static int BLOCKLIST = 5;

		public final static int BLOCKPAGE = 5;

	}
	
	public static class Professor{
		public static final String VIEW_PATH = "/WEB-INF/views/Search/";
		
		// 한 페이지에 보여줄 게시글 수
		public final static int BLOCKLIST = 10;

		// 하단 페이지 메뉴의 수
		public final static int BLOCKPAGE = 5;
	}
	//==========================================================================================
	//관리자페이지
	public static class Admin{
		public static final String VIEW_PATH = "/WEB-INF/views/main/Admin/";
	}


}
