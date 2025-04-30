package service;

import java.net.URI;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class HolidayService {

    // Google API Key
    private static final String API_KEY = "AIzaSyCil2d51LSs3z1nQzrncN4mscffDOlxMlk";

    // South Korea Holiday Calendar ID
    private static final String CALENDAR_ID = "ko.south_korea#holiday@group.v.calendar.google.com";

    // Google Calendar API Base URL
    private static final String API_URL = "https://www.googleapis.com/calendar/v3/calendars/";

    /**
     * Retrieves holiday data from Google Calendar API.
     *
     * @param year  Year for which to retrieve holidays
     * @param month Month for which to retrieve holidays
     * @return List of holiday dates in yyyy-MM-dd format
     */
    public List<String> getHolidays(int year, int month) {
        List<String> holidays = new ArrayList<String>();

        try {
            // Build URL with date range
            LocalDate startDate = LocalDate.of(year, month, 1);
            LocalDate endDate = startDate.plusMonths(1).minusDays(1);

            URI uri = UriComponentsBuilder.fromHttpUrl(API_URL + CALENDAR_ID.replace("#", "%23") + "/events")
                    .queryParam("key", API_KEY)
                    .queryParam("timeMin", startDate + "T00:00:00Z") // Start date (ISO-8601 format)
                    .queryParam("timeMax", endDate + "T23:59:59Z")    // End date
                    .queryParam("singleEvents", true)                // Fetch individual events
                    .queryParam("orderBy", "startTime")              // Order by start time
                    .build(true)
                    .toUri();

            System.out.println("Generated URL: " + uri);

            // API Request
            RestTemplate restTemplate = new RestTemplate();
            ResponseEntity<String> response = restTemplate.getForEntity(uri, String.class);

            // Parse JSON Response
            ObjectMapper mapper = new ObjectMapper();
            JsonNode rootNode = mapper.readTree(response.getBody());
            JsonNode items = rootNode.path("items");

            // Extract holiday information
            for (JsonNode item : items) {
                String date = item.path("start").path("date").asText(); // Extract date
                holidays.add(date); // Save in yyyy-MM-dd format
            }

        } catch (Exception e) {
            System.err.println("Error while fetching holidays: " + e.getMessage());
            e.printStackTrace();
        }

        return holidays;
    }
}

