<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý tin chờ duyệt - Admin</title>
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
                        <a class="nav-link active" href="${pageContext.request.contextPath}/admin/pending">
                            <i class="fas fa-clock"></i> Tin chờ duyệt
                        </a>
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/users">
                            <i class="fas fa-users"></i> Quản lý người dùng
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
                        <i class="fas fa-clock"></i> Quản lý tin chờ duyệt
                    </h2>
                    
                    <c:if test="${not empty success}">
                        <div class="alert alert-success" role="alert">
                            <i class="fas fa-check-circle"></i> ${success}
                        </div>
                    </c:if>
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger" role="alert">
                            <i class="fas fa-exclamation-triangle"></i> ${error}
                        </div>
                    </c:if>
                    
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0">
                                <i class="fas fa-list"></i> Danh sách tin chờ duyệt
                            </h5>
                        </div>
                        <div class="card-body">
                            <c:choose>
                                <c:when test="${empty pendingListings}">
                                    <div class="text-center py-5">
                                        <i class="fas fa-check-circle fa-3x text-success mb-3"></i>
                                        <h4 class="text-success">Không có tin nào chờ duyệt</h4>
                                        <p class="text-muted">Tất cả tin đăng đã được xử lý</p>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="table-responsive">
                                        <table class="table table-hover">
                                            <thead class="table-dark">
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Tiêu đề</th>
                                                    <th>Người đăng</th>
                                                    <th>Loại</th>
                                                    <th>Giá</th>
                                                    <th>Diện tích</th>
                                                    <th>Ngày đăng</th>
                                                    <th>Thao tác</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach items="${pendingListings}" var="listing">
                                                    <tr>
                                                        <td>${listing.id}</td>
                                                        <td>
                                                            <a href="${pageContext.request.contextPath}/listing/${listing.id}" 
                                                               class="text-decoration-none" target="_blank">
                                                                ${listing.title}
                                                            </a>
                                                        </td>
                                                        <td>${listing.user.fullname}</td>
                                                        <td>${listing.category.name}</td>
                                                        <td>${listing.formattedPrice}</td>
                                                        <td>${listing.formattedArea}</td>
                                                        <td>${listing.createdAt}</td>
                                                        <td>
                                                            <form action="${pageContext.request.contextPath}/admin" 
                                                                  method="post" style="display: inline;">
                                                                <input type="hidden" name="listingId" value="${listing.id}">
                                                                <button type="submit" name="action" value="approve" 
                                                                        class="btn btn-success btn-sm">
                                                                    <i class="fas fa-check"></i> Duyệt
                                                                </button>
                                                                <button type="submit" name="action" value="reject" 
                                                                        class="btn btn-danger btn-sm">
                                                                    <i class="fas fa-times"></i> Từ chối
                                                                </button>
                                                            </form>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 