<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý tin đăng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .listing-card {
            border: 1px solid #dee2e6;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            background: white;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .status-badge {
            font-size: 0.8rem;
        }
    </style>
</head>
<body>
    <div class="container mt-4">
        <div class="row">
            <div class="col-12">
                <h1 class="mb-4">
                    <i class="fas fa-list"></i> Quản lý tin đăng của tôi
                </h1>
                
                <!-- Thông báo -->
                <c:if test="${not empty message}">
                    <div class="alert alert-success">
                        <i class="fas fa-check-circle"></i> ${message}
                    </div>
                </c:if>
                
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">
                        <i class="fas fa-exclamation-triangle"></i> ${error}
                    </div>
                </c:if>
                
                <c:if test="${empty listings}">
                    <div class="alert alert-info">
                        <i class="fas fa-info-circle"></i> Bạn chưa có tin đăng nào.
                        <a href="${pageContext.request.contextPath}/listing" class="btn btn-primary btn-sm ms-2">
                            <i class="fas fa-plus"></i> Đăng tin mới
                        </a>
                    </div>
                </c:if>
                
                <c:forEach items="${listings}" var="listing">
                    <div class="listing-card">
                        <div class="row">
                            <div class="col-md-8">
                                <h5><i class="fas fa-home"></i> ${listing.title}</h5>
                                <p class="text-muted">${listing.description}</p>
                                
                                <div class="row">
                                    <div class="col-md-6">
                                        <p><i class="fas fa-map-marker-alt"></i> <strong>Địa chỉ:</strong></p>
                                        <p class="text-muted">${listing.location.fullAddress}</p>
                                    </div>
                                    <div class="col-md-6">
                                        <p><i class="fas fa-ruler-combined"></i> <strong>Diện tích:</strong> ${listing.area} m2</p>
                                        <p><i class="fas fa-dollar-sign"></i> <strong>Giá:</strong> 
                                            <fmt:formatNumber value="${listing.price}" pattern="#,###" /> VND
                                        </p>
                                    </div>
                                </div>
                                
                                <div class="mt-2">
                                    <small class="text-muted">
                                        <i class="fas fa-clock"></i> Đăng ngày: 
                                        <fmt:formatDate value="${listing.createdAt}" pattern="dd/MM/yyyy HH:mm" />
                                    </small>
                                </div>
                            </div>
                            
                            <div class="col-md-4">
                                <div class="text-end">
                                    <!-- Status Badge -->
                                    <span class="badge bg-${listing.status == 'approved' ? 'success' : listing.status == 'pending' ? 'warning' : 'secondary'} status-badge mb-2">
                                        <i class="fas fa-circle"></i> ${listing.status}
                                    </span>
                                    
                                    <div class="btn-group-vertical w-100">
                                        <a href="${pageContext.request.contextPath}/listing/${listing.id}" 
                                           class="btn btn-outline-primary btn-sm mb-2">
                                            <i class="fas fa-eye"></i> Xem chi tiết
                                        </a>
                                        
                                                                                 <c:if test="${listing.status == 'pending'}">
                                             <a href="${pageContext.request.contextPath}/edit-listing/${listing.id}"
                                                class="btn btn-outline-warning btn-sm mb-2">
                                                 <i class="fas fa-edit"></i> Chỉnh sửa
                                             </a>
                                         </c:if>
                                         
                                         <c:if test="${listing.status == 'approved'}">
                                             <a href="${pageContext.request.contextPath}/edit-listing/${listing.id}"
                                                class="btn btn-outline-info btn-sm mb-2">
                                                 <i class="fas fa-edit"></i> Chỉnh sửa
                                             </a>
                                         </c:if>
                                        
                                        <button class="btn btn-outline-danger btn-sm" 
                                                onclick="confirmDelete(${listing.id}, '${listing.title}')">
                                            <i class="fas fa-trash"></i> Xóa
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                
                <!-- Nút quay lại -->
                <div class="mt-4">
                    <a href="${pageContext.request.contextPath}/home" class="btn btn-primary">
                        <i class="fas fa-home"></i> Trang chủ
                    </a>
                    <a href="${pageContext.request.contextPath}/listing" class="btn btn-success">
                        <i class="fas fa-plus"></i> Đăng tin mới
                    </a>

                </div>
            </div>
        </div>
    </div>

    <!-- Form ẩn để xóa tin đăng -->
    <form id="deleteForm" method="post" style="display: none;">
        <input type="hidden" name="action" value="delete">
        <input type="hidden" name="listingId" id="listingIdToDelete">
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function confirmDelete(listingId, title) {
            if (confirm('Bạn có chắc chắn muốn xóa tin đăng "' + title + '"?')) {
                document.getElementById('listingIdToDelete').value = listingId;
                document.getElementById('deleteForm').submit();
            }
        }
    </script>
</body>
</html> 