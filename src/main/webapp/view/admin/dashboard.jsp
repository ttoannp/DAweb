<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Nhà Đất</title>
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
        .stats-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            padding: 1.5rem;
            text-align: center;
        }
        .stats-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
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
                        <a class="nav-link active" href="${pageContext.request.contextPath}/admin">
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
                        <i class="fas fa-tachometer-alt"></i> Dashboard
                    </h2>
                    
                    <!-- Stats Cards -->
                    <div class="row mb-4">
                        <div class="col-md-4 mb-3">
                            <div class="stats-card">
                                <div class="stats-icon text-primary">
                                    <i class="fas fa-clock"></i>
                                </div>
                                <h3>${pendingListings.size()}</h3>
                                <p class="text-muted">Tin chờ duyệt</p>
                            </div>
                        </div>
                        <div class="col-md-4 mb-3">
                            <div class="stats-card">
                                <div class="stats-icon text-success">
                                    <i class="fas fa-users"></i>
                                </div>
                                <h3>${allUsers.size()}</h3>
                                <p class="text-muted">Tổng người dùng</p>
                            </div>
                        </div>
                        <div class="col-md-4 mb-3">
                            <div class="stats-card">
                                <div class="stats-icon text-info">
                                    <i class="fas fa-home"></i>
                                </div>
                                <h3>${approvedListingsCount}</h3>
                                <p class="text-muted">Tin đã duyệt</p>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Recent Pending Listings -->
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0">
                                <i class="fas fa-clock"></i> Tin chờ duyệt gần đây
                            </h5>
                        </div>
                        <div class="card-body">
                            <c:choose>
                                <c:when test="${empty pendingListings}">
                                    <p class="text-muted text-center">Không có tin nào chờ duyệt</p>
                                </c:when>
                                <c:otherwise>
                                    <div class="table-responsive">
                                        <table class="table table-hover">
                                            <thead>
                                                <tr>
                                                    <th>Tiêu đề</th>
                                                    <th>Người đăng</th>
                                                    <th>Giá</th>
                                                    <th>Ngày đăng</th>
                                                    <th>Thao tác</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach items="${pendingListings}" var="listing" varStatus="status">
                                                    <c:if test="${status.index < 5}">
                                                        <tr>
                                                            <td>
                                                                <a href="${pageContext.request.contextPath}/listing/${listing.id}" 
                                                                   class="text-decoration-none">
                                                                    ${listing.title}
                                                                </a>
                                                            </td>
                                                            <td>${listing.user.fullname}</td>
                                                            <td>${listing.formattedPrice}</td>
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
                                                    </c:if>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="text-center">
                                        <a href="${pageContext.request.contextPath}/admin/pending" class="btn btn-primary">
                                            Xem tất cả tin chờ duyệt
                                        </a>
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