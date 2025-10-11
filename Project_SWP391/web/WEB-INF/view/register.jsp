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
    <c:if test="${registerError != null}">
            <div style="color: red; font-weight: bold; margin-bottom: 15px;">${registerError}</div>
        </c:if>

    <form id="registerForm" action="register_servlet" method="POST">
      <div class="form-group">
        <div class="form-control" id="fullname-control">
          <label>Full name</label>
          <input type="text" id="fullname" name="fullname" placeholder="John Doe"
                 value="${fullname != null ? fullname : ''}">
        <small class="error-text" id="error-fullname" style="display: ${errors.containsKey('fullname') ? 'block' : 'none'}">${errors.fullname}</small>  
        </div>
        <div class="form-control">
          <label>Email</label>
          <input type="email" placeholder="example@gmail.com">
        <small class="error-text" id="error-email" style="display: ${errors.containsKey('email') ? 'block' : 'none'}">${errors.email}</small>
        </div>
      </div>

      <div class="form-group">
        <div class="form-control" id="address-control">
          <label>Contact Address</label>
          <input type="text" id="address" name="address" placeholder=""
                 value="${address != null ? address : ''}">
          <button type="button" class="btn-add" id="btnAddAddress">Add address</button>
          <small class="error-text" id="error-address" style="display: ${errors.containsKey('address') ? 'block' : 'none'}">${errors.address}</small>
        </div>
        <div class="form-control" id="phone-control">
          <label>Phone Number</label>
          <input type="tel" id="phone" name="phone" placeholder="+84912345678"
                 value="${phone != null ? phone : ''}">
          <small class="error-text" id="error-phone" style="display: ${errors.containsKey('phone') ? 'block' : 'none'}">${errors.phone}</small>      
        </div>
      </div>

      <div class="form-group">
        <div class="form-control" id="password-control">
          <label>Password</label>
          <input type="password" id="password" name="password">
          <div class="password-info">
            Must have at least 8 characters, 1 number, 1 uppercase letter, no special characters.
          </div>
          <small class="error-text" id="error-password" style="display: ${errors.containsKey('password') ? 'block' : 'none'}">${errors.password}</small>
        </div>
        <div class="form-control" id="confirmPassword-control">
          <label>Confirm Password</label>
          <input type="password" id="confirmPassword">
          <small class="error-text" id="error-confirmPassword" style="display: ${errors.containsKey('confirmPassword') ? 'block' : 'none'}">${errors.confirmPassword}</small>
        </div>
      </div>

      <div class="strength-bar" id="strengthBar"></div>
      <div class="strength-text" id="strengthText">
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
            // --- KHAI BÁO BIẾN ---
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
            
            let hasSecondaryAddress = secondaryAddressContainer.querySelector('#secondaryAddressControl') !== null; 

            if (hasSecondaryAddress) {
                btnAddAddress.style.display = 'none';
                const btnRemoveAddress = document.getElementById('btnRemoveAddress');
                if (btnRemoveAddress) {
                     btnRemoveAddress.addEventListener('click', toggleSecondaryAddress);
                }
            }


            // --- CÁC HÀM HỖ TRỢ ---

            function displayError(input, message) {
                const control = input.closest('.form-control');
                const errorElement = document.getElementById('error-' + input.id);
                
                control.classList.add('error');
                if (errorElement) {
                    errorElement.textContent = message;
                    errorElement.style.display = 'block';
                }
            }

            function clearError(input) {
                const control = input.closest('.form-control');
                const errorElement = document.getElementById('error-' + input.id);

                control.classList.remove('error');
                if (errorElement) {
                    // Xóa lỗi client-side và ẩn nếu không có lỗi server-side
                    if (!errorElement.innerHTML.trim().length) {
                       errorElement.textContent = '';
                       errorElement.style.display = 'none';
                    }
                }
            }

            function checkRequired(input, message) {
                if (input.value.trim() === '') {
                    displayError(input, message);
                    return false;
                }
                clearError(input);
                return true;
            }

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

            function validatePhone() {
                const phonePattern = /^\+?[0-9]{10,15}$/;
                if (!checkRequired(phoneInput, 'Vui lòng nhập Số điện thoại.')) return false;

                if (!phonePattern.test(phoneInput.value.trim())) {
                    displayError(phoneInput, 'Số điện thoại không hợp lệ (ví dụ: +849...).');
                    return false;
                }
                clearError(phoneInput);
                return true;
            }
            
            function updatePasswordStrength(minLength, hasNumber, hasUppercase, noSpecialChars) {
                let strength = 0;
                let message = '';
                
                if (minLength) strength += 1;
                if (hasNumber) strength += 1;
                if (hasUppercase) strength += 1;
                if (noSpecialChars) strength += 1;

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

            function validatePassword() {
                const password = passwordInput.value;
                const minLength = password.length >= 8;
                const hasNumber = /[0-9]/.test(password);
                const hasUppercase = /[A-Z]/.test(password);
                const noSpecialChars = /^[a-zA-Z0-9]+$/.test(password);
                
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

            function validateConfirmPassword() {
                if (!checkRequired(confirmPasswordInput, 'Vui lòng xác nhận Mật khẩu.')) return false;

                if (passwordInput.value !== confirmPasswordInput.value) {
                    displayError(confirmPasswordInput, 'Mật khẩu xác nhận không khớp.');
                    return false;
                }
                clearError(confirmPasswordInput);
                return true;
            }

            function toggleSecondaryAddress(event) {
                if (event.currentTarget.id === 'btnAddAddress') {
                    // Thêm trường địa chỉ phụ
                    const newAddressHTML = `
                        <div class="form-control" id="secondaryAddressControl">
                            <label>Secondary Address</label>
                            <input type="text" id="sec_address" name="sec_address" placeholder="Secondary Address (Optional)">
                            <button type="button" class="btn-remove" id="btnRemoveAddress" style="margin-top: 5px;">Remove address</button>
                        </div>
                    `;
                    secondaryAddressContainer.innerHTML = newAddressHTML;
                    btnAddAddress.style.display = 'none';
                    hasSecondaryAddress = true;
                    document.getElementById('btnRemoveAddress').addEventListener('click', toggleSecondaryAddress);
                    
                } else if (event.currentTarget.id === 'btnRemoveAddress') {
                    // Xóa trường địa chỉ phụ
                    secondaryAddressContainer.innerHTML = '';
                    btnAddAddress.style.display = 'block';
                    hasSecondaryAddress = false;
                }
            }
            
            function validateForm() {
                // Chạy tất cả các hàm validation
                const isFullnameValid = checkRequired(fullnameInput, 'Vui lòng nhập Họ và Tên.');
                const isEmailValid = validateEmail();
                const isPhoneValid = validatePhone();
                const isAddressValid = checkRequired(addressInput, 'Vui lòng nhập Địa chỉ liên hệ.');
                const isPasswordValid = validatePassword();
                const isConfirmPasswordValid = validateConfirmPassword();
                
                // Trả về true nếu TẤT CẢ đều hợp lệ
                return isFullnameValid && isEmailValid && isPhoneValid && isAddressValid && isPasswordValid && isConfirmPasswordValid;
            }

            // --- XỬ LÝ SỰ KIỆN ---

            form.addEventListener('submit', function(e) {
                e.preventDefault(); 
                
                // Xóa trạng thái hiển thị lỗi server-side trước khi chạy validation client-side
                const serverErrorElements = document.querySelectorAll('.error-text');
                serverErrorElements.forEach(el => {
                    if (!el.innerHTML.trim().length) {
                        el.style.display = 'none';
                    }
                });

                if (validateForm()) {
                    console.log('Client validation successful. Submitting to server...');
                    form.submit(); 
                } 
            });

            passwordInput.addEventListener('input', validatePassword);
            btnAddAddress.addEventListener('click', toggleSecondaryAddress);
            
            // Validation tức thì khi rời khỏi trường (blur event)
            [fullnameInput, emailInput, phoneInput, addressInput, confirmPasswordInput].forEach(input => {
                input.addEventListener('blur', function() {
                    switch(input.id) {
                        case 'fullname': checkRequired(input, 'Vui lòng nhập Họ và Tên.'); break;
                        case 'email': validateEmail(); break;
                        case 'phone': validatePhone(); break;
                        case 'address': checkRequired(input, 'Vui lòng nhập Địa chỉ liên hệ.'); break;
                        case 'confirmPassword': validateConfirmPassword(); break;
                    }
                });
            });

        });
    </script>
</body>
</html>
