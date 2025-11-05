/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


document.addEventListener('DOMContentLoaded', function () {
    const editBtn = document.getElementById('edit-btn');
    const saveBtn = document.getElementById('save-btn');
    const profileForm = document.getElementById('profile-form');
    // Lấy tất cả các ô input bên trong form, trừ các nút
    const formInputs = profileForm.querySelectorAll('input:not([type="button"]):not([type="submit"])');

    // Mặc định: ẩn nút Save
    saveBtn.style.display = 'none';

    // Xử lý sự kiện khi nhấn nút "Edit"
    editBtn.addEventListener('click', function () {
        // Kích hoạt tất cả các ô input
        formInputs.forEach(input => {
            input.disabled = false;
        });

        // Ẩn nút "Edit" và hiện nút "Save"
        editBtn.style.display = 'none';
        saveBtn.style.display = 'inline-block';
        
        // Tự động focus vào ô input đầu tiên
        if (formInputs.length > 0) {
            formInputs[0].focus();
        }
    });

    // Xử lý sự kiện khi form được gửi đi (nhấn nút "Save")
    profileForm.addEventListener('submit', function (event) {
        event.preventDefault(); // Ngăn trang tải lại

        // Trong một ứng dụng thực tế, đây là nơi bạn sẽ gửi dữ liệu lên server
        // Ví dụ: using fetch() API
        console.log('Form data would be sent to the server now.');

        // Vô hiệu hóa lại tất cả các ô input
        formInputs.forEach(input => {
            input.disabled = true;
        });

        // Hiện nút "Edit" và ẩn nút "Save"
        editBtn.style.display = 'inline-block';
        saveBtn.style.display = 'none';
        
        alert('Profile saved successfully!'); // Thông báo giả
    });
});