document.addEventListener('DOMContentLoaded', function () {
    const newPasswordField = document.getElementById('new_password');
    const strengthBar = document.getElementById('strength-bar');
    const strengthText = document.getElementById('strength-text');

    if (newPasswordField && strengthBar && strengthText) {
        newPasswordField.addEventListener('input', function () {
            const password = this.value;
            let score = 0;

            // Kiểm tra độ dài
            if (password.length > 5) score += 1;
            if (password.length > 8) score += 1;
            if (password.length > 12) score += 1;

            // Kiểm tra chữ hoa, chữ thường
            if (/[a-z]/.test(password) && /[A-Z]/.test(password)) score += 1;
            // Kiểm tra số
            if (/\d/.test(password)) score += 1;
            // Kiểm tra ký tự đặc biệt
            if (/[^a-zA-Z0-9]/.test(password)) score += 1;

            let strength = '';
            let barClass = '';
            let textClass = '';
            let width = 0;

            if (password.length === 0) {
                strength = '';
                barClass = 'bg-transparent'; // Tailwind: nền trong suốt
                textClass = '';
                width = 0;
            } else if (score < 3) {
                strength = 'Weak';
                barClass = 'bg-red-500'; // Tailwind: màu đỏ
                textClass = 'text-red-500'; // Tailwind: màu chữ đỏ
                width = 33;
            } else if (score < 5) {
                strength = 'Medium';
                barClass = 'bg-yellow-500'; // Tailwind: màu vàng
                textClass = 'text-yellow-500'; // Tailwind: màu chữ vàng
                width = 66;
            } else {
                strength = 'Strong';
                barClass = 'bg-green-500'; // Tailwind: màu xanh
                textClass = 'text-green-500'; // Tailwind: màu chữ xanh
                width = 100;
            }
            
            // Xóa các class cũ và thêm class mới
            strengthBar.style.width = width + '%';
            strengthBar.className = barClass; // Gán class Tailwind
            
            strengthText.textContent = strength;
            strengthText.className = 'strength-text ' + textClass; // Gán class Tailwind
        });
    }
});