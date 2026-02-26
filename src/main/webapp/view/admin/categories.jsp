<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý danh mục - Admin</title>
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
                        <a class="nav-link active" href="${pageContext.request.contextPath}/admin/categories">
                            <i class="fas fa-tags"></i> Quản lý danh mục
                        </a>
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/locations">
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
                        <i class="fas fa-tags"></i> Quản lý danh mục
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
                    
                    <!-- Form thêm danh mục mới -->
                    <div class="card mb-4">
                        <div class="card-header">
                            <h5 class="mb-0">
                                <i class="fas fa-plus"></i> Thêm danh mục mới
                            </h5>
                        </div>
                        <div class="card-body">
                            <form action="${pageContext.request.contextPath}/admin" method="post">
                                <div class="row">
                                    <div class="col-md-8">
                                        <input type="text" class="form-control" name="categoryName" 
                                               placeholder="Nhập tên danh mục..." required>
                                    </div>
                                    <div class="col-md-4">
                                        <button type="submit" name="action" value="addCategory" class="btn btn-primary">
                                            <i class="fas fa-plus"></i> Thêm danh mục
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    
                    <!-- Danh sách danh mục -->
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0">
                                <i class="fas fa-list"></i> Danh sách danh mục
                            </h5>
                        </div>
                        <div class="card-body">
                            <c:if test="${empty categories}">
                                <p class="text-muted text-center">Chưa có danh mục nào</p>
                            </c:if>
                            
                            <c:if test="${not empty categories}">
                                <div class="table-responsive">
                                    <table class="table table-hover">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Tên danh mục</th>
                                                <th>Thao tác</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${categories}" var="category">
                                                <tr>
                                                    <td>${category.id}</td>
                                                    <td>${category.name}</td>
                                                    <td>
                                                        <button class="btn btn-warning btn-sm" 
                                                                onclick="editCategory(${category.id}, '${category.name}')">
                                                            <i class="fas fa-edit"></i> Sửa
                                                        </button>
                                                        <button class="btn btn-danger btn-sm" 
                                                                onclick="deleteCategory(${category.id}, '${category.name}')">
                                                            <i class="fas fa-trash"></i> Xóa
                                                        </button>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Edit Category -->
    <div class="modal fade" id="editCategoryModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Sửa danh mục</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="${pageContext.request.contextPath}/admin" method="post">
                    <div class="modal-body">
                        <input type="hidden" name="categoryId" id="editCategoryId">
                        <div class="mb-3">
                            <label for="editCategoryName" class="form-label">Tên danh mục</label>
                            <input type="text" class="form-control" id="editCategoryName" name="categoryName" required>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" name="action" value="updateCategory" class="btn btn-primary">
                            <i class="fas fa-save"></i> Lưu thay đổi
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Form ẩn để xóa danh mục -->
    <form id="deleteCategoryForm" method="post" style="display: none;">
        <input type="hidden" name="action" value="deleteCategory">
        <input type="hidden" name="categoryId" id="deleteCategoryId">
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function editCategory(id, name) {
            document.getElementById('editCategoryId').value = id;
            document.getElementById('editCategoryName').value = name;
            new bootstrap.Modal(document.getElementById('editCategoryModal')).show();
        }
        
        function deleteCategory(id, name) {
            if (confirm('Bạn có chắc chắn muốn xóa danh mục "' + name + '"?')) {
                document.getElementById('deleteCategoryId').value = id;
                document.getElementById('deleteCategoryForm').submit();
            }
        }
    </script>
</body>
</html> 