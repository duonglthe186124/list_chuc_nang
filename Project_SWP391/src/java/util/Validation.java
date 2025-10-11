package util;

/**
 *
 * @author ASUS
 */
public class Validation {
    public static String check_string_input(String input, String result)
    {
        result = null;
        if(input != null && !input.trim().isEmpty())
        {
            result = input.trim();
        }
        return result;
    }
}
