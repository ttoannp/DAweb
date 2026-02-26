🏠 Real Estate Listing Web Application

Ứng dụng web cho phép người dùng đăng tin mua bán/cho thuê bất động sản, tìm kiếm theo nhiều tiêu chí và quản lý tin đăng. Hệ thống có phân quyền User / Admin, hỗ trợ quy trình duyệt tin trước khi hiển thị công khai.

🎯 Mục tiêu dự án

Xây dựng nền tảng đăng tin bất động sản end-to-end

Thiết kế hệ thống tìm kiếm đa tiêu chí (từ khóa, vị trí, loại BĐS, khoảng giá, sắp xếp)

Áp dụng kiến trúc phân tầng (Controller → BO → DAO → Database)

Triển khai module quản trị và cơ chế duyệt tin

🚀 Chức năng chính
👤 Người dùng

Đăng ký / Đăng nhập / Quản lý hồ sơ

Đăng tin bất động sản (tiêu đề, giá, diện tích, vị trí, danh mục)

Upload nhiều hình ảnh cho mỗi tin

Tìm kiếm & lọc theo:

Từ khóa

Tỉnh/Thành – Quận/Huyện

Danh mục

Khoảng giá

Sắp xếp theo thời gian

Quản lý tin cá nhân

Xem chi tiết tin và thông tin người đăng

🛠 Quản trị viên (Admin)

Dashboard thống kê

Duyệt / Từ chối tin đăng

Quản lý danh mục bất động sản

Quản lý địa điểm (tỉnh/thành, quận/huyện)

Quản lý người dùng

🏗 Kiến trúc hệ thống

Áp dụng Layered Architecture:

Controller (Servlet)
→ BO (Business Layer)
→ DAO (JDBC)
→ MySQL Database

Ưu điểm:

Tách biệt rõ logic nghiệp vụ và truy xuất dữ liệu

Dễ bảo trì, mở rộng

Hỗ trợ phát triển module admin độc lập

🗄 Thiết kế dữ liệu (ER chính)

Users (role: user/admin)

Listings (status: pending / approved / rejected)

Categories

Locations

Images

Quan hệ:

1 User → N Listings

1 Listing → N Images

1 Category → N Listings

🧰 Công nghệ sử dụng
Backend

Java (Jakarta Servlet)

JSP + JSTL

JDBC

MySQL

Maven

Frontend

Bootstrap 5

Font Awesome

JavaScript + Fetch API

Multipart file upload

🔄 Luồng xử lý chính

Đăng tin:
User → Submit form → Validate → Lưu Location → Lưu Listing (status = pending) → Lưu Images → Chờ Admin duyệt

Tìm kiếm:
HomeServlet → Nhận filter → DAO build SQL động → Trả về danh sách approved listings

Duyệt tin:
Admin → Dashboard → Approve/Reject → Update status → Hiển thị công khai

💡 Kỹ năng áp dụng

Thiết kế kiến trúc phân tầng trong Java Web

Xử lý upload nhiều file (multipart/form-data)

Viết truy vấn SQL động (search + filter + sort)

Thiết kế CSDL quan hệ cho hệ thống thực tế

Triển khai phân quyền dựa trên session & role

Xây dựng Admin Dashboard
