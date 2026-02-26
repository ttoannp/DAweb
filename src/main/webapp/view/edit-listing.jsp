<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa tin đăng - Nhà Đất</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .hero-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 3rem 0;
        }
        .form-section {
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            padding: 2rem;
        }
        .btn-submit {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            padding: 0.75rem 2rem;
            font-weight: bold;
        }
        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        .navbar-brand {
            font-weight: bold;
            font-size: 1.5rem;
        }
        .image-preview {
            max-width: 150px;
            max-height: 150px;
            object-fit: cover;
            border-radius: 10px;
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
                <a class="nav-link" href="${pageContext.request.contextPath}/user-listings">
                    <i class="fas fa-arrow-left"></i> Về quản lý tin
                </a>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero-section">
        <div class="container text-center">
            <h1 class="display-5 mb-3">
                <i class="fas fa-edit"></i> Chỉnh sửa tin đăng
            </h1>
            <p class="lead">Cập nhật thông tin tin đăng của bạn</p>
        </div>
    </section>

    <!-- Form Section -->
    <section class="py-5">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-10">
                    <div class="form-section">
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
                        
                        <form action="${pageContext.request.contextPath}/edit-listing/${listing.id}" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="listingId" value="${listing.id}">
                            
                            <!-- Thông tin cơ bản -->
                            <div class="row">
                                <div class="col-md-8 mb-3">
                                    <label for="title" class="form-label">
                                        <i class="fas fa-heading"></i> Tiêu đề tin *
                                    </label>
                                    <input type="text" class="form-control" id="title" name="title" 
                                           value="${listing.title}" required>
                                </div>
                                <div class="col-md-4 mb-3">
                                    <label for="categoryId" class="form-label">
                                        <i class="fas fa-tag"></i> Loại bất động sản *
                                    </label>
                                    <select class="form-select" id="categoryId" name="categoryId" required>
                                        <option value="">Chọn loại</option>
                                        <c:forEach items="${categories}" var="category">
                                            <option value="${category.id}" ${category.id == listing.categoryId ? 'selected' : ''}>
                                                ${category.name}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label for="description" class="form-label">
                                    <i class="fas fa-align-left"></i> Mô tả chi tiết *
                                </label>
                                <textarea class="form-control" id="description" name="description" rows="4" required>${listing.description}</textarea>
                            </div>
                            
                            <!-- Thông tin giá và diện tích -->
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="price" class="form-label">
                                        <i class="fas fa-money-bill-wave"></i> Giá (VND) *
                                    </label>
                                    <input type="number" class="form-control" id="price" name="price" 
                                           value="${listing.price}" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="area" class="form-label">
                                        <i class="fas fa-ruler-combined"></i> Diện tích (m2) *
                                    </label>
                                    <input type="number" step="0.1" class="form-control" id="area" name="area" 
                                           value="${listing.area}" required>
                                </div>
                            </div>
                            
                            <!-- Thông tin địa chỉ -->
                            <h5 class="mb-3"><i class="fas fa-map-marker-alt"></i> Thông tin địa chỉ</h5>
                            <div class="row">
                                <div class="col-md-3 mb-3">
                                    <label for="province" class="form-label">Tỉnh/Thành *</label>
                                    <select class="form-select" id="province" name="province" required>
                                        <option value="">Chọn tỉnh</option>
                                        <c:forEach items="${provinces}" var="province">
                                            <option value="${province}" ${province == listing.location.province ? 'selected' : ''}>
                                                ${province}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <label for="district" class="form-label">Quận/Huyện *</label>
                                    <select class="form-select" id="district" name="district" required>
                                        <option value="">Chọn quận/huyện</option>
                                        <c:forEach items="${districts}" var="district">
                                            <option value="${district}" ${district == listing.location.district ? 'selected' : ''}>
                                                ${district}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-3 mb-3">
                                    <label for="ward" class="form-label">Phường/Xã</label>
                                    <input type="text" class="form-control" id="ward" name="ward" 
                                           value="${listing.location.ward}">
                                </div>
                                <div class="col-md-3 mb-3">
                                    <label for="address" class="form-label">Địa chỉ chi tiết</label>
                                    <input type="text" class="form-control" id="address" name="address" 
                                           value="${listing.location.address}">
                                </div>
                            </div>
                            
                            <!-- Ảnh hiện tại -->
                            <h5 class="mb-3"><i class="fas fa-images"></i> Ảnh hiện tại</h5>
                            <div class="row mb-3">
                                <c:forEach items="${listing.images}" var="image">
                                    <div class="col-md-3 mb-2">
                                        <img src="${pageContext.request.contextPath}${image.url}" class="image-preview w-100" alt="Ảnh hiện tại">
                                    </div>
                                </c:forEach>
                            </div>
                            
                            <!-- Upload ảnh mới -->
                            <h5 class="mb-3"><i class="fas fa-plus"></i> Thêm ảnh mới (tùy chọn)</h5>
                            <div class="mb-3">
                                <label for="images" class="form-label">Chọn hình ảnh</label>
                                <input type="file" class="form-control" id="images" name="images" multiple accept="image/*">
                                <div class="form-text">Chọn nhiều hình ảnh (JPG, PNG, GIF)</div>
                            </div>
                            <div id="imagePreview" class="row mb-3"></div>
                            
                            <div class="text-center">
                                <button type="submit" class="btn btn-primary btn-submit">
                                    <i class="fas fa-save"></i> Cập nhật tin
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function loadDistricts() {
            const province = document.getElementById('province').value;
            const districtSelect = document.getElementById('district');
            
            // Reset district dropdown
            districtSelect.innerHTML = '<option value="">Chọn quận/huyện</option>';
            
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
        
        // Add event listener to province select
        document.getElementById('province').addEventListener('change', loadDistricts);
        
        // Image preview functionality
        document.getElementById('images').addEventListener('change', function(e) {
            const preview = document.getElementById('imagePreview');
            preview.innerHTML = '';
            
            const files = e.target.files;
            for (let i = 0; i < files.length; i++) {
                const file = files[i];
                if (file.type.startsWith('image/')) {
                    const reader = new FileReader();
                    reader.onload = function(e) {
                        const col = document.createElement('div');
                        col.className = 'col-md-3 mb-2';
                        col.innerHTML = `
                            <div class="card">
                                <img src="${e.target.result}" class="card-img-top" style="height: 150px; object-fit: cover;" alt="Preview">
                                <div class="card-body p-2">
                                    <small class="text-muted">${file.name}</small>
                                </div>
                            </div>
                        `;
                        preview.appendChild(col);
                    };
                    reader.readAsDataURL(file);
                }
            }
        });
    </script>
</body>
</html> 