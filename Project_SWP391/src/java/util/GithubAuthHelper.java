package util;

import com.google.gson.Gson;
import com.google.gson.JsonArray; 
import com.google.gson.JsonElement; 
import com.google.gson.JsonObject;
import model.Users;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

public class GithubAuthHelper {
    private static final String CLIENT_ID = "Ov23lifh9EODRJ9Uknqg";
    private static final String CLIENT_SECRET = "3c108052da7ec8d7bf1679f0aaa1a75d0427e33e";
    private static final String REDIRECT_URI = "http://localhost:9999/Project_SWP391/callback-github";

    // Hàm chung để gửi request (hỗ trợ cả POST)
    private static String getResponse(HttpURLConnection conn) throws IOException {
        // Đặt User-Agent (Bắt buộc với GitHub API)
        conn.setRequestProperty("User-Agent", "Java-WMS-App");
        
        BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        String inputLine;
        StringBuilder content = new StringBuilder();
        while ((inputLine = in.readLine()) != null) {
            content.append(inputLine);
        }
        in.close();
        conn.disconnect();
        return content.toString();
    }

    // 1. Dùng 'code' để đổi lấy 'access_token' (Giữ nguyên)
    public static String getAccessToken(String code) throws IOException {
        String url = "https://github.com/login/oauth/access_token";
        String params = "client_id=" + CLIENT_ID + "&client_secret=" + CLIENT_SECRET + "&code=" + code;

        HttpURLConnection conn = (HttpURLConnection) new URL(url).openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Accept", "application/json");
        conn.setDoOutput(true);

        try (OutputStream os = conn.getOutputStream()) {
            byte[] input = params.getBytes("utf-8");
            os.write(input, 0, input.length);
        }

        String response = getResponse(conn);
        JsonObject json = new Gson().fromJson(response, JsonObject.class);
        return json.get("access_token").getAsString();
    }

    // 2. Dùng 'access_token' để lấy thông tin người dùng 
    public static Users getUserInfo(String accessToken) throws IOException {
        String userApiUrl = "https://api.github.com/user";

        // --- 1. Lấy thông tin profile cơ bản ---
        HttpURLConnection conn = (HttpURLConnection) new URL(userApiUrl).openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Authorization", "Bearer " + accessToken);
        
        String response = getResponse(conn);
        JsonObject json = new Gson().fromJson(response, JsonObject.class);
        
        Users user = new Users();
        // GitHub có thể không trả về tên, dùng login (username) thay thế
        if (json.has("name") && !json.get("name").isJsonNull()) {
            user.setFullname(json.get("name").getAsString());
        } else {
            user.setFullname(json.get("login").getAsString());
        }
        
        user.setGithubId(json.get("id").getAsString());
        user.setAvatar_url(json.get("avatar_url").getAsString()); // GitHub luôn có avatar

        // --- 2. Lấy Email ---
        String email = null;
        if (json.has("email") && !json.get("email").isJsonNull()) {
            email = json.get("email").getAsString();
        }

        // --- 3. Nếu email là null (do bị ẩn), gọi API email THỨ HAI ---
        if (email == null) {
            String emailApiUrl = "https://api.github.com/user/emails";
            conn = (HttpURLConnection) new URL(emailApiUrl).openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Authorization", "Bearer " + accessToken);

            String emailResponse = getResponse(conn);
            JsonArray emailArray = new Gson().fromJson(emailResponse, JsonArray.class);

            // Lặp qua mảng email để tìm email chính (primary)
            for (JsonElement el : emailArray) {
                JsonObject emailObj = el.getAsJsonObject();
                if (emailObj.get("primary").getAsBoolean()) {
                    email = emailObj.get("email").getAsString();
                    break;
                }
            }
            
            // Nếu không có email "primary", lấy email "verified" đầu tiên
            if (email == null && emailArray.size() > 0) {
                 for (JsonElement el : emailArray) {
                    JsonObject emailObj = el.getAsJsonObject();
                    if (emailObj.get("verified").getAsBoolean()) {
                        email = emailObj.get("email").getAsString();
                        break;
                    }
                }
            }
        }

        user.setEmail(email); // Gán email (có thể vẫn là null nếu user không có email nào)
        return user;
    }
}