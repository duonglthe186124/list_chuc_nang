/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


const passwordInput = document.getElementById('password');
const strengthStatus = document.getElementById('password-strength-status');
const registerForm = document.getElementById('registerForm');


passwordInput.addEventListener('input', function() {
    const password = this.value;
    let score = 0;
    

    if (password.length >= 8) score++;
    if (password.length >= 12) score++;
    if (/[A-Z]/.test(password)) score++; 
    if (/[a-z]/.test(password)) score++; 
    if (/[0-9]/.test(password)) score++; 
    if (/[^a-zA-Z0-9]/.test(password)) score++;

    strengthStatus.classList.remove('weak', 'medium', 'strong');


    if (password.length === 0) {
        strengthStatus.textContent = '';
    } else if (score < 3) {
        strengthStatus.textContent = 'Weak';
        strengthStatus.classList.add('weak');
    } else if (score < 5) {
        strengthStatus.textContent = 'Medium';
        strengthStatus.classList.add('medium');
    } else {
        strengthStatus.textContent = 'Strong';
        strengthStatus.classList.add('strong');
    }
});


registerForm.addEventListener('submit', function(event) {
    event.preventDefault(); 

    const fullname = document.getElementById('fullname').value.trim();
    const email = document.getElementById('email').value.trim();
    const address = document.getElementById('address').value.trim();
    const phone = document.getElementById('phone').value.trim();
    const password = passwordInput.value;
    const confirmPassword = document.getElementById('confirm_password').value;
    const errorMessageDiv = document.getElementById('error-message');

    errorMessageDiv.innerHTML = '';


    if (!fullname || !email || !address || !phone || !password || !confirmPassword) {
        errorMessageDiv.innerHTML = '<p>Please fill out all required fields.</p>';
        return;
    }

    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email)) {
        errorMessageDiv.innerHTML = '<p>Invalid email format.</p>';
        return;
    }

    if (password.length < 8 || !/[A-Z]/.test(password) || !/[0-9]/.test(password)) {
        errorMessageDiv.innerHTML = '<p>Password is not strong enough. Please ensure it has at least 8 characters, 1 uppercase letter, and 1 number.</p>';
        return;
    }
    
    if (password !== confirmPassword) {
        errorMessageDiv.innerHTML = '<p>The confirmation password does not match.</p>';
        return;
    }

    this.submit();
});