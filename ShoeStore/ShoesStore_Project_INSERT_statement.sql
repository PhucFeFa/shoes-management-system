-- BƯỚC 1: XÓA DỮ LIỆU CŨ (Thứ tự: Bảng con trước, bảng cha sau)
-- ====================================================================
DELETE FROM "order_items";
DELETE FROM "order_staff_logs";
DELETE FROM "orders";
DELETE FROM "import_details";
DELETE FROM "imports";
DELETE FROM "carts";
DELETE FROM "reviews";
DELETE FROM "addresses";
DELETE FROM "product_images";
DELETE FROM "product_variants";
DELETE FROM "products";
DELETE FROM "vouchers";
DELETE FROM "users";
DELETE FROM "staffs";
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

-- 2. Staffs
INSERT INTO "staffs" ("id", "email", "password_hash", "full_name") VALUES 
('EEEEEEEE-EEEE-EEEE-EEEE-EEEEEEEEEEEE', 'staff@solelab.com', '123456', 'Staff SoleLab');

-- 3. Users
INSERT INTO "users" ("id", "email", "password_hash", "role_id", "full_name") VALUES 
('99999999-9999-9999-9999-999999999999', 'test@solelab.com', '123456', '22222222-2222-2222-2222-222222222222', 'Test User'),
('00000000-0000-0000-0000-000000000001', 'admin@solelab.com', '123456', '11111111-1111-1111-1111-111111111111', 'Admin SoleLab');

-- 4. Categories & Brands
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

-- 5. Vouchers
INSERT INTO "vouchers" ("id", "code", "discount_value", "min_order_amount", "max_discount_amount", "start_date", "end_date", "quantity", "status") VALUES
('77777777-7777-7777-7777-777777777777', 'WELCOME20', 20.00, 0.00, 50000.00, '2023-01-01', '2030-12-31', 1000, 'ACTIVE'),
('88888888-8888-8888-8888-888888888888', 'MINUS50K', 50000.00, 0.00, NULL, '2023-01-01', '2030-12-31', 1000, 'ACTIVE');

-- 6. Products
INSERT INTO "products" ("id", "name", "description", "price", "category_id", "brand_id", "status") VALUES 
('10000000-0000-0000-0000-000000000001', 'Air Max Pulse', 'Men''s running shoes with Air Max cushioning.', 160, '22222222-2222-2222-2222-222222222222', 'BBBBBBBB-BBBB-BBBB-BBBB-BBBBBBBBBBBB', 'active'),
('10000000-0000-0000-0000-000000000002', 'Ultraboost Light', 'Lightweight and comfortable running shoes.', 190, '33333333-3333-3333-3333-333333333333', 'CCCCCCCC-CCCC-CCCC-CCCC-CCCCCCCCCCCC', 'active'),
('10000000-0000-0000-0000-000000000003', 'Puma MB.02', 'LaMelo Ball signature basketball shoes.', 130, '44444444-4444-4444-4444-444444444444', 'DDDDDDDD-DDDD-DDDD-DDDD-DDDDDDDDDDDD', 'active'),
('10000000-0000-0000-0000-000000000004', 'Air Force 1 ''07', 'Classic lifestyle fashion shoes.', 110, '11111111-1111-1111-1111-111111111111', 'AAAAAAAA-AAAA-AAAA-AAAA-AAAAAAAAAAAA', 'active'),
('10000000-0000-0000-0000-000000000005', 'Dummy Product 5', 'High quality sports and lifestyle shoes model 5.', 105, '22222222-2222-2222-2222-222222222222', 'BBBBBBBB-BBBB-BBBB-BBBB-BBBBBBBBBBBB', 'active'),
('10000000-0000-0000-0000-000000000006', 'Dummy Product 6', 'High quality sports and lifestyle shoes model 6.', 106, '33333333-3333-3333-3333-333333333333', 'CCCCCCCC-CCCC-CCCC-CCCC-CCCCCCCCCCCC', 'active'),
('10000000-0000-0000-0000-000000000007', 'Dummy Product 7', 'High quality sports and lifestyle shoes model 7.', 107, '44444444-4444-4444-4444-444444444444', 'DDDDDDDD-DDDD-DDDD-DDDD-DDDDDDDDDDDD', 'active'),
('10000000-0000-0000-0000-000000000008', 'Dummy Product 8', 'High quality sports and lifestyle shoes model 8.', 108, '11111111-1111-1111-1111-111111111111', 'AAAAAAAA-AAAA-AAAA-AAAA-AAAAAAAAAAAA', 'active'),
('10000000-0000-0000-0000-000000000009', 'Dummy Product 9', 'High quality sports and lifestyle shoes model 9.', 109, '22222222-2222-2222-2222-222222222222', 'BBBBBBBB-BBBB-BBBB-BBBB-BBBBBBBBBBBB', 'active'),
('10000000-0000-0000-0000-000000000010', 'Dummy Product 10', 'High quality sports and lifestyle shoes model 10.', 110, '33333333-3333-3333-3333-333333333333', 'CCCCCCCC-CCCC-CCCC-CCCC-CCCCCCCCCCCC', 'active'),
('10000000-0000-0000-0000-000000000011', 'Dummy Product 11', 'High quality sports and lifestyle shoes model 11.', 111, '44444444-4444-4444-4444-444444444444', 'DDDDDDDD-DDDD-DDDD-DDDD-DDDDDDDDDDDD', 'active'),
('10000000-0000-0000-0000-000000000012', 'Dummy Product 12', 'High quality sports and lifestyle shoes model 12.', 112, '11111111-1111-1111-1111-111111111111', 'AAAAAAAA-AAAA-AAAA-AAAA-AAAAAAAAAAAA', 'active'),
('10000000-0000-0000-0000-000000000013', 'Dummy Product 13', 'High quality sports and lifestyle shoes model 13.', 113, '22222222-2222-2222-2222-222222222222', 'BBBBBBBB-BBBB-BBBB-BBBB-BBBBBBBBBBBB', 'active'),
('10000000-0000-0000-0000-000000000014', 'Dummy Product 14', 'High quality sports and lifestyle shoes model 14.', 114, '33333333-3333-3333-3333-333333333333', 'CCCCCCCC-CCCC-CCCC-CCCC-CCCCCCCCCCCC', 'active'),
('10000000-0000-0000-0000-000000000015', 'Dummy Product 15', 'High quality sports and lifestyle shoes model 15.', 115, '44444444-4444-4444-4444-444444444444', 'DDDDDDDD-DDDD-DDDD-DDDD-DDDDDDDDDDDD', 'active'),
('10000000-0000-0000-0000-000000000016', 'Dummy Product 16', 'High quality sports and lifestyle shoes model 16.', 116, '11111111-1111-1111-1111-111111111111', 'AAAAAAAA-AAAA-AAAA-AAAA-AAAAAAAAAAAA', 'active'),
('10000000-0000-0000-0000-000000000017', 'Dummy Product 17', 'High quality sports and lifestyle shoes model 17.', 117, '22222222-2222-2222-2222-222222222222', 'BBBBBBBB-BBBB-BBBB-BBBB-BBBBBBBBBBBB', 'active'),
('10000000-0000-0000-0000-000000000018', 'Dummy Product 18', 'High quality sports and lifestyle shoes model 18.', 118, '33333333-3333-3333-3333-333333333333', 'CCCCCCCC-CCCC-CCCC-CCCC-CCCCCCCCCCCC', 'active'),
('10000000-0000-0000-0000-000000000019', 'Dummy Product 19', 'High quality sports and lifestyle shoes model 19.', 119, '44444444-4444-4444-4444-444444444444', 'DDDDDDDD-DDDD-DDDD-DDDD-DDDDDDDDDDDD', 'active'),
('10000000-0000-0000-0000-000000000020', 'Dummy Product 20', 'High quality sports and lifestyle shoes model 20.', 120, '11111111-1111-1111-1111-111111111111', 'AAAAAAAA-AAAA-AAAA-AAAA-AAAAAAAAAAAA', 'active'),
('10000000-0000-0000-0000-000000000021', 'Dummy Product 21', 'High quality sports and lifestyle shoes model 21.', 121, '22222222-2222-2222-2222-222222222222', 'BBBBBBBB-BBBB-BBBB-BBBB-BBBBBBBBBBBB', 'active'),
('10000000-0000-0000-0000-000000000022', 'Dummy Product 22', 'High quality sports and lifestyle shoes model 22.', 122, '33333333-3333-3333-3333-333333333333', 'CCCCCCCC-CCCC-CCCC-CCCC-CCCCCCCCCCCC', 'active'),
('10000000-0000-0000-0000-000000000023', 'Dummy Product 23', 'High quality sports and lifestyle shoes model 23.', 123, '44444444-4444-4444-4444-444444444444', 'DDDDDDDD-DDDD-DDDD-DDDD-DDDDDDDDDDDD', 'active'),
('10000000-0000-0000-0000-000000000024', 'Dummy Product 24', 'High quality sports and lifestyle shoes model 24.', 124, '11111111-1111-1111-1111-111111111111', 'AAAAAAAA-AAAA-AAAA-AAAA-AAAAAAAAAAAA', 'active'),
('10000000-0000-0000-0000-000000000025', 'Dummy Product 25', 'High quality sports and lifestyle shoes model 25.', 125, '22222222-2222-2222-2222-222222222222', 'BBBBBBBB-BBBB-BBBB-BBBB-BBBBBBBBBBBB', 'active'),
('10000000-0000-0000-0000-000000000026', 'Dummy Product 26', 'High quality sports and lifestyle shoes model 26.', 126, '33333333-3333-3333-3333-333333333333', 'CCCCCCCC-CCCC-CCCC-CCCC-CCCCCCCCCCCC', 'active'),
('10000000-0000-0000-0000-000000000027', 'Dummy Product 27', 'High quality sports and lifestyle shoes model 27.', 127, '44444444-4444-4444-4444-444444444444', 'DDDDDDDD-DDDD-DDDD-DDDD-DDDDDDDDDDDD', 'active'),
('10000000-0000-0000-0000-000000000028', 'Dummy Product 28', 'High quality sports and lifestyle shoes model 28.', 128, '11111111-1111-1111-1111-111111111111', 'AAAAAAAA-AAAA-AAAA-AAAA-AAAAAAAAAAAA', 'active'),
('10000000-0000-0000-0000-000000000029', 'Dummy Product 29', 'High quality sports and lifestyle shoes model 29.', 129, '22222222-2222-2222-2222-222222222222', 'BBBBBBBB-BBBB-BBBB-BBBB-BBBBBBBBBBBB', 'active'),
('10000000-0000-0000-0000-000000000030', 'Dummy Product 30', 'High quality sports and lifestyle shoes model 30.', 130, '33333333-3333-3333-3333-333333333333', 'CCCCCCCC-CCCC-CCCC-CCCC-CCCCCCCCCCCC', 'active'),
('10000000-0000-0000-0000-000000000031', 'Dummy Product 31', 'High quality sports and lifestyle shoes model 31.', 131, '44444444-4444-4444-4444-444444444444', 'DDDDDDDD-DDDD-DDDD-DDDD-DDDDDDDDDDDD', 'active'),
('10000000-0000-0000-0000-000000000032', 'Dummy Product 32', 'High quality sports and lifestyle shoes model 32.', 132, '11111111-1111-1111-1111-111111111111', 'AAAAAAAA-AAAA-AAAA-AAAA-AAAAAAAAAAAA', 'active'),
('10000000-0000-0000-0000-000000000033', 'Dummy Product 33', 'High quality sports and lifestyle shoes model 33.', 133, '22222222-2222-2222-2222-222222222222', 'BBBBBBBB-BBBB-BBBB-BBBB-BBBBBBBBBBBB', 'active'),
('10000000-0000-0000-0000-000000000034', 'Dummy Product 34', 'High quality sports and lifestyle shoes model 34.', 134, '33333333-3333-3333-3333-333333333333', 'CCCCCCCC-CCCC-CCCC-CCCC-CCCCCCCCCCCC', 'active'),
('10000000-0000-0000-0000-000000000035', 'Dummy Product 35', 'High quality sports and lifestyle shoes model 35.', 135, '44444444-4444-4444-4444-444444444444', 'DDDDDDDD-DDDD-DDDD-DDDD-DDDDDDDDDDDD', 'active'),
('10000000-0000-0000-0000-000000000036', 'Dummy Product 36', 'High quality sports and lifestyle shoes model 36.', 136, '11111111-1111-1111-1111-111111111111', 'AAAAAAAA-AAAA-AAAA-AAAA-AAAAAAAAAAAA', 'active'),
('10000000-0000-0000-0000-000000000037', 'Dummy Product 37', 'High quality sports and lifestyle shoes model 37.', 137, '22222222-2222-2222-2222-222222222222', 'BBBBBBBB-BBBB-BBBB-BBBB-BBBBBBBBBBBB', 'active'),
('10000000-0000-0000-0000-000000000038', 'Dummy Product 38', 'High quality sports and lifestyle shoes model 38.', 138, '33333333-3333-3333-3333-333333333333', 'CCCCCCCC-CCCC-CCCC-CCCC-CCCCCCCCCCCC', 'active'),
('10000000-0000-0000-0000-000000000039', 'Dummy Product 39', 'High quality sports and lifestyle shoes model 39.', 139, '44444444-4444-4444-4444-444444444444', 'DDDDDDDD-DDDD-DDDD-DDDD-DDDDDDDDDDDD', 'active'),
('10000000-0000-0000-0000-000000000040', 'Dummy Product 40', 'High quality sports and lifestyle shoes model 40.', 140, '11111111-1111-1111-1111-111111111111', 'AAAAAAAA-AAAA-AAAA-AAAA-AAAAAAAAAAAA', 'active'),
('10000000-0000-0000-0000-000000000041', 'Dummy Product 41', 'High quality sports and lifestyle shoes model 41.', 141, '22222222-2222-2222-2222-222222222222', 'BBBBBBBB-BBBB-BBBB-BBBB-BBBBBBBBBBBB', 'active'),
('10000000-0000-0000-0000-000000000042', 'Dummy Product 42', 'High quality sports and lifestyle shoes model 42.', 142, '33333333-3333-3333-3333-333333333333', 'CCCCCCCC-CCCC-CCCC-CCCC-CCCCCCCCCCCC', 'active'),
('10000000-0000-0000-0000-000000000043', 'Dummy Product 43', 'High quality sports and lifestyle shoes model 43.', 143, '44444444-4444-4444-4444-444444444444', 'DDDDDDDD-DDDD-DDDD-DDDD-DDDDDDDDDDDD', 'active'),
('10000000-0000-0000-0000-000000000044', 'Dummy Product 44', 'High quality sports and lifestyle shoes model 44.', 144, '11111111-1111-1111-1111-111111111111', 'AAAAAAAA-AAAA-AAAA-AAAA-AAAAAAAAAAAA', 'active'),
('10000000-0000-0000-0000-000000000045', 'Dummy Product 45', 'High quality sports and lifestyle shoes model 45.', 145, '22222222-2222-2222-2222-222222222222', 'BBBBBBBB-BBBB-BBBB-BBBB-BBBBBBBBBBBB', 'active'),
('10000000-0000-0000-0000-000000000046', 'Dummy Product 46', 'High quality sports and lifestyle shoes model 46.', 146, '33333333-3333-3333-3333-333333333333', 'CCCCCCCC-CCCC-CCCC-CCCC-CCCCCCCCCCCC', 'active'),
('10000000-0000-0000-0000-000000000047', 'Dummy Product 47', 'High quality sports and lifestyle shoes model 47.', 147, '44444444-4444-4444-4444-444444444444', 'DDDDDDDD-DDDD-DDDD-DDDD-DDDDDDDDDDDD', 'active'),
('10000000-0000-0000-0000-000000000048', 'Dummy Product 48', 'High quality sports and lifestyle shoes model 48.', 148, '11111111-1111-1111-1111-111111111111', 'AAAAAAAA-AAAA-AAAA-AAAA-AAAAAAAAAAAA', 'active'),
('10000000-0000-0000-0000-000000000049', 'Dummy Product 49', 'High quality sports and lifestyle shoes model 49.', 149, '22222222-2222-2222-2222-222222222222', 'BBBBBBBB-BBBB-BBBB-BBBB-BBBBBBBBBBBB', 'active'),
('10000000-0000-0000-0000-000000000050', 'Dummy Product 50', 'High quality sports and lifestyle shoes model 50.', 150, '33333333-3333-3333-3333-333333333333', 'CCCCCCCC-CCCC-CCCC-CCCC-CCCCCCCCCCCC', 'active'),
('10000000-0000-0000-0000-000000000051', 'Dummy Product 51', 'High quality sports and lifestyle shoes model 51.', 151, '44444444-4444-4444-4444-444444444444', 'DDDDDDDD-DDDD-DDDD-DDDD-DDDDDDDDDDDD', 'active'),
('10000000-0000-0000-0000-000000000052', 'Dummy Product 52', 'High quality sports and lifestyle shoes model 52.', 152, '11111111-1111-1111-1111-111111111111', 'AAAAAAAA-AAAA-AAAA-AAAA-AAAAAAAAAAAA', 'active'),
('10000000-0000-0000-0000-000000000053', 'Dummy Product 53', 'High quality sports and lifestyle shoes model 53.', 153, '22222222-2222-2222-2222-222222222222', 'BBBBBBBB-BBBB-BBBB-BBBB-BBBBBBBBBBBB', 'active'),
('10000000-0000-0000-0000-000000000054', 'Dummy Product 54', 'High quality sports and lifestyle shoes model 54.', 154, '33333333-3333-3333-3333-333333333333', 'CCCCCCCC-CCCC-CCCC-CCCC-CCCCCCCCCCCC', 'active'),
('10000000-0000-0000-0000-000000000055', 'Dummy Product 55', 'High quality sports and lifestyle shoes model 55.', 155, '44444444-4444-4444-4444-444444444444', 'DDDDDDDD-DDDD-DDDD-DDDD-DDDDDDDDDDDD', 'active'),
('10000000-0000-0000-0000-000000000056', 'Dummy Product 56', 'High quality sports and lifestyle shoes model 56.', 156, '11111111-1111-1111-1111-111111111111', 'AAAAAAAA-AAAA-AAAA-AAAA-AAAAAAAAAAAA', 'active'),
('10000000-0000-0000-0000-000000000057', 'Dummy Product 57', 'High quality sports and lifestyle shoes model 57.', 157, '22222222-2222-2222-2222-222222222222', 'BBBBBBBB-BBBB-BBBB-BBBB-BBBBBBBBBBBB', 'active'),
('10000000-0000-0000-0000-000000000058', 'Dummy Product 58', 'High quality sports and lifestyle shoes model 58.', 158, '33333333-3333-3333-3333-333333333333', 'CCCCCCCC-CCCC-CCCC-CCCC-CCCCCCCCCCCC', 'active'),
('10000000-0000-0000-0000-000000000059', 'Dummy Product 59', 'High quality sports and lifestyle shoes model 59.', 159, '44444444-4444-4444-4444-444444444444', 'DDDDDDDD-DDDD-DDDD-DDDD-DDDDDDDDDDDD', 'active'),
('10000000-0000-0000-0000-000000000060', 'Dummy Product 60', 'High quality sports and lifestyle shoes model 60.', 160, '11111111-1111-1111-1111-111111111111', 'AAAAAAAA-AAAA-AAAA-AAAA-AAAAAAAAAAAA', 'active');

-- 7. Product Variants
INSERT INTO "product_variants" ("id", "product_id", "size", "color", "stock_quantity", "created_at") VALUES
(NEWID(), '10000000-0000-0000-0000-000000000001', '40', 'Black', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000002', '41', 'White', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000003', '42', 'Black', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000004', '43', 'White', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000005', '39', 'Black', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000006', '40', 'White', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000007', '41', 'Black', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000008', '42', 'White', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000009', '43', 'Black', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000010', '39', 'White', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000011', '40', 'Black', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000012', '41', 'White', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000013', '42', 'Black', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000014', '43', 'White', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000015', '39', 'Black', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000016', '40', 'White', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000017', '41', 'Black', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000018', '42', 'White', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000019', '43', 'Black', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000020', '39', 'White', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000021', '40', 'Black', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000022', '41', 'White', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000023', '42', 'Black', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000024', '43', 'White', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000025', '39', 'Black', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000026', '40', 'White', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000027', '41', 'Black', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000028', '42', 'White', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000029', '43', 'Black', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000030', '39', 'White', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000031', '40', 'Black', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000032', '41', 'White', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000033', '42', 'Black', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000034', '43', 'White', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000035', '39', 'Black', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000036', '40', 'White', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000037', '41', 'Black', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000038', '42', 'White', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000039', '43', 'Black', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000040', '39', 'White', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000041', '40', 'Black', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000042', '41', 'White', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000043', '42', 'Black', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000044', '43', 'White', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000045', '39', 'Black', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000046', '40', 'White', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000047', '41', 'Black', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000048', '42', 'White', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000049', '43', 'Black', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000050', '39', 'White', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000051', '40', 'Black', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000052', '41', 'White', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000053', '42', 'Black', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000054', '43', 'White', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000055', '39', 'Black', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000056', '40', 'White', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000057', '41', 'Black', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000058', '42', 'White', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000059', '43', 'Black', 50, SYSDATETIMEOFFSET()),
(NEWID(), '10000000-0000-0000-0000-000000000060', '39', 'White', 50, SYSDATETIMEOFFSET());

-- 8. Product Images
INSERT INTO "product_images" ("id", "product_id", "image_url", "sort_order") VALUES 
(NEWID(), '10000000-0000-0000-0000-000000000001', 'assets/fallback.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000002', 'assets/fallback.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000003', 'assets/fallback.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000004', 'assets/fallback.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000005', 'assets/fallback.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000006', 'assets/fallback.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000007', 'assets/fallback.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000008', 'assets/fallback.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000009', 'assets/fallback.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000010', 'assets/fallback.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000011', 'assets/fallback.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000012', 'assets/fallback.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000013', 'assets/fallback.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000014', 'assets/fallback.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000015', 'assets/fallback.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000016', 'assets/fallback.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000017', 'assets/fallback.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000018', 'assets/fallback.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000019', 'assets/fallback.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000020', 'assets/fallback.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000021', 'assets/fallback.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000022', 'assets/fallback.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000023', 'assets/fallback.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000024', 'assets/fallback.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000025', 'assets/fallback.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000026', 'assets/fallback.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000027', 'assets/fallback.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000028', 'assets/fallback.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000029', 'assets/fallback.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000030', 'assets/fallback.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000031', 'assets/fallback.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000032', 'assets/fallback.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000033', 'assets/fallback.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000034', 'assets/fallback.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000035', 'assets/fallback.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000036', 'assets/fallback.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000037', 'assets/fallback.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000038', 'assets/fallback.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000039', 'assets/fallback.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000040', 'assets/fallback.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000041', 'assets/fallback.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000042', 'assets/fallback.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000043', 'assets/fallback.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000044', 'assets/fallback.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000045', 'assets/fallback.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000046', 'assets/fallback.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000047', 'assets/fallback.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000048', 'assets/fallback.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000049', 'assets/fallback.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000050', 'assets/fallback.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000051', 'assets/fallback.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000052', 'assets/fallback.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000053', 'assets/fallback.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000054', 'assets/fallback.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000055', 'assets/fallback.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000056', 'assets/fallback.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000057', 'assets/fallback.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000058', 'assets/fallback.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000059', 'assets/fallback.png', 1),
(NEWID(), '10000000-0000-0000-0000-000000000060', 'assets/fallback.png', 1);

-- 9. Imports & Details
INSERT INTO "imports" ("Supplier", "StaffID", "TotalAmount", "Status", "Note") VALUES
(N'Nhà phân phối Nike VN', 'EEEEEEEE-EEEE-EEEE-EEEE-EEEEEEEEEEEE', 7400.00, 'completed', N'Hàng nhập đợt 1');

DECLARE @CurrentImportID INT;
SET @CurrentImportID = SCOPE_IDENTITY();

INSERT INTO "import_details" ("ImportID", "VariantID", "ImportQuantity", "ReceivedQuantity", "UnitPrice") 
SELECT TOP 1 @CurrentImportID, id, 50, 50, 100.00 FROM "product_variants" WHERE product_id = '10000000-0000-0000-0000-000000000001' AND size = '39';

INSERT INTO "import_details" ("ImportID", "VariantID", "ImportQuantity", "ReceivedQuantity", "UnitPrice") 
SELECT TOP 1 @CurrentImportID, id, 30, 30, 80.00 FROM "product_variants" WHERE product_id = '10000000-0000-0000-0000-000000000001' AND size = '40' AND color = 'White';

-- 9.2. Chèn đơn nhập hàng thứ 2 (Adidas)
INSERT INTO "imports" ("Supplier", "StaffID", "TotalAmount", "Status", "Note") VALUES
(N'Tổng kho Adidas VN', 'EEEEEEEE-EEEE-EEEE-EEEE-EEEEEEEEEEEE', 3600.00, 'shipping', N'Hàng đang đi trên đường');

SET @CurrentImportID = SCOPE_IDENTITY();

INSERT INTO "import_details" ("ImportID", "VariantID", "ImportQuantity", "ReceivedQuantity", "UnitPrice") 
SELECT TOP 1 @CurrentImportID, id, 30, 0, 120.00 FROM "product_variants" WHERE product_id = '10000000-0000-0000-0000-000000000001';

-- ====================================================================
-- BƯỚC 3: DỮ LIỆU MẪU CHO REVIEW VÀ ĐƠN HÀNG (Dành cho Test)
-- ====================================================================

-- 10. Khách hàng ảo (Virtual Users) và Địa chỉ (Addresses)
INSERT INTO "users" ("id", "email", "password_hash", "role_id", "full_name") VALUES 
('88888888-8888-8888-8888-888888888888', 'virtual1@solelab.com', '123456', '22222222-2222-2222-2222-222222222222', N'Nguyễn Văn Ảo'),
('77777777-7777-7777-7777-777777777777', 'virtual2@solelab.com', '123456', '22222222-2222-2222-2222-222222222222', N'Trần Thị Giả');

INSERT INTO "addresses" ("id", "user_id", "city", "district", "ward", "address_line") VALUES
('1A1A1A1A-1A1A-1A1A-1A1A-1A1A1A1A1A1A', '99999999-9999-9999-9999-999999999999', N'Hà Nội', N'Cầu Giấy', N'Dịch Vọng Hậu', N'Số 1, Tôn Thất Thuyết'),
('2A2A2A2A-2A2A-2A2A-2A2A-2A2A2A2A2A2A', '88888888-8888-8888-8888-888888888888', N'TP HCM', N'Quận 1', N'Bến Nghé', N'Đường Lê Duẩn'),
('3A3A3A3A-3A3A-3A3A-3A3A-3A3A3A3A3A3A', '77777777-7777-7777-7777-777777777777', N'Đà Nẵng', N'Hải Châu', N'Hải Châu 1', N'Đường Bạch Đằng');

-- 11. Orders & Order Items
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

-- 12. Đánh giá ngẫu nhiên (Dummy Reviews)
INSERT INTO "reviews" ("id", "user_id", "product_id", "rating", "comment", "created_at") VALUES
(NEWID(), '88888888-8888-8888-8888-888888888888', '10000000-0000-0000-0000-000000000001', 5, N'Giày rất đẹp, chạy rất êm chân! Điểm 10 cho chất lượng.', SYSDATETIMEOFFSET()),
(NEWID(), '77777777-7777-7777-7777-777777777777', '10000000-0000-0000-0000-000000000002', 4, N'Giao hàng nhanh, form giày hơi ôm nên mua tăng 1 size.', SYSDATETIMEOFFSET());

PRINT 'Thêm dữ liệu mẫu hoàn tất!';
