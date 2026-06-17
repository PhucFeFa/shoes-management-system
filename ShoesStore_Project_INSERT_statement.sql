-- ====================================================================
-- BƯỚC 1: XÓA DỮ LIỆU CŨ (Thứ tự: Bảng con trước, bảng cha sau)
-- ====================================================================
DELETE FROM "payments";
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
INSERT INTO "vouchers" ("id", "code", "discount_percent", "max_discount_amount", "start_date", "end_date", "quantity") VALUES
('77777777-7777-7777-7777-777777777777', 'WELCOME20', 20.00, 50.00, '2023-01-01', '2030-12-31', 1000);

-- 5. Products
INSERT INTO "products" ("id", "name", "description", "price", "category_id", "brand_id", "status") VALUES 
('10000000-0000-0000-0000-000000000001', 'Air Max Pulse', 'Giày chạy bộ nam với đệm Air Max.', 160.00, '11111111-1111-1111-1111-111111111111', 'AAAAAAAA-AAAA-AAAA-AAAA-AAAAAAAAAAAA', 'active'),
('10000000-0000-0000-0000-000000000002', 'Ultraboost Light', 'Giày chạy bộ siêu nhẹ, êm ái.', 190.00, '11111111-1111-1111-1111-111111111111', 'BBBBBBBB-BBBB-BBBB-BBBB-BBBBBBBBBBBB', 'active'),
('10000000-0000-0000-0000-000000000003', 'Puma MB.02', 'Giày bóng rổ Signature của LaMelo Ball.', 130.00, '22222222-2222-2222-2222-222222222222', 'CCCCCCCC-CCCC-CCCC-CCCC-CCCCCCCCCCCC', 'active'),
('10000000-0000-0000-0000-000000000004', 'Air Force 1 ''07', 'Mẫu giày thời trang kinh điển.', 110.00, '33333333-3333-3333-3333-333333333333', 'AAAAAAAA-AAAA-AAAA-AAAA-AAAAAAAAAAAA', 'active');

-- 6. Product Variants
INSERT INTO "product_variants" ("id", "product_id", "size", "color", "stock_quantity", "created_at") VALUES
(NEWID(), '10000000-0000-0000-0000-000000000001', '39', 'Black', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000002', '40', 'Black', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000003', '41', 'White', 30, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000004', '42', 'Red', 20, SYSDATETIMEOFFSET());

-- 7. Product Images
INSERT INTO "product_images" ("id", "product_id", "image_url", "sort_order") VALUES 
(NEWID(), '10000000-0000-0000-0000-000000000001', 'https://static.nike.com/a/images/t_default/f12eb6bc-26ee-4eb3-81a1-f3b1456d2cf9/air-max-pulse-mens-shoes-2bZSZV.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000002', 'https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/c6c39e0bd58249fcab17af430113c2f0_9366/Ultraboost_Light_Running_Shoes_White_HQ6339_01_standard.jpg', 1),
(NEWID(), '10000000-0000-0000-0000-000000000003', 'https://images.puma.com/image/upload/f_auto,q_auto,b_rgb:fafafa,w_600,h_600/global/378288/01/sv01/fnd/PNA', 1),
(NEWID(), '10000000-0000-0000-0000-000000000004', 'https://static.nike.com/a/images/t_default/b398642a-db3e-43f1-8fa1-71fb589255ec/air-force-1-07-mens-shoes-jBrhbr.png', 1);

-- 8. Imports & Details
INSERT INTO "imports" ("Supplier", "UserID", "TotalAmount", "Status", "Note") VALUES
(N'Nhà phân phối Nike VN', '00000000-0000-0000-0000-000000000001', 7400.00, 'completed', N'Hàng nhập đợt 1'), 
(N'Tổng kho Adidas VN', '00000000-0000-0000-0000-000000000001', 3600.00, 'shipping', N'Hàng đang đi trên đường');

INSERT INTO "import_details" ("ImportID", "ProductID", "ImportQuantity", "ReceivedQuantity", "UnitPrice") VALUES
(1, '10000000-0000-0000-0000-000000000001', 50, 50, 100.00), 
(1, '10000000-0000-0000-0000-000000000001', 30, 30, 80.00),  
(2, '10000000-0000-0000-0000-000000000001', 30, 0, 120.00);

PRINT 'Thêm dữ liệu mẫu hoàn tất!';