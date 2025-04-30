package service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

@Service
public class CalendarService {

    // 교수별 예약 가능 요일 설정
    private static final Map<String, List<Integer>> professorAvailableDays = new HashMap<String, List<Integer>>();
    static {
        professorAvailableDays.put("professorA", Arrays.asList(1, 3)); // 월, 수
        professorAvailableDays.put("professorB", Arrays.asList(2, 4)); // 화, 목
        professorAvailableDays.put("professorC", Arrays.asList(0, 5)); // 일, 금
    }

    public List<Integer> getAvailableDates(String professor, int year, int month) {
    	List<Integer> availableWeekdays = professorAvailableDays.getOrDefault(professor, new ArrayList<Integer>());

        Calendar calendar = Calendar.getInstance();
        calendar.set(year, month, 1);
        int daysInMonth = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);

        List<Integer> availableDates = new ArrayList<Integer>();
        for (int day = 1; day <= daysInMonth; day++) {
            calendar.set(year, month, day);
            int weekday = calendar.get(Calendar.DAY_OF_WEEK) - 1; // Calendar.DAY_OF_WEEK는 1부터 시작
            if (availableWeekdays.contains(weekday)) {
                availableDates.add(day);
            }
        }
        return availableDates;
    }
}
