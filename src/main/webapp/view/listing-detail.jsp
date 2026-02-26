<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${listing.title} - Nhà Đất</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .listing-image {
            width: 100%;
            height: 400px;
            object-fit: cover;
            border-radius: 15px;
        }
        .image-gallery {
            height: 100px;
            object-fit: cover;
            border-radius: 10px;
            cursor: pointer;
            transition: opacity 0.3s;
        }
        .image-gallery:hover {
            opacity: 0.8;
        }
        .info-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            padding: 1.5rem;
        }
        .price-badge {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: bold;
            font-size: 1.2rem;
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
        <div class="row">
            <!-- Hình ảnh và thông tin chính -->
            <div class="col-lg-8">
                <div class="info-card mb-4">
                    <h2 class="mb-3">${listing.title}</h2>
                    
                    <!-- Hình ảnh chính -->
                    <c:choose>
                        <c:when test="${not empty listing.images}">
                            <img src="${pageContext.request.contextPath}${listing.images[0].url}" class="listing-image mb-3" alt="${listing.title}">
                            
                            <!-- Gallery ảnh -->
                            <c:if test="${listing.images.size() > 1}">
                                <div class="row">
                                    <c:forEach items="${listing.images}" var="image" varStatus="status">
                                        <div class="col-md-3 mb-2">
                                            <img src="${pageContext.request.contextPath}${image.url}" class="image-gallery w-100" 
                                                 alt="Hình ảnh ${status.index + 1}">
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:if>
                        </c:when>
                        <c:otherwise>
                            <div class="listing-image bg-light d-flex align-items-center justify-content-center mb-3">
                                <i class="fas fa-home fa-5x text-muted"></i>
                            </div>
                        </c:otherwise>
                    </c:choose>
                    
                    <!-- Thông tin chi tiết -->
                    <div class="row mb-4">
                        <div class="col-md-6">
                            <h5><i class="fas fa-map-marker-alt text-primary"></i> Địa chỉ</h5>
                            <p>${listing.location.fullAddress}</p>
                        </div>
                        <div class="col-md-6">
                            <h5><i class="fas fa-ruler-combined text-primary"></i> Diện tích</h5>
                            <p>${listing.formattedArea}</p>
                        </div>
                    </div>
                    
                    <div class="row mb-4">
                        <div class="col-md-6">
                            <h5><i class="fas fa-tag text-primary"></i> Loại bất động sản</h5>
                            <p>${listing.category.name}</p>
                        </div>
                        <div class="col-md-6">
                            <h5><i class="fas fa-calendar text-primary"></i> Ngày đăng</h5>
                            <p>${listing.createdAt}</p>
                        </div>
                    </div>
                    
                    <h5><i class="fas fa-align-left text-primary"></i> Mô tả chi tiết</h5>
                    <p class="text-muted">${listing.description}</p>
                </div>
            </div>
            
            <!-- Sidebar thông tin liên hệ -->
            <div class="col-lg-4">
                <!-- Thông tin giá -->
                <div class="info-card mb-4">
                    <div class="text-center mb-3">
                        <span class="price-badge">${listing.formattedPrice}</span>
                    </div>
                    
                    <h5><i class="fas fa-user text-primary"></i> Thông tin người đăng</h5>
                    <ul class="list-unstyled">
                        <li><strong>Tên:</strong> ${listing.user.fullname}</li>
                        <li><strong>SĐT:</strong> ${listing.user.phone}</li>
                        <li><strong>Email:</strong> ${listing.user.email}</li>
                    </ul>
                </div>
                

            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 