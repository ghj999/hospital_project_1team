package util;
/*
        nowPage:현재페이지
        rowTotal:전체데이터갯수
        blockList:한페이지당 게시물수
        blockPage:한화면에 나타낼 페이지 메뉴 수
 */

public class Paging_Design_Device {
    public static String getPaging(String pageURL, int nowPage, int rowTotal, int blockList, int blockPage) {
        int totalPage, startPage, endPage;
        boolean isPrevPage, isNextPage;
        StringBuffer sb;

        isPrevPage = isNextPage = false;
        totalPage = (int) (rowTotal / blockList);
        if (rowTotal % blockList != 0) totalPage++;

        if (nowPage > totalPage) nowPage = totalPage;

        startPage = (int) (((nowPage - 1) / blockPage) * blockPage + 1);
        endPage = startPage + blockPage - 1;

        if (endPage > totalPage) endPage = totalPage;

        if (endPage < totalPage) isNextPage = true;
        if (nowPage > 1) isPrevPage = true;

        sb = new StringBuffer();

        // Include inline CSS
        sb.append("<style>");
        sb.append("ul.pagination {display: flex; list-style: none; padding: 0; margin: 20px 0; justify-content: center; align-items: center;}");

        // 숫자 버튼 스타일 유지
        sb.append("ul.pagination li {margin: 0 5px; font-size: 16px;}");

        // 화살표 간 간격 제거
        sb.append("ul.pagination li.outer, ul.pagination li.inner {margin: 0; font-size: 6px;}");

        // 버튼 스타일
        sb.append("ul.pagination li a {text-decoration: none; padding: 10px 15px; display: block; color: #3086C9;}");
        sb.append("ul.pagination li span {text-decoration: none; padding: 10px 15px; display: block; background-color: #12B8BA; color: white;}");

        // 클릭된 버튼
        sb.append("ul.pagination li.active span {background-color: #3086C9; color: white; font-weight: bold;}");

        // 비활성화된 버튼(화살표)
        sb.append("ul.pagination li.disabled span {background-color: #f3f3f3; color: #12B8BA; cursor: not-allowed; border: 1px solid #ddd; padding: 15px;}");

        // 호버 효과
        sb.append("ul.pagination li a:hover {background-color: #3086C9; color: white;}");

        // 화살표 스타일
        sb.append("ul.pagination li.outer a {text-decoration: none; color: #12B8BA; border: 1px solid #ddd; padding: 15px;}");
        sb.append("ul.pagination li.outer a:hover {background-color: white; color: #12B8BA;}");
        sb.append("ul.pagination li.inner a {text-decoration: none; color: #12B8BA; border: 1px solid #ddd; padding: 15px;}");
        sb.append("ul.pagination li.inner a:hover {background-color: white; color: #12B8BA;}");
        sb.append("</style>");

        sb.append("<ul class='pagination'>");

        // 맨 처음 페이지 버튼
        if (nowPage > 1) {
            sb.append("<li class='outer'><a href='" + pageURL + "?page=1'>◀◀</a></li>");
        } else {
            sb.append("<li class='outer disabled'><span>◀◀</span></li>");
        }

        // 이전 페이지 버튼
        if (isPrevPage) {
            sb.append("<li class='inner'><a href='" + pageURL + "?page=" + (nowPage - 1) + "'>◀</a></li>");
        } else {
            sb.append("<li class='inner disabled'><span>◀</span></li>");
        }

        // 페이지 번호 출력
        for (int i = startPage; i <= endPage; i++) {
            if (i > totalPage) break;
            if (i == nowPage) {
                sb.append("<li class='active'><span>");
                sb.append(i);
                sb.append("</span></li>");
            } else {
                sb.append("<li><a href='" + pageURL + "?page=" + i + "'>" + i + "</a></li>");
            }
        }

        // 오른쪽 안쪽 화살표 버튼
        if (nowPage < totalPage) {
            sb.append("<li class='inner'><a href='" + pageURL + "?page=" + (nowPage + 1) + "'>▶</a></li>");
        } else {
            sb.append("<li class='inner disabled'><span>▶</span></li>");
        }

        // 맨 마지막 페이지 버튼
        if (nowPage < totalPage) {
            sb.append("<li class='outer'><a href='" + pageURL + "?page=" + totalPage + "'>▶▶</a></li>");
        } else {
            sb.append("<li class='outer disabled'><span>▶▶</span></li>");
        }

        sb.append("</ul>");
        return sb.toString();
    }
}







