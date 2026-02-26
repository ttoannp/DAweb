-- Dữ liệu mẫu cho bảng Categories
INSERT INTO Categories (name) VALUES 
('Nhà riêng'),
('Căn hộ chung cư'),
('Biệt thự'),
('Nhà phố'),
('Đất nền'),
('Văn phòng'),
('Cửa hàng'),
('Kho xưởng'),
('Nhà trọ'),
('Căn hộ dịch vụ');

-- Dữ liệu mẫu cho bảng Users (mật khẩu: 123456)
INSERT INTO Users (username, password, fullname, phone, email, role, created_at) VALUES 
('admin', '123456', 'Administrator', '0123456789', 'admin@nhadat.com', 'admin', NOW()),
('user1', '123456', 'Nguyễn Văn A', '0987654321', 'user1@email.com', 'user', NOW()),
('user2', '123456', 'Trần Thị B', '0976543210', 'user2@email.com', 'user', NOW()),
('user3', '123456', 'Lê Văn C', '0965432109', 'user3@email.com', 'user', NOW());

-- Dữ liệu mẫu cho bảng Locations
INSERT INTO Locations (province, district, ward, address) VALUES 
('Hà Nội', 'Ba Đình', 'Phúc Xá', '123 Đường ABC'),
('Hà Nội', 'Hoàn Kiếm', 'Hàng Bạc', '456 Đường XYZ'),
('TP. Hồ Chí Minh', 'Quận 1', 'Bến Nghé', '789 Đường DEF'),
('TP. Hồ Chí Minh', 'Quận 3', 'Võ Thị Sáu', '321 Đường GHI'),
('Đà Nẵng', 'Hải Châu', 'Thạch Thang', '654 Đường JKL'),
('Hải Phòng', 'Hồng Bàng', 'Hoàng Văn Thụ', '987 Đường MNO');

-- Dữ liệu mẫu cho bảng Listings
INSERT INTO Listings (user_id, title, description, price, area, location_id, category_id, status, created_at) VALUES 
(2, 'Nhà riêng 3 tầng tại Ba Đình', 'Nhà riêng 3 tầng, 4 phòng ngủ, 3 phòng tắm, có gara ô tô', 2500000000, 120.5, 1, 1, 'pending', NOW()),
(3, 'Căn hộ 2 phòng ngủ tại Quận 1', 'Căn hộ cao cấp, view đẹp, tiện ích đầy đủ', 1800000000, 85.0, 3, 2, 'pending', NOW()),
(4, 'Đất nền 100m2 tại Đà Nẵng', 'Đất nền mặt tiền, vị trí đẹp, tiềm năng đầu tư cao', 800000000, 100.0, 5, 5, 'pending', NOW()),
(2, 'Văn phòng cho thuê tại Hải Phòng', 'Văn phòng 200m2, trang thiết bị hiện đại, vị trí thuận lợi', 15000000, 200.0, 6, 6, 'pending', NOW());

-- Dữ liệu mẫu cho bảng Images
INSERT INTO Images (listing_id, url) VALUES 
(1, 'https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=800'),
(1, 'https://images.unsplash.com/photo-1570129477492-45c003edd2be?w=800'),
(2, 'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=800'),
(2, 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=800'),
(3, 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800'),
(4, 'https://images.unsplash.com/photo-1497366216548-37526070297c?w=800');

-- Dữ liệu mẫu cho bảng Contacts
INSERT INTO Contacts (listing_id, user_id, message, contact_time) VALUES 
(1, 3, 'Tôi quan tâm đến căn nhà này, có thể xem trực tiếp được không?', NOW()),
(2, 4, 'Căn hộ này còn cho thuê không? Tôi muốn thuê dài hạn', NOW()),
(3, 2, 'Đất này có sổ đỏ không? Tôi muốn mua để xây nhà', NOW()); 