-- BƯỚC 1: XÓA DỮ LIỆU CŨ (Thứ tự: Bảng con trước, bảng cha sau)
-- ====================================================================
DELETE FROM "order_items";
DELETE FROM "orders";
DELETE FROM "import_details";
DELETE FROM "imports";
DELETE FROM "cart_items";
DELETE FROM "carts";
DELETE FROM "reviews";
DELETE FROM "addresses";
DELETE FROM "product_images";
DELETE FROM "product_variants";
DELETE FROM "products";
DELETE FROM "vouchers";
DELETE FROM "users";
DELETE FROM "roles";
DELETE FROM "categories";
DELETE FROM "brands";

-- ====================================================================
-- BƯỚC 2: CHÈN DỮ LIỆU GỐC (Cha trước, con sau)
-- ====================================================================

-- 1. Roles
INSERT INTO "roles" ("id", "name") VALUES 
('11111111-1111-1111-1111-111111111111', 'Admin'),
('22222222-2222-2222-2222-222222222222', 'Customer');

-- 2. Users
INSERT INTO "users" ("id", "email", "password_hash", "role_id", "full_name") VALUES 
('99999999-9999-9999-9999-999999999999', 'test@solelab.com', '123456', '22222222-2222-2222-2222-222222222222', 'Test User'),
('00000000-0000-0000-0000-000000000001', 'admin@solelab.com', '123456', '11111111-1111-1111-1111-111111111111', 'Admin SoleLab');

-- 3. Categories & Brands
INSERT INTO "categories" ("id", "name") VALUES 
('11111111-1111-1111-1111-111111111111', 'Running'),
('22222222-2222-2222-2222-222222222222', 'Basketball'),
('33333333-3333-3333-3333-333333333333', 'Lifestyle'),
('44444444-4444-4444-4444-444444444444', 'Training');

INSERT INTO "brands" ("id", "name") VALUES 
('AAAAAAAA-AAAA-AAAA-AAAA-AAAAAAAAAAAA', 'Nike'),
('BBBBBBBB-BBBB-BBBB-BBBB-BBBBBBBBBBBB', 'Adidas'),
('CCCCCCCC-CCCC-CCCC-CCCC-CCCCCCCCCCCC', 'Puma'),
('DDDDDDDD-DDDD-DDDD-DDDD-DDDDDDDDDDDD', 'New Balance');

-- 4. Vouchers
INSERT INTO "vouchers" ("id", "code", "discount_value", "min_order_amount", "max_discount_amount", "start_date", "end_date", "quantity", "status") VALUES
('77777777-7777-7777-7777-777777777777', 'WELCOME20', 20.00, 0.00, 50000.00, '2023-01-01', '2030-12-31', 1000, 'ACTIVE'),
('88888888-8888-8888-8888-888888888888', 'MINUS50K', 50000.00, 0.00, NULL, '2023-01-01', '2030-12-31', 1000, 'ACTIVE');

-- 5. Products
INSERT INTO "products" ("id", "name", "description", "price", "category_id", "brand_id", "status") VALUES 
('10000000-0000-0000-0000-000000000001', 'Air Max Pulse', 'Giày chạy bộ nam với đệm Air Max.', 160.00, '11111111-1111-1111-1111-111111111111', 'AAAAAAAA-AAAA-AAAA-AAAA-AAAAAAAAAAAA', 'active'),
('10000000-0000-0000-0000-000000000002', 'Ultraboost Light', 'Giày chạy bộ siêu nhẹ, êm ái.', 190.00, '11111111-1111-1111-1111-111111111111', 'BBBBBBBB-BBBB-BBBB-BBBB-BBBBBBBBBBBB', 'active'),
('10000000-0000-0000-0000-000000000003', 'Puma MB.02', 'Giày bóng rổ Signature của LaMelo Ball.', 130.00, '22222222-2222-2222-2222-222222222222', 'CCCCCCCC-CCCC-CCCC-CCCC-CCCCCCCCCCCC', 'active'),
('10000000-0000-0000-0000-000000000004', 'Air Force 1 ''07', 'Mẫu giày thời trang kinh điển.', 110.00, '33333333-3333-3333-3333-333333333333', 'AAAAAAAA-AAAA-AAAA-AAAA-AAAAAAAAAAAA', 'active'),
('10000000-0000-0000-0000-000000000005', 'Dummy Product 5', 'Giày mẫu số 5.', 105.00, '11111111-1111-1111-1111-111111111111', 'AAAAAAAA-AAAA-AAAA-AAAA-AAAAAAAAAAAA', 'active'),
('10000000-0000-0000-0000-000000000006', 'Dummy Product 6', 'Giày mẫu số 6.', 106.00, '22222222-2222-2222-2222-222222222222', 'BBBBBBBB-BBBB-BBBB-BBBB-BBBBBBBBBBBB', 'active'),
('10000000-0000-0000-0000-000000000007', 'Dummy Product 7', 'Giày mẫu số 7.', 107.00, '33333333-3333-3333-3333-333333333333', 'CCCCCCCC-CCCC-CCCC-CCCC-CCCCCCCCCCCC', 'active'),
('10000000-0000-0000-0000-000000000008', 'Dummy Product 8', 'Giày mẫu số 8.', 108.00, '44444444-4444-4444-4444-444444444444', 'DDDDDDDD-DDDD-DDDD-DDDD-DDDDDDDDDDDD', 'active'),
('10000000-0000-0000-0000-000000000009', 'Dummy Product 9', 'Giày mẫu số 9.', 109.00, '11111111-1111-1111-1111-111111111111', 'AAAAAAAA-AAAA-AAAA-AAAA-AAAAAAAAAAAA', 'active'),
('10000000-0000-0000-0000-000000000010', 'Dummy Product 10', 'Giày mẫu số 10.', 110.00, '22222222-2222-2222-2222-222222222222', 'BBBBBBBB-BBBB-BBBB-BBBB-BBBBBBBBBBBB', 'active'),
('10000000-0000-0000-0000-000000000011', 'Dummy Product 11', 'Giày mẫu số 11.', 111.00, '33333333-3333-3333-3333-333333333333', 'CCCCCCCC-CCCC-CCCC-CCCC-CCCCCCCCCCCC', 'active'),
('10000000-0000-0000-0000-000000000012', 'Dummy Product 12', 'Giày mẫu số 12.', 112.00, '44444444-4444-4444-4444-444444444444', 'DDDDDDDD-DDDD-DDDD-DDDD-DDDDDDDDDDDD', 'active'),
('10000000-0000-0000-0000-000000000013', 'Dummy Product 13', 'Giày mẫu số 13.', 113.00, '11111111-1111-1111-1111-111111111111', 'AAAAAAAA-AAAA-AAAA-AAAA-AAAAAAAAAAAA', 'active'),
('10000000-0000-0000-0000-000000000014', 'Dummy Product 14', 'Giày mẫu số 14.', 114.00, '22222222-2222-2222-2222-222222222222', 'BBBBBBBB-BBBB-BBBB-BBBB-BBBBBBBBBBBB', 'active'),
('10000000-0000-0000-0000-000000000015', 'Dummy Product 15', 'Giày mẫu số 15.', 115.00, '33333333-3333-3333-3333-333333333333', 'CCCCCCCC-CCCC-CCCC-CCCC-CCCCCCCCCCCC', 'active'),
('10000000-0000-0000-0000-000000000016', 'Dummy Product 16', 'Giày mẫu số 16.', 116.00, '44444444-4444-4444-4444-444444444444', 'DDDDDDDD-DDDD-DDDD-DDDD-DDDDDDDDDDDD', 'active'),
('10000000-0000-0000-0000-000000000017', 'Dummy Product 17', 'Giày mẫu số 17.', 117.00, '11111111-1111-1111-1111-111111111111', 'AAAAAAAA-AAAA-AAAA-AAAA-AAAAAAAAAAAA', 'active'),
('10000000-0000-0000-0000-000000000018', 'Dummy Product 18', 'Giày mẫu số 18.', 118.00, '22222222-2222-2222-2222-222222222222', 'BBBBBBBB-BBBB-BBBB-BBBB-BBBBBBBBBBBB', 'active'),
('10000000-0000-0000-0000-000000000019', 'Dummy Product 19', 'Giày mẫu số 19.', 119.00, '33333333-3333-3333-3333-333333333333', 'CCCCCCCC-CCCC-CCCC-CCCC-CCCCCCCCCCCC', 'active'),
('10000000-0000-0000-0000-000000000020', 'Dummy Product 20', 'Giày mẫu số 20.', 120.00, '44444444-4444-4444-4444-444444444444', 'DDDDDDDD-DDDD-DDDD-DDDD-DDDDDDDDDDDD', 'active'),
('10000000-0000-0000-0000-000000000021', 'Dummy Product 21', 'Giày mẫu số 21.', 121.00, '11111111-1111-1111-1111-111111111111', 'AAAAAAAA-AAAA-AAAA-AAAA-AAAAAAAAAAAA', 'active'),
('10000000-0000-0000-0000-000000000022', 'Dummy Product 22', 'Giày mẫu số 22.', 122.00, '22222222-2222-2222-2222-222222222222', 'BBBBBBBB-BBBB-BBBB-BBBB-BBBBBBBBBBBB', 'active'),
('10000000-0000-0000-0000-000000000023', 'Dummy Product 23', 'Giày mẫu số 23.', 123.00, '33333333-3333-3333-3333-333333333333', 'CCCCCCCC-CCCC-CCCC-CCCC-CCCCCCCCCCCC', 'active'),
('10000000-0000-0000-0000-000000000024', 'Dummy Product 24', 'Giày mẫu số 24.', 124.00, '44444444-4444-4444-4444-444444444444', 'DDDDDDDD-DDDD-DDDD-DDDD-DDDDDDDDDDDD', 'active');

-- 6. Product Variants
INSERT INTO "product_variants" ("id", "product_id", "size", "color", "stock_quantity", "created_at") VALUES
(NEWID(), '10000000-0000-0000-0000-000000000001', '39', 'Black', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000002', '40', 'Black', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000003', '41', 'White', 30, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000004', '42', 'Red', 20, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000005', '40', 'Black', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000006', '41', 'White', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000007', '42', 'Blue', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000008', '43', 'Red', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000009', '40', 'Black', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000010', '41', 'White', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000011', '42', 'Blue', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000012', '43', 'Red', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000013', '40', 'Black', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000014', '41', 'White', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000015', '42', 'Blue', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000016', '43', 'Red', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000017', '40', 'Black', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000018', '41', 'White', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000019', '42', 'Blue', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000020', '43', 'Red', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000021', '40', 'Black', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000022', '41', 'White', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000023', '42', 'Blue', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000024', '43', 'Red', 50, SYSDATETIMEOFFSET());

-- 7. Product Images
INSERT INTO "product_images" ("id", "product_id", "image_url", "sort_order") VALUES 
(NEWID(), '10000000-0000-0000-0000-000000000001', 'https://static.nike.com/a/images/t_default/f12eb6bc-26ee-4eb3-81a1-f3b1456d2cf9/air-max-pulse-mens-shoes-2bZSZV.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000002', 'https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/c6c39e0bd58249fcab17af430113c2f0_9366/Ultraboost_Light_Running_Shoes_White_HQ6339_01_standard.jpg', 1),
(NEWID(), '10000000-0000-0000-0000-000000000003', 'https://images.puma.com/image/upload/f_auto,q_auto,b_rgb:fafafa,w_600,h_600/global/378288/01/sv01/fnd/PNA', 1),
(NEWID(), '10000000-0000-0000-0000-000000000004', 'https://static.nike.com/a/images/t_default/b398642a-db3e-43f1-8fa1-71fb589255ec/air-force-1-07-mens-shoes-jBrhbr.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000005', 'https://via.placeholder.com/600x600.png?text=Shoe+5', 1),
(NEWID(), '10000000-0000-0000-0000-000000000006', 'https://via.placeholder.com/600x600.png?text=Shoe+6', 1),
(NEWID(), '10000000-0000-0000-0000-000000000007', 'https://via.placeholder.com/600x600.png?text=Shoe+7', 1),
(NEWID(), '10000000-0000-0000-0000-000000000008', 'https://via.placeholder.com/600x600.png?text=Shoe+8', 1),
(NEWID(), '10000000-0000-0000-0000-000000000009', 'https://via.placeholder.com/600x600.png?text=Shoe+9', 1),
(NEWID(), '10000000-0000-0000-0000-000000000010', 'https://via.placeholder.com/600x600.png?text=Shoe+10', 1),
(NEWID(), '10000000-0000-0000-0000-000000000011', 'https://via.placeholder.com/600x600.png?text=Shoe+11', 1),
(NEWID(), '10000000-0000-0000-0000-000000000012', 'https://via.placeholder.com/600x600.png?text=Shoe+12', 1),
(NEWID(), '10000000-0000-0000-0000-000000000013', 'https://via.placeholder.com/600x600.png?text=Shoe+13', 1),
(NEWID(), '10000000-0000-0000-0000-000000000014', 'https://via.placeholder.com/600x600.png?text=Shoe+14', 1),
(NEWID(), '10000000-0000-0000-0000-000000000015', 'https://via.placeholder.com/600x600.png?text=Shoe+15', 1),
(NEWID(), '10000000-0000-0000-0000-000000000016', 'https://via.placeholder.com/600x600.png?text=Shoe+16', 1),
(NEWID(), '10000000-0000-0000-0000-000000000017', 'https://via.placeholder.com/600x600.png?text=Shoe+17', 1),
(NEWID(), '10000000-0000-0000-0000-000000000018', 'https://via.placeholder.com/600x600.png?text=Shoe+18', 1),
(NEWID(), '10000000-0000-0000-0000-000000000019', 'https://via.placeholder.com/600x600.png?text=Shoe+19', 1),
(NEWID(), '10000000-0000-0000-0000-000000000020', 'https://via.placeholder.com/600x600.png?text=Shoe+20', 1),
(NEWID(), '10000000-0000-0000-0000-000000000021', 'https://via.placeholder.com/600x600.png?text=Shoe+21', 1),
(NEWID(), '10000000-0000-0000-0000-000000000022', 'https://via.placeholder.com/600x600.png?text=Shoe+22', 1),
(NEWID(), '10000000-0000-0000-0000-000000000023', 'https://via.placeholder.com/600x600.png?text=Shoe+23', 1),
(NEWID(), '10000000-0000-0000-0000-000000000024', 'https://via.placeholder.com/600x600.png?text=Shoe+24', 1);

-- 8. Imports & Details
INSERT INTO "imports" ("Supplier", "UserID", "TotalAmount", "Status", "Note") VALUES
(N'Nhà phân phối Nike VN', '00000000-0000-0000-0000-000000000001', 7400.00, 'completed', N'Hàng nhập đợt 1');

DECLARE @CurrentImportID INT;
SET @CurrentImportID = SCOPE_IDENTITY();

INSERT INTO "import_details" ("ImportID", "ProductID", "ImportQuantity", "ReceivedQuantity", "UnitPrice") VALUES
(@CurrentImportID, '10000000-0000-0000-0000-000000000001', 50, 50, 100.00), 
(@CurrentImportID, '10000000-0000-0000-0000-000000000001', 30, 30, 80.00);

-- 8.2. Chèn đơn nhập hàng thứ 2 (Adidas)
INSERT INTO "imports" ("Supplier", "UserID", "TotalAmount", "Status", "Note") VALUES
(N'Tổng kho Adidas VN', '00000000-0000-0000-0000-000000000001', 3600.00, 'shipping', N'Hàng đang đi trên đường');

SET @CurrentImportID = SCOPE_IDENTITY();

INSERT INTO "import_details" ("ImportID", "ProductID", "ImportQuantity", "ReceivedQuantity", "UnitPrice") VALUES
(@CurrentImportID, '10000000-0000-0000-0000-000000000001', 30, 0, 120.00);

-- ====================================================================
-- BƯỚC 3: DỮ LIỆU MẪU CHO REVIEW VÀ ĐƠN HÀNG (Dành cho Test)
-- ====================================================================

-- 9. Khách hàng ảo (Virtual Users) và Địa chỉ (Addresses)
INSERT INTO "users" ("id", "email", "password_hash", "role_id", "full_name") VALUES 
('88888888-8888-8888-8888-888888888888', 'virtual1@solelab.com', '123456', '22222222-2222-2222-2222-222222222222', N'Nguyễn Văn Ảo'),
('77777777-7777-7777-7777-777777777777', 'virtual2@solelab.com', '123456', '22222222-2222-2222-2222-222222222222', N'Trần Thị Giả');

INSERT INTO "addresses" ("id", "user_id", "city", "district", "ward", "address_line") VALUES
('1A1A1A1A-1A1A-1A1A-1A1A-1A1A1A1A1A1A', '99999999-9999-9999-9999-999999999999', N'Hà Nội', N'Cầu Giấy', N'Dịch Vọng Hậu', N'Số 1, Tôn Thất Thuyết'),
('2A2A2A2A-2A2A-2A2A-2A2A-2A2A2A2A2A2A', '88888888-8888-8888-8888-888888888888', N'TP HCM', N'Quận 1', N'Bến Nghé', N'Đường Lê Duẩn'),
('3A3A3A3A-3A3A-3A3A-3A3A-3A3A3A3A3A3A', '77777777-7777-7777-7777-777777777777', N'Đà Nẵng', N'Hải Châu', N'Hải Châu 1', N'Đường Bạch Đằng');

-- 10. Orders & Order Items
-- Đơn hàng hoàn thành cho Test User (Mua TẤT CẢ 4 sản phẩm để test Review)
DECLARE @orderTestId UNIQUEIDENTIFIER = NEWID();
INSERT INTO "orders" ("id", "user_id", "address_id", "total_amount", "status", "payment_method", "payment_status", "created_at") VALUES
(@orderTestId, '99999999-9999-9999-9999-999999999999', '1A1A1A1A-1A1A-1A1A-1A1A-1A1A1A1A1A1A', 590.00, 'completed', 'cod', 'paid', SYSDATETIMEOFFSET());

INSERT INTO "order_items" ("id", "order_id", "product_variant_id", "quantity", "price_at_purchase", "created_at")
SELECT NEWID(), @orderTestId, id, 1, 150.00, SYSDATETIMEOFFSET() FROM "product_variants";

-- Đơn hàng hoàn thành cho Virtual User 1
DECLARE @orderVirtual1Id UNIQUEIDENTIFIER = NEWID();
INSERT INTO "orders" ("id", "user_id", "address_id", "total_amount", "status", "payment_method", "payment_status", "created_at") VALUES
(@orderVirtual1Id, '88888888-8888-8888-8888-888888888888', '2A2A2A2A-2A2A-2A2A-2A2A-2A2A2A2A2A2A', 160.00, 'completed', 'cod', 'paid', SYSDATETIMEOFFSET());

INSERT INTO "order_items" ("id", "order_id", "product_variant_id", "quantity", "price_at_purchase", "created_at")
SELECT TOP 1 NEWID(), @orderVirtual1Id, id, 1, 160.00, SYSDATETIMEOFFSET() FROM "product_variants" WHERE product_id = '10000000-0000-0000-0000-000000000001';

-- Đơn hàng hoàn thành cho Virtual User 2
DECLARE @orderVirtual2Id UNIQUEIDENTIFIER = NEWID();
INSERT INTO "orders" ("id", "user_id", "address_id", "total_amount", "status", "payment_method", "payment_status", "created_at") VALUES
(@orderVirtual2Id, '77777777-7777-7777-7777-777777777777', '3A3A3A3A-3A3A-3A3A-3A3A-3A3A3A3A3A3A', 190.00, 'completed', 'cod', 'paid', SYSDATETIMEOFFSET());

INSERT INTO "order_items" ("id", "order_id", "product_variant_id", "quantity", "price_at_purchase", "created_at")
SELECT TOP 1 NEWID(), @orderVirtual2Id, id, 1, 190.00, SYSDATETIMEOFFSET() FROM "product_variants" WHERE product_id = '10000000-0000-0000-0000-000000000002';

-- Đơn hàng Pending cho Test User
DECLARE @orderPending1Id UNIQUEIDENTIFIER = NEWID();
INSERT INTO "orders" ("id", "user_id", "address_id", "total_amount", "status", "payment_method", "payment_status", "created_at") VALUES
(@orderPending1Id, '99999999-9999-9999-9999-999999999999', '1A1A1A1A-1A1A-1A1A-1A1A-1A1A1A1A1A1A', 350.00, 'pending', 'cod', 'pending', SYSDATETIMEOFFSET());

INSERT INTO "order_items" ("id", "order_id", "product_variant_id", "quantity", "price_at_purchase", "created_at")
SELECT TOP 1 NEWID(), @orderPending1Id, id, 2, 175.00, SYSDATETIMEOFFSET() FROM "product_variants" WHERE product_id = '10000000-0000-0000-0000-000000000001';

-- Đơn hàng Pending cho Virtual User 1
DECLARE @orderPending2Id UNIQUEIDENTIFIER = NEWID();
INSERT INTO "orders" ("id", "user_id", "address_id", "total_amount", "status", "payment_method", "payment_status", "created_at") VALUES
(@orderPending2Id, '88888888-8888-8888-8888-888888888888', '2A2A2A2A-2A2A-2A2A-2A2A-2A2A2A2A2A2A', 220.00, 'pending', 'cod', 'pending', SYSDATETIMEOFFSET());

INSERT INTO "order_items" ("id", "order_id", "product_variant_id", "quantity", "price_at_purchase", "created_at")
SELECT TOP 1 NEWID(), @orderPending2Id, id, 2, 110.00, SYSDATETIMEOFFSET() FROM "product_variants" WHERE product_id = '10000000-0000-0000-0000-000000000004';

-- 11. Đánh giá ngẫu nhiên (Dummy Reviews)
INSERT INTO "reviews" ("id", "user_id", "product_id", "rating", "comment", "created_at") VALUES
(NEWID(), '88888888-8888-8888-8888-888888888888', '10000000-0000-0000-0000-000000000001', 5, N'Giày rất đẹp, chạy rất êm chân! Điểm 10 cho chất lượng.', SYSDATETIMEOFFSET()),
(NEWID(), '77777777-7777-7777-7777-777777777777', '10000000-0000-0000-0000-000000000002', 4, N'Giao hàng nhanh, form giày hơi ôm nên mua tăng 1 size.', SYSDATETIMEOFFSET());

PRINT 'Thêm dữ liệu mẫu hoàn tất!';
