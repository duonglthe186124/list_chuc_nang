document.addEventListener('DOMContentLoaded', function () {
    const editBtn = document.getElementById('edit-btn');
    const saveBtn = document.getElementById('save-btn');
    const profileForm = document.getElementById('profile-form');
    
    // Chỉ lấy các input có thể chỉnh sửa (Email thường không được sửa)
    const formInputs = profileForm.querySelectorAll('input[name="fullname"], input[name="phone"], input[name="address"]');

    if (saveBtn) {
        saveBtn.style.display = 'none';
    }

    // Xử lý sự kiện khi nhấn nút "Edit"
    if(editBtn) {
        editBtn.addEventListener('click', function () {
            formInputs.forEach(input => {
                input.disabled = false;
                
                // Thêm các lớp Tailwind để người dùng biết là có thể sửa
                input.classList.add('bg-white', 'border-gray-300'); 
                input.classList.remove('bg-transparent', 'border-transparent');
            });

            editBtn.style.display = 'none';
            saveBtn.style.display = 'inline-block';
            
            if (formInputs.length > 0) {
                formInputs[0].focus();
            }
        });
    }

    // Xử lý sự kiện khi nhấn nút "Save"
    if(profileForm) {
        profileForm.addEventListener('submit', function (event) {
            // Chúng ta muốn form được gửi đi để ProfileServlet xử lý
            console.log('Form is submitting to the server...');
        });
    }

    // --- Logic cho Avatar ---
    const changeAvatarBtn = document.getElementById('change-avatar-btn');
    const avatarInput = document.getElementById('avatar-input');
    const avatarPreview = document.getElementById('avatar-preview');

    if (changeAvatarBtn) {
        changeAvatarBtn.addEventListener('click', function () {
            avatarInput.click();
        });
    }

    if (avatarInput) {
        avatarInput.addEventListener('change', function (event) {
            const file = event.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function (e) {
                    avatarPreview.src = e.target.result;
                };
                reader.readAsDataURL(file);
            }
        });
    }
});