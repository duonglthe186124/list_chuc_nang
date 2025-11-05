package util;

/**
 *
 * @author ASUS
 */
public class Validation {

    public static String validate_string_input(String raw_string) {
        if (raw_string == null || raw_string.trim().isEmpty()) {
            return null;
        }
        return raw_string;
    }

    public static String validate_option_string_input(String raw_option) {
        if (raw_option == null || raw_option.trim().isEmpty()) {
            return null;
        }
        return raw_option;
    }

    public static int validate_option_integer_input(String raw_option, int default_option) {
        if (raw_option == null || raw_option.trim().isEmpty()) {
            return default_option;
        }

        return Integer.parseInt(raw_option);
    }

    public static String validate_supplier_input(String raw_supplier) throws IllegalArgumentException {
        if (raw_supplier.trim().isEmpty()) {
            throw new IllegalArgumentException("Nhà cung cấp không được để trống");
        }
        return raw_supplier;
    }

    public static int validate_supplier_id(String raw_supplier) throws IllegalArgumentException {
        int supplier_id;
        try {
            supplier_id = Integer.parseInt(raw_supplier);
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException();
        }
        return supplier_id;
    }
}
