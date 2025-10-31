/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

document.addEventListener('DOMContentLoaded', function () {
    const newPasswordField = document.getElementById('new_password');
    const strengthBar = document.getElementById('strength-bar');
    const strengthText = document.getElementById('strength-text');

    if (newPasswordField && strengthBar && strengthText) {
        newPasswordField.addEventListener('input', function () {
            const password = this.value;
            let score = 0;


            if (password.length > 5) score += 1;
            if (password.length > 8) score += 1;
            if (password.length > 12) score += 1;

            if (/[a-z]/.test(password) && /[A-Z]/.test(password)) score += 1;

            if (/\d/.test(password)) score += 1;

            if (/[^a-zA-Z0-9]/.test(password)) score += 1;

            let strength = '';
            let color = '';
            let width = 0;

            if (password.length === 0) {
                strength = '';
                color = 'transparent';
                width = 0;
            } else if (score < 3) {
                strength = 'Weak';
                color = '#dc3545'; 
                width = 33;
            } else if (score < 5) {
                strength = 'Medium';
                color = '#ffc107'; 
                width = 66;
            } else {
                strength = 'Strong';
                color = '#28a745';
                width = 100;
            }

            strengthBar.style.width = width + '%';
            strengthBar.style.backgroundColor = color;
            strengthText.textContent = strength;
            strengthText.className = 'strength-text ' + (strength ? 'strength-' + strength.toLowerCase() : '');
        });
    }
});
