<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông tin cá nhân - Nhà Đất</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .profile-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            padding: 2rem;
        }
        .form-control, .form-select {
            border-radius: 10px;
            border: 2px solid #e9ecef;
            padding: 12px 15px;
        }
        .form-control:focus, .form-select:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
        .btn-submit {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 10px;
            padding: 12px 30px;
            font-weight: 600;
        }
        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }
        .navbar-brand {
            font-weight: bold;
            font-size: 1.5rem;
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
                <i class="fas fa-home"></i> Nhà Đất
            </a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="${pageContext.request.contextPath}/home">
                    <i class="fas fa-arrow-left"></i> Về trang chủ
                </a>
            </div>
        </div>
    </nav>

    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="profile-container">
                    <h2 class="text-center mb-4">
                        <i class="fas fa-user-edit"></i> Thông tin cá nhân
                    </h2>
                    
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger" role="alert">
                            <i class="fas fa-exclamation-triangle"></i> <span style="font-family: Arial, sans-serif;">${error}</span>
                        </div>
                    </c:if>
                    <c:if test="${not empty success}">
                        <div class="alert alert-success" role="alert">
                            <i class="fas fa-check-circle"></i> <span style="font-family: Arial, sans-serif;">${success}</span>
                        </div>
                    </c:if>
                    
                    <form action="${pageContext.request.contextPath}/profile" method="post">
                        <!-- Thông tin cơ bản -->
                        <h5 class="mb-3"><i class="fas fa-user"></i> Thông tin cơ bản</h5>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="username" class="form-label">
                                    <i class="fas fa-user"></i> Tên đăng nhập
                                </label>
                                <input type="text" class="form-control" id="username" value="${user.username}" readonly>
                                <div class="form-text">Tên đăng nhập không thể thay đổi</div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="fullname" class="form-label">
                                    <i class="fas fa-id-card"></i> Họ và tên *
                                </label>
                                <input type="text" class="form-control" id="fullname" name="fullname" 
                                       value="${user.fullname}" required>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="phone" class="form-label">
                                    <i class="fas fa-phone"></i> Số điện thoại *
                                </label>
                                <input type="tel" class="form-control" id="phone" name="phone" 
                                       value="${user.phone}" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="email" class="form-label">
                                    <i class="fas fa-envelope"></i> Email *
                                </label>
                                <input type="email" class="form-control" id="email" name="email" 
                                       value="${user.email}" required>
                            </div>
                        </div>
                        
                        <!-- Thay đổi mật khẩu -->
                        <h5 class="mb-3 mt-4"><i class="fas fa-lock"></i> Thay đổi mật khẩu (tùy chọn)</h5>
                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label for="currentPassword" class="form-label">
                                    <i class="fas fa-key"></i> Mật khẩu hiện tại
                                </label>
                                <input type="password" class="form-control" id="currentPassword" name="currentPassword">
                            </div>
                            <div class="col-md-4 mb-3">
                                <label for="newPassword" class="form-label">
                                    <i class="fas fa-lock"></i> Mật khẩu mới
                                </label>
                                <input type="password" class="form-control" id="newPassword" name="newPassword">
                            </div>
                            <div class="col-md-4 mb-3">
                                <label for="confirmPassword" class="form-label">
                                    <i class="fas fa-lock"></i> Xác nhận mật khẩu mới
                                </label>
                                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword">
                            </div>
                        </div>
                        
                        <div class="alert alert-info" role="alert">
                            <i class="fas fa-info-circle"></i> 
                            <span style="font-family: Arial, sans-serif;">
                                Để thay đổi mật khẩu, vui lòng nhập đầy đủ 3 trường mật khẩu ở trên.
                            </span>
                        </div>
                        
                        <div class="text-center">
                            <button type="submit" class="btn btn-primary btn-submit">
                                <i class="fas fa-save"></i> Cập nhật thông tin
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 