<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang chủ - Nhà Đất</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .hero-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 4rem 0;
        }
        .search-section {
            background: white;
            padding: 2rem 0;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .listing-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
        }
        .listing-card:hover {
            transform: translateY(-5px);
        }
        .listing-image {
            height: 200px;
            object-fit: cover;
            border-radius: 15px 15px 0 0;
        }
        .price-badge {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: bold;
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
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/home">
                            <i class="fas fa-home"></i> Trang chủ
                        </a>
                    </li>
                                            <c:if test="${not empty sessionScope.user}">
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/listing">
                                    <i class="fas fa-plus"></i> Đăng tin
                                </a>
                            </li>
                                           <li class="nav-item">
                   <a class="nav-link" href="${pageContext.request.contextPath}/user-listings">
                       <i class="fas fa-list"></i> Quản lý tin
                   </a>
               </li>
                            <c:if test="${sessionScope.user.role == 'admin'}">
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/admin">
                                        <i class="fas fa-cog"></i> Quản lý
                                    </a>
                                </li>
                            </c:if>
                        </c:if>
                </ul>
                <ul class="navbar-nav">
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown">
                                    <i class="fas fa-user"></i> ${sessionScope.user.fullname}
                                </a>
                                                                 <ul class="dropdown-menu">
                                     <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile">
                                         <i class="fas fa-user-edit"></i> Thông tin cá nhân
                                     </a></li>
                                     <li><hr class="dropdown-divider"></li>
                                     <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                                         <i class="fas fa-sign-out-alt"></i> Đăng xuất
                                     </a></li>
                                 </ul>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/login">
                                    <i class="fas fa-sign-in-alt"></i> Đăng nhập
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/register">
                                    <i class="fas fa-user-plus"></i> Đăng ký
                                </a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero-section">
        <div class="container text-center">
            <h1 class="display-4 mb-4">
                <i class="fas fa-home"></i> Tìm kiếm nhà đất phù hợp
            </h1>
            <p class="lead">Hàng nghìn tin đăng bất động sản chất lượng cao</p>
        </div>
    </section>

    <!-- Search Section -->
    <section class="search-section">
        <div class="container">
            <form action="${pageContext.request.contextPath}/home" method="get" class="row g-3">
                <div class="col-md-3">
                    <label for="keyword" class="form-label">Từ khóa</label>
                    <input type="text" class="form-control" id="keyword" name="keyword" 
                           value="${keyword}" placeholder="Nhập từ khóa tìm kiếm...">
                </div>
                <div class="col-md-2">
                    <label for="province" class="form-label">Tỉnh/Thành</label>
                    <select class="form-select" id="province" name="province" onchange="loadDistricts()">
                        <option value="">Tất cả</option>
                        <c:forEach items="${provinces}" var="province">
                            <option value="${province}" ${province == param.province ? 'selected' : ''}>
                                ${province}
                            </option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-2">
                    <label for="district" class="form-label">Quận/Huyện</label>
                    <select class="form-select" id="district" name="district">
                        <option value="">Tất cả</option>
                        <c:forEach items="${districts}" var="district">
                            <option value="${district}" ${district == param.district ? 'selected' : ''}>
                                ${district}
                            </option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-1">
                    <label for="categoryId" class="form-label">Loại</label>
                    <select class="form-select" id="categoryId" name="categoryId">
                        <option value="">Tất cả</option>
                        <c:forEach items="${categories}" var="category">
                            <option value="${category.id}" ${category.id == param.categoryId ? 'selected' : ''}>
                                ${category.name}
                            </option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-1">
                    <label for="minPrice" class="form-label">Giá từ</label>
                    <input type="number" class="form-control" id="minPrice" name="minPrice" 
                           value="${minPrice}" placeholder="VNĐ">
                </div>
                <div class="col-md-1">
                    <label for="maxPrice" class="form-label">Giá đến</label>
                    <input type="number" class="form-control" id="maxPrice" name="maxPrice" 
                           value="${maxPrice}" placeholder="VNĐ">
                </div>
                <div class="col-md-1">
                    <label class="form-label">&nbsp;</label>
                    <button type="submit" class="btn btn-primary w-100">
                        <i class="fas fa-search"></i>
                    </button>
                </div>
            </form>
            
            <!-- Sorting Buttons -->
            <div class="row mt-3">
                <div class="col-12">
                    <div class="btn-group" role="group">
                        <a href="${pageContext.request.contextPath}/home?keyword=${keyword}&province=${province}&district=${district}&categoryId=${categoryId}&minPrice=${minPrice}&maxPrice=${maxPrice}&sortBy=newest" 
                           class="btn btn-outline-primary ${sortBy == 'newest' || empty sortBy ? 'active' : ''}">
                            <i class="fas fa-sort-amount-down"></i> Mới nhất
                        </a>
                        <a href="${pageContext.request.contextPath}/home?keyword=${keyword}&province=${province}&district=${district}&categoryId=${categoryId}&minPrice=${minPrice}&maxPrice=${maxPrice}&sortBy=oldest" 
                           class="btn btn-outline-primary ${sortBy == 'oldest' ? 'active' : ''}">
                            <i class="fas fa-sort-amount-up"></i> Cũ nhất
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Ranking Section -->
<section class="py-4 bg-light">
    <div class="container">
        <h3 class="mb-4">
            <i class="fas fa-trophy"></i> Bảng xếp hạng người dùng
        </h3>
        <div class="row">
            <c:forEach items="${topUsers}" var="user" varStatus="status" begin="0" end="2">
                <div class="col-md-6 col-lg-4 mb-3">
                    <div class="card">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="card-title mb-1">
                                        <c:choose>
                                            <c:when test="${status.index == 0}">
                                                <i class="fas fa-crown text-warning"></i>
                                            </c:when>
                                            <c:when test="${status.index == 1}">
                                                <i class="fas fa-medal text-secondary"></i>
                                            </c:when>
                                            <c:when test="${status.index == 2}">
                                                <i class="fas fa-award" style="color: #cd7f32;"></i> <!-- Bronze -->
                                            </c:when>
                                            <c:otherwise>
                                                <i class="fas fa-user"></i>
                                            </c:otherwise>
                                        </c:choose>
                                        ${user.fullname}
                                    </h6>
                                    <p class="card-text text-muted mb-2">
                                        <i class="fas fa-list"></i> ${user.listingCount} tin đăng
                                    </p>
                                </div>
                                <a href="${pageContext.request.contextPath}/view-user-listings/${user.id}" 
                                   class="btn btn-outline-primary btn-sm">
                                    <i class="fas fa-eye"></i> Xem tin
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</section>

    <!-- Listings Section -->
    <section class="py-5">
        <div class="container">
            <h2 class="mb-4">Danh sách bất động sản</h2>
            
            <c:if test="${empty listings}">
                <div class="text-center py-5">
                    <i class="fas fa-search fa-3x text-muted mb-3"></i>
                    <h4 class="text-muted">Không tìm thấy tin đăng nào</h4>
                    <p class="text-muted">Hãy thử thay đổi tiêu chí tìm kiếm</p>
                </div>
            </c:if>
            
            <div class="row">
                <c:forEach items="${listings}" var="listing">
                    <div class="col-md-6 col-lg-4 mb-4">
                        <div class="card listing-card h-100">
                            <c:choose>
                                <c:when test="${not empty listing.images}">
                                    <img src="${pageContext.request.contextPath}${listing.images[0].url}" class="card-img-top listing-image" 
                                         alt="${listing.title}">
                                </c:when>
                                <c:otherwise>
                                    <div class="card-img-top listing-image bg-light d-flex align-items-center justify-content-center">
                                        <i class="fas fa-home fa-3x text-muted"></i>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                            <div class="card-body">
                                <h5 class="card-title">${listing.title}</h5>
                                <p class="card-text text-muted">
                                    <i class="fas fa-map-marker-alt"></i> ${listing.location.fullAddress}
                                </p>
                                <p class="card-text">
                                    <i class="fas fa-ruler-combined"></i> ${listing.formattedArea}
                                </p>
                                <div class="d-flex justify-content-between align-items-center">
                                    <span class="price-badge">${listing.formattedPrice}</span>
                                    <a href="${pageContext.request.contextPath}/listing/${listing.id}" 
                                       class="btn btn-outline-primary btn-sm">
                                        <i class="fas fa-eye"></i> Xem chi tiết
                                    </a>
                                </div>
                            </div>
                            <div class="card-footer bg-transparent">
                                <small class="text-muted">
                                    <i class="fas fa-user"></i> ${listing.user.fullname} | 
                                    <i class="fas fa-clock"></i> ${listing.createdAt}
                                </small>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="bg-dark text-white py-4">
        <div class="container text-center">
            <p>&copy; 2025 Nhà Đất. Tất cả quyền được bảo lưu.</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function loadDistricts() {
            const province = document.getElementById('province').value;
            const districtSelect = document.getElementById('district');
            
            // Reset district dropdown
            districtSelect.innerHTML = '<option value="">Tất cả</option>';
            
            if (province) {
                fetch('${pageContext.request.contextPath}/location?action=getDistricts&province=' + encodeURIComponent(province))
                    .then(response => response.json())
                    .then(districts => {
                        districts.forEach(district => {
                            const option = document.createElement('option');
                            option.value = district;
                            option.textContent = district;
                            districtSelect.appendChild(option);
                        });
                    })
                    .catch(error => {
                        console.error('Error loading districts:', error);
                    });
            }
        }
        
        // Load districts on page load if province is selected
        document.addEventListener('DOMContentLoaded', function() {
            const province = document.getElementById('province').value;
            if (province) {
                loadDistricts();
            }
        });
    </script>
</body>
</html> 