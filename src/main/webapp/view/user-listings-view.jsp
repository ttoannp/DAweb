<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tin đăng đã duyệt</title>
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
                    <i class="fas fa-check-circle text-success"></i> Tin đăng đã duyệt
                </h1>
                
                <c:if test="${empty listings}">
                    <div class="alert alert-info">
                        <i class="fas fa-info-circle"></i> Không có tin đăng nào đã được duyệt.
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
                                    <span class="badge bg-success status-badge mb-2">
                                        <i class="fas fa-check-circle"></i> Đã duyệt
                                    </span>
                                    
                                    <div class="btn-group-vertical w-100">
                                        <a href="${pageContext.request.contextPath}/listing/${listing.id}" 
                                           class="btn btn-outline-primary btn-sm mb-2">
                                            <i class="fas fa-eye"></i> Xem chi tiết
                                        </a>
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
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 