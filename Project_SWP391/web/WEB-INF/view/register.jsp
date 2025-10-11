<%-- 
    Document   : register
    Created on : Oct 10, 2025, 12:01:11 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Register Account</title>
  <link rel="stylesheet" href="resources/css/style.css">
</head>
<body>
  <div class="container">
    <h2>Register Account</h2>

    <form>
      <div class="form-group">
        <div class="form-control">
          <label>Full name</label>
          <input type="text" placeholder="John Doe">
        </div>
        <div class="form-control">
          <label>Email</label>
          <input type="email" placeholder="example@gmail.com">
        </div>
      </div>

      <div class="form-group">
        <div class="form-control">
          <label>Contact Address</label>
          <input type="text" placeholder="">
          <button type="button" class="btn-add">Add address</button>
        </div>
        <div class="form-control">
          <label>Phone Number</label>
          <input type="tel" placeholder="+84912345678">
        </div>
      </div>

      <div class="form-group">
        <div class="form-control">
          <label>Password</label>
          <input type="password" id="password">
          <div class="password-info">
            Must have at least 8 characters, 1 number, 1 uppercase letter, no special characters.
          </div>
        </div>
        <div class="form-control">
          <label>Confirm Password</label>
          <input type="password">
        </div>
      </div>

      <div class="strength-bar"></div>
      <div class="strength-text">
        At least 8 characters – missing number or uppercase – no special characters
      </div>

      <button type="submit">Create Staff</button>

      <div class="login-text">
        You have an account? <a href="#">Login</a>
      </div>
    </form>
  </div>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('registerForm');
    const fullnameInput = document.getElementById('fullname');
    const emailInput = document.getElementById('email');
    const phoneInput = document.getElementById('phone');
    const addressInput = document.getElementById('address');
    const passwordInput = document.getElementById('password');
    const confirmPasswordInput = document.getElementById('confirmPassword');
    const strengthBar = document.getElementById('strengthBar');
    const strengthText = document.getElementById('strengthText');
    const btnAddAddress = document.getElementById('btnAddAddress');
    const secondaryAddressContainer = document.getElementById('secondaryAddressContainer');
    let hasSecondaryAddress = false; // Biến theo dõi trạng thái

    // --- PRIVATE HELPER FUNCTIONS ---

    /**
     * Hiển thị thông báo lỗi cho một trường nhập.
     * @param {HTMLElement} input - Trường input bị lỗi.
     * @param {string} message - Thông báo lỗi.
     */
    function displayError(input, message) {
        const control = input.closest('.form-control');
        const errorElement = document.getElementById('error-' + input.id);
        
        control.classList.add('error');
        if (errorElement) {
            errorElement.textContent = message;
            errorElement.style.display = 'block';
        }
    }

    /**
     * Xóa thông báo lỗi cho một trường nhập.
     * @param {HTMLElement} input - Trường input cần xóa lỗi.
     */
    function clearError(input) {
        const control = input.closest('.form-control');
        const errorElement = document.getElementById('error-' + input.id);

        control.classList.remove('error');
        if (errorElement) {
            errorElement.textContent = '';
            errorElement.style.display = 'none';
        }
    }

    /**
     * Kiểm tra trường nhập liệu bắt buộc.
     * @param {HTMLElement} input - Trường input.
     * @param {string} message - Thông báo nếu trống.
     * @returns {boolean} - true nếu không trống.
     */
    function checkRequired(input, message) {
        if (input.value.trim() === '') {
            displayError(input, message);
            return false;
        }
        clearError(input);
        return true;
    }

    /**
     * Kiểm tra định dạng Email.
     */
    function validateEmail() {
        const emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
        if (!checkRequired(emailInput, 'Vui lòng nhập Email.')) return false;
        
        if (!emailPattern.test(emailInput.value.trim())) {
            displayError(emailInput, 'Email không đúng định dạng.');
            return false;
        }
        clearError(emailInput);
        return true;
    }

    /**
     * Kiểm tra định dạng Số điện thoại.
     */
    function validatePhone() {
        // Định dạng SĐT: 10-15 chữ số, có thể có + ở đầu
        const phonePattern = /^\+?[0-9]{10,15}$/;
        if (!checkRequired(phoneInput, 'Vui lòng nhập Số điện thoại.')) return false;

        if (!phonePattern.test(phoneInput.value.trim())) {
            displayError(phoneInput, 'Số điện thoại không hợp lệ (ví dụ: +849...).');
            return false;
        }
        clearError(phoneInput);
        return true;
    }

    /**
     * Kiểm tra độ mạnh và tính hợp lệ của Mật khẩu.
     */
    function validatePassword() {
        const password = passwordInput.value;
        // Yêu cầu: ít nhất 8 ký tự, 1 số, 1 chữ hoa, KHÔNG có ký tự đặc biệt.
        const minLength = password.length >= 8;
        const hasNumber = /[0-9]/.test(password);
        const hasUppercase = /[A-Z]/.test(password);
        // Kiểm tra KHÔNG có ký tự đặc biệt (chỉ cho phép chữ, số)
        const noSpecialChars = /^[a-zA-Z0-9]+$/.test(password);
        
        // Cập nhật thanh độ mạnh (strength bar)
        updatePasswordStrength(minLength, hasNumber, hasUppercase, noSpecialChars);

        if (!checkRequired(passwordInput, 'Vui lòng nhập Mật khẩu.')) return false;

        if (!minLength) {
            displayError(passwordInput, 'Mật khẩu phải có ít nhất 8 ký tự.');
            return false;
        }
        if (!hasNumber) {
            displayError(passwordInput, 'Mật khẩu phải có ít nhất 1 chữ số.');
            return false;
        }
        if (!hasUppercase) {
            displayError(passwordInput, 'Mật khẩu phải có ít nhất 1 chữ hoa.');
            return false;
        }
        if (!noSpecialChars) {
             displayError(passwordInput, 'Mật khẩu không được chứa ký tự đặc biệt (chỉ chấp nhận chữ và số).');
            return false;
        }

        clearError(passwordInput);
        return true;
    }

    /**
     * Cập nhật giao diện thanh độ mạnh mật khẩu.
     */
    function updatePasswordStrength(minLength, hasNumber, hasUppercase, noSpecialChars) {
        let strength = 0;
        let message = '';
        
        if (minLength) strength += 1;
        if (hasNumber) strength += 1;
        if (hasUppercase) strength += 1;
        if (noSpecialChars) strength += 1;

        // Cập nhật thanh bar (ví dụ: dùng CSS để đổi màu/độ rộng)
        strengthBar.style.width = (strength / 4) * 100 + '%';

        if (strength === 4) {
            message = 'Mật khẩu mạnh 💪';
            strengthBar.style.backgroundColor = 'green';
        } else if (strength >= 2) {
            message = 'Mật khẩu trung bình 🟡';
            strengthBar.style.backgroundColor = 'orange';
        } else if (strength > 0) {
            message = 'Mật khẩu yếu 🔴';
            strengthBar.style.backgroundColor = 'red';
        } else {
            message = 'At least 8 characters – missing number or uppercase – no special characters';
            strengthBar.style.backgroundColor = 'grey';
            strengthBar.style.width = '0%';
        }
        
        strengthText.textContent = message;
    }


    /**
     * Kiểm tra Xác nhận Mật khẩu.
     */
    function validateConfirmPassword() {
        if (!checkRequired(confirmPasswordInput, 'Vui lòng xác nhận Mật khẩu.')) return false;

        if (passwordInput.value !== confirmPasswordInput.value) {
            displayError(confirmPasswordInput, 'Mật khẩu xác nhận không khớp.');
            return false;
        }
        clearError(confirmPasswordInput);
        return true;
    }
    
    /**
     * Xử lý thêm/xóa trường Địa chỉ phụ.
     */
    function toggleSecondaryAddress(event) {
        if (!hasSecondaryAddress) {
            // Thêm trường địa chỉ phụ
            const newAddressHTML = `
                <div class="form-control" id="secondaryAddressControl">
                    <label>Secondary Address</label>
                    <input type="text" id="sec_address" name="sec_address" placeholder="Secondary Address (Optional)">
                    <button type="button" class="btn-remove" id="btnRemoveAddress" style="margin-top: 5px;">Remove address</button>
                </div>
            `;
            secondaryAddressContainer.innerHTML = newAddressHTML;
            
            // Cập nhật nút
            btnAddAddress.style.display = 'none';
            hasSecondaryAddress = true;
            
            // Thêm sự kiện cho nút xóa
            document.getElementById('btnRemoveAddress').addEventListener('click', toggleSecondaryAddress);
            
        } else {
            // Xóa trường địa chỉ phụ
            secondaryAddressContainer.innerHTML = '';
            btnAddAddress.style.display = 'block';
            hasSecondaryAddress = false;
        }
    }

    // --- MAIN VALIDATION LOGIC ---

    /**
     * Chạy validation cho tất cả các trường.
     * @returns {boolean} - true nếu form hợp lệ.
     */
    function validateForm() {
        // Chạy tất cả các hàm validation và dùng && để kiểm tra kết quả cuối cùng
        // Chạy lần lượt để tất cả lỗi đều được hiển thị
        const isFullnameValid = checkRequired(fullnameInput, 'Vui lòng nhập Họ và Tên.');
        const isEmailValid = validateEmail();
        const isPhoneValid = validatePhone();
        const isAddressValid = checkRequired(addressInput, 'Vui lòng nhập Địa chỉ liên hệ.');
        const isPasswordValid = validatePassword();
        const isConfirmPasswordValid = validateConfirmPassword();
        
        // Trả về true chỉ khi TẤT CẢ các trường đều hợp lệ
        return isFullnameValid && isEmailValid && isPhoneValid && isAddressValid && isPasswordValid && isConfirmPasswordValid;
    }

    // --- EVENT LISTENERS ---

    // 1. Xử lý sự kiện SUBMIT FORM
    form.addEventListener('submit', function(e) {
        e.preventDefault(); // Ngăn chặn submit form mặc định

        if (validateForm()) {
            console.log('Form is valid. Submitting to server...');
            // *** Thực hiện AJAX hoặc submit form TẠI ĐÂY ***
            // Ví dụ: form.submit(); // Nếu bạn muốn dùng form submit truyền thống
            alert('Đăng ký thành công (chờ xử lý Server)!'); 
        } else {
            alert('Vui lòng kiểm tra lại các trường bị lỗi.');
        }
    });

    // 2. Xử lý sự kiện nhập liệu cho Mật khẩu (để cập nhật thanh độ mạnh)
    passwordInput.addEventListener('input', validatePassword);

    // 3. Xử lý sự kiện nút Thêm/Xóa Địa chỉ phụ
    btnAddAddress.addEventListener('click', toggleSecondaryAddress);
    
    // 4. Validation tức thì khi người dùng rời khỏi trường (blur event)
    [fullnameInput, emailInput, phoneInput, addressInput, confirmPasswordInput].forEach(input => {
        input.addEventListener('blur', function() {
            switch(input.id) {
                case 'fullname': checkRequired(input, 'Vui lòng nhập Họ và Tên.'); break;
                case 'email': validateEmail(); break;
                case 'phone': validatePhone(); break;
                case 'address': checkRequired(input, 'Vui lòng nhập Địa chỉ liên hệ.'); break;
                case 'confirmPassword': validateConfirmPassword(); break;
                // Password được xử lý bằng 'input' event để cập nhật strength bar
            }
        });
    });

});
    </script>
</body>
</html>
