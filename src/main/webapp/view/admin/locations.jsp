<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý địa điểm - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .sidebar {
            min-height: 100vh;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        .sidebar .nav-link {
            color: white;
            padding: 1rem;
            border-radius: 10px;
            margin: 0.2rem 0;
        }
        .sidebar .nav-link:hover {
            background: rgba(255,255,255,0.1);
        }
        .sidebar .nav-link.active {
            background: rgba(255,255,255,0.2);
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3 col-lg-2 sidebar">
                <div class="p-3">
                    <h4 class="text-white mb-4">
                        <i class="fas fa-cog"></i> Admin Panel
                    </h4>
                    <nav class="nav flex-column">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin">
                            <i class="fas fa-tachometer-alt"></i> Dashboard
                        </a>
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/pending">
                            <i class="fas fa-clock"></i> Tin chờ duyệt
                        </a>
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/users">
                            <i class="fas fa-users"></i> Quản lý người dùng
                        </a>
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/categories">
                            <i class="fas fa-tags"></i> Quản lý danh mục
                        </a>
                        <a class="nav-link active" href="${pageContext.request.contextPath}/admin/locations">
                            <i class="fas fa-map-marker-alt"></i> Quản lý địa điểm
                        </a>
                        <a class="nav-link" href="${pageContext.request.contextPath}/home">
                            <i class="fas fa-home"></i> Về trang chủ
                        </a>
                        <a class="nav-link" href="${pageContext.request.contextPath}/logout">
                            <i class="fas fa-sign-out-alt"></i> Đăng xuất
                        </a>
                    </nav>
                </div>
            </div>
            
            <!-- Main Content -->
            <div class="col-md-9 col-lg-10">
                <div class="p-4">
                    <h2 class="mb-4">
                        <i class="fas fa-map-marker-alt"></i> Quản lý địa điểm
                    </h2>
                    
                    <!-- Thông báo -->
                    <c:if test="${not empty success}">
                        <div class="alert alert-success">
                            <i class="fas fa-check-circle"></i> ${success}
                        </div>
                    </c:if>
                    
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">
                            <i class="fas fa-exclamation-triangle"></i> ${error}
                        </div>
                    </c:if>
                    
                    <div class="row">
                        <!-- Form thêm tỉnh/thành mới -->
                        <div class="col-md-6">
                            <div class="card mb-4">
                                <div class="card-header">
                                    <h5 class="mb-0">
                                        <i class="fas fa-plus"></i> Thêm tỉnh/thành mới
                                    </h5>
                                </div>
                                <div class="card-body">
                                    <form action="${pageContext.request.contextPath}/admin" method="post">
                                        <div class="mb-3">
                                            <label for="province" class="form-label">Tên tỉnh/thành</label>
                                            <input type="text" class="form-control" id="province" name="province" 
                                                   placeholder="Nhập tên tỉnh/thành..." required>
                                        </div>
                                        <button type="submit" name="action" value="addProvince" class="btn btn-primary">
                                            <i class="fas fa-plus"></i> Thêm tỉnh/thành
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Form thêm quận/huyện mới -->
                        <div class="col-md-6">
                            <div class="card mb-4">
                                <div class="card-header">
                                    <h5 class="mb-0">
                                        <i class="fas fa-plus"></i> Thêm quận/huyện mới
                                    </h5>
                                </div>
                                <div class="card-body">
                                    <form action="${pageContext.request.contextPath}/admin" method="post">
                                        <div class="mb-3">
                                            <label for="provinceSelect" class="form-label">Tỉnh/thành</label>
                                            <select class="form-select" id="provinceSelect" name="province" required>
                                                <option value="">Chọn tỉnh/thành</option>
                                                <c:forEach items="${provinces}" var="province">
                                                    <option value="${province}">${province}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="mb-3">
                                            <label for="district" class="form-label">Tên quận/huyện</label>
                                            <input type="text" class="form-control" id="district" name="district" 
                                                   placeholder="Nhập tên quận/huyện..." required>
                                        </div>
                                        <button type="submit" name="action" value="addDistrict" class="btn btn-primary">
                                            <i class="fas fa-plus"></i> Thêm quận/huyện
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Danh sách tỉnh/thành -->
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0">
                                <i class="fas fa-list"></i> Danh sách tỉnh/thành
                            </h5>
                        </div>
                        <div class="card-body">
                            <c:if test="${empty provinces}">
                                <p class="text-muted text-center">Chưa có tỉnh/thành nào</p>
                            </c:if>
                            
                            <c:if test="${not empty provinces}">
                                <div class="row">
                                    <c:forEach items="${provinces}" var="province" varStatus="status">
                                        <div class="col-md-4 mb-2">
                                            <div class="card">
                                                <div class="card-body">
                                                    <h6 class="card-title">
                                                        <i class="fas fa-map-marker-alt"></i> ${province}
                                                    </h6>
                                                    <small class="text-muted">Tỉnh/Thành phố</small>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 