-- Xóa dữ liệu cũ (nếu có) để tránh lỗi trùng lặp khi chạy lại nhiều lần
DELETE FROM "product_images";
DELETE FROM "products";
DELETE FROM "categories";
DELETE FROM "brands";

-- Chèn Danh mục (Categories)
INSERT INTO "categories" ("id", "name") VALUES 
('11111111-1111-1111-1111-111111111111', 'Running'),
('22222222-2222-2222-2222-222222222222', 'Basketball'),
('33333333-3333-3333-3333-333333333333', 'Lifestyle'),
('44444444-4444-4444-4444-444444444444', 'Training');

-- Chèn Thương hiệu (Brands)
INSERT INTO "brands" ("id", "name") VALUES 
('AAAAAAAA-AAAA-AAAA-AAAA-AAAAAAAAAAAA', 'Nike'),
('BBBBBBBB-BBBB-BBBB-BBBB-BBBBBBBBBBBB', 'Adidas'),
('CCCCCCCC-CCCC-CCCC-CCCC-CCCCCCCCCCCC', 'Puma'),
('DDDDDDDD-DDDD-DDDD-DDDD-DDDDDDDDDDDD', 'New Balance');

-- Chèn Sản phẩm (Products)
INSERT INTO "products" ("id", "name", "description", "price", "category_id", "brand_id", "status") VALUES 
('10000000-0000-0000-0000-000000000001', 'Air Max Pulse', 'Giày chạy bộ nam với đệm Air Max.', 160.00, '11111111-1111-1111-1111-111111111111', 'AAAAAAAA-AAAA-AAAA-AAAA-AAAAAAAAAAAA', 'active'),
('10000000-0000-0000-0000-000000000002', 'Ultraboost Light', 'Giày chạy bộ siêu nhẹ, êm ái.', 190.00, '11111111-1111-1111-1111-111111111111', 'BBBBBBBB-BBBB-BBBB-BBBB-BBBBBBBBBBBB', 'active'),
('10000000-0000-0000-0000-000000000003', 'Puma MB.02', 'Giày bóng rổ Signature của LaMelo Ball.', 130.00, '22222222-2222-2222-2222-222222222222', 'CCCCCCCC-CCCC-CCCC-CCCC-CCCCCCCCCCCC', 'active'),
('10000000-0000-0000-0000-000000000004', 'Air Force 1 ''07', 'Mẫu giày thời trang kinh điển.', 110.00, '33333333-3333-3333-3333-333333333333', 'AAAAAAAA-AAAA-AAAA-AAAA-AAAAAAAAAAAA', 'active');

-- Chèn Hình ảnh Sản phẩm (Product Images)
INSERT INTO "product_images" ("product_id", "image_url", "sort_order") VALUES 
('10000000-0000-0000-0000-000000000001', 'https://static.nike.com/a/images/t_default/f12eb6bc-26ee-4eb3-81a1-f3b1456d2cf9/air-max-pulse-mens-shoes-2bZSZV.png', 1),
('10000000-0000-0000-0000-000000000002', 'https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/c6c39e0bd58249fcab17af430113c2f0_9366/Ultraboost_Light_Running_Shoes_White_HQ6339_01_standard.jpg', 1),
('10000000-0000-0000-0000-000000000003', 'https://images.puma.com/image/upload/f_auto,q_auto,b_rgb:fafafa,w_600,h_600/global/378288/01/sv01/fnd/PNA', 1),
('10000000-0000-0000-0000-000000000004', 'https://static.nike.com/a/images/t_default/b398642a-db3e-43f1-8fa1-71fb589255ec/air-force-1-07-mens-shoes-jBrhbr.png', 1);

PRINT 'Thêm mock data thành công!';
