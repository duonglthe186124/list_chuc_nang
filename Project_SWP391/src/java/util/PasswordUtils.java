/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;
import org.mindrot.jbcrypt.BCrypt;
/**
 *
 * @author admin
 */
public class PasswordUtils {
    // Cost factor 10 là mức chuẩn về bảo mật và hiệu năng
    private static final int WORKLOAD = 10; 

    /**
     * @public
     * Băm mật khẩu bằng BCrypt.
     * @param plainPassword Mật khẩu chưa băm.
     * @return Chuỗi mật khẩu đã được băm.
     */
    public static String hashPassword(String plainPassword) {
        String salt = BCrypt.gensalt(WORKLOAD);
        return BCrypt.hashpw(plainPassword, salt);
    }

    /**
     * @public
     * Kiểm tra mật khẩu chưa băm có khớp với mật khẩu đã băm không.
     */
    public static boolean checkPassword(String plainPassword, String hashedPassword) {
        try {
            return BCrypt.checkpw(plainPassword, hashedPassword);
        } catch (Exception e) {
            return false;
        }
    }
}
