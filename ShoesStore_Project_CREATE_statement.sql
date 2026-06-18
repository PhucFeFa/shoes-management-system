-- 1. Các bảng độc lập (không có khóa ngoại hoặc chỉ tham chiếu bảng đã tạo)
CREATE TABLE "roles"(
    "id" UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
    "name" NVARCHAR(50) NOT NULL,
    PRIMARY KEY("id"),
    CONSTRAINT "roles_name_unique" UNIQUE("name")
);

CREATE TABLE "categories"(
    "id" UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(), 
    "name" NVARCHAR(255) NOT NULL,
    PRIMARY KEY("id"),
    CONSTRAINT "categories_name_unique" UNIQUE("name")
);

CREATE TABLE "brands"(
    "id" UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(), 
    "name" NVARCHAR(255) NOT NULL,
    PRIMARY KEY("id"),
    CONSTRAINT "brands_name_unique" UNIQUE("name")
);

CREATE TABLE "vouchers"(
    "id" UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
    "code" NVARCHAR(50) NOT NULL,
    "discount_percent" DECIMAL(5, 2) NOT NULL,
    "max_discount_amount" DECIMAL(18, 2) NULL,
    "start_date" DATETIMEOFFSET NOT NULL,
    "end_date" DATETIMEOFFSET NOT NULL,
    "quantity" INT NOT NULL,
    "used_quantity" INT NOT NULL DEFAULT 0,
    PRIMARY KEY("id"),
    CONSTRAINT "vouchers_code_unique" UNIQUE("code")
);

-- 2. Bảng users (phụ thuộc roles)
CREATE TABLE "users"(
    "id" UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(), 
    "email" NVARCHAR(255) NOT NULL, 
    "password_hash" NVARCHAR(MAX) NOT NULL, 
    "role_id" UNIQUEIDENTIFIER NOT NULL,
    "created_at" DATETIMEOFFSET NOT NULL DEFAULT SYSDATETIMEOFFSET(),
    "full_name" NVARCHAR(255) NULL,
    PRIMARY KEY("id"),
    CONSTRAINT "users_email_unique" UNIQUE("email"),
    CONSTRAINT "users_role_id_foreign" FOREIGN KEY("role_id") REFERENCES "roles"("id")
);

-- 3. Bảng addresses (phụ thuộc users)
CREATE TABLE "addresses"(
    "id" UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(), 
    "user_id" UNIQUEIDENTIFIER NOT NULL, 
    "city" NVARCHAR(255) NOT NULL, 
    "district" NVARCHAR(255) NOT NULL, 
    "ward" NVARCHAR(255) NOT NULL, 
    "address_line" NVARCHAR(MAX) NOT NULL,
    PRIMARY KEY("id"),
    CONSTRAINT "addresses_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "users"("id")
);

-- 4. Bảng products (phụ thuộc categories, brands)
CREATE TABLE "products"(
    "id" UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(), 
    "name" NVARCHAR(255) NOT NULL, 
    "description" NVARCHAR(MAX) NULL, 
    "price" DECIMAL(18, 2) NOT NULL, 
    "category_id" UNIQUEIDENTIFIER NOT NULL, 
    "brand_id" UNIQUEIDENTIFIER NOT NULL, 
    "status" NVARCHAR(50) NOT NULL DEFAULT 'active' CHECK ("status" IN('active', 'inactive')),
    "created_at" DATETIMEOFFSET NOT NULL DEFAULT SYSDATETIMEOFFSET(),
    PRIMARY KEY("id"),
    CONSTRAINT "products_category_id_foreign" FOREIGN KEY("category_id") REFERENCES "categories"("id"),
    CONSTRAINT "products_brand_id_foreign" FOREIGN KEY("brand_id") REFERENCES "brands"("id")
);

CREATE TABLE "product_variants"(
    "id" UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(), 
    "product_id" UNIQUEIDENTIFIER NOT NULL, 
    "size" NVARCHAR(50) NOT NULL, 
    "color" NVARCHAR(50) NOT NULL, 
    "stock_quantity" INT NOT NULL, 
    "created_at" DATETIMEOFFSET NOT NULL DEFAULT SYSDATETIMEOFFSET(),
    PRIMARY KEY("id"),
    CONSTRAINT "product_variants_product_id_foreign" FOREIGN KEY("product_id") REFERENCES "products"("id")
);

CREATE TABLE "product_images"(
    "id" UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(), 
    "product_id" UNIQUEIDENTIFIER NOT NULL, 
    "image_url" NVARCHAR(MAX) NOT NULL, 
    "sort_order" INT NOT NULL, 
    "created_at" DATETIMEOFFSET NOT NULL DEFAULT SYSDATETIMEOFFSET(),
    PRIMARY KEY("id"),
    CONSTRAINT "product_images_product_id_foreign" FOREIGN KEY("product_id") REFERENCES "products"("id")
);

-- 5. Bảng imports (phụ thuộc users)
CREATE TABLE "imports"(
    "ImportID" INT IDENTITY(1,1) NOT NULL,
    "Supplier" NVARCHAR(255) NOT NULL,
    "UserID" UNIQUEIDENTIFIER NOT NULL,
    "OrderDate" DATETIMEOFFSET NOT NULL DEFAULT SYSDATETIMEOFFSET(),
    "TotalAmount" DECIMAL(18, 2) NOT NULL DEFAULT 0.00,
    "Status" NVARCHAR(50) NOT NULL DEFAULT 'pending', 
    "Note" NVARCHAR(MAX) NULL,
    PRIMARY KEY("ImportID"),
    CONSTRAINT "imports_user_id_foreign" FOREIGN KEY("UserID") REFERENCES "users"("id")
);

CREATE TABLE "import_details"(
    "ImportDetailID" INT IDENTITY(1,1) NOT NULL,
    "ImportID" INT NOT NULL,
    "ProductID" UNIQUEIDENTIFIER NOT NULL,
    "ImportQuantity" INT NOT NULL CHECK ("ImportQuantity" > 0),
    "ReceivedQuantity" INT NOT NULL DEFAULT 0 CHECK ("ReceivedQuantity" >= 0),
    "UnitPrice" DECIMAL(18, 2) NOT NULL CHECK ("UnitPrice" >= 0),
    PRIMARY KEY("ImportDetailID"),
    CONSTRAINT "chk_received_quantity_logic" CHECK ("ReceivedQuantity" <= "ImportQuantity"),
    CONSTRAINT "import_details_import_id_foreign" FOREIGN KEY("ImportID") REFERENCES "imports"("ImportID"),
    CONSTRAINT "import_details_product_id_foreign" FOREIGN KEY("ProductID") REFERENCES "products"("id")
);

-- 6. Bảng giao dịch (carts, orders, reviews, payments)
CREATE TABLE "carts"(
    "id" UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(), 
    "user_id" UNIQUEIDENTIFIER NOT NULL, 
    "created_at" DATETIMEOFFSET NOT NULL DEFAULT SYSDATETIMEOFFSET(),
    PRIMARY KEY("id"),
    CONSTRAINT "carts_user_id_unique" UNIQUE("user_id"),
    CONSTRAINT "carts_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "users"("id")
);

CREATE TABLE "cart_items"(
    "id" UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(), 
    "cart_id" UNIQUEIDENTIFIER NOT NULL, 
    "product_variant_id" UNIQUEIDENTIFIER NOT NULL, 
    "quantity" INT NOT NULL DEFAULT 1, 
    "created_at" DATETIMEOFFSET NOT NULL DEFAULT SYSDATETIMEOFFSET(),
    PRIMARY KEY("id"),
    CONSTRAINT "cart_items_cart_id_foreign" FOREIGN KEY("cart_id") REFERENCES "carts"("id"),
    CONSTRAINT "cart_items_product_variant_id_foreign" FOREIGN KEY("product_variant_id") REFERENCES "product_variants"("id")
);

CREATE TABLE "orders"(
    "id" UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(), 
    "user_id" UNIQUEIDENTIFIER NOT NULL, 
    "address_id" UNIQUEIDENTIFIER NOT NULL, 
    "total_amount" DECIMAL(18, 2) NOT NULL, 
    "status" NVARCHAR(50) NOT NULL DEFAULT 'pending' CHECK ("status" IN('pending', 'confirmed', 'shipping', 'completed', 'cancelled')),
    "voucher_id" UNIQUEIDENTIFIER NULL,
    "created_at" DATETIMEOFFSET NOT NULL DEFAULT SYSDATETIMEOFFSET(),
    PRIMARY KEY("id"),
    CONSTRAINT "orders_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "users"("id"),
    CONSTRAINT "orders_address_id_foreign" FOREIGN KEY("address_id") REFERENCES "addresses"("id"),
    CONSTRAINT "orders_voucher_id_foreign" FOREIGN KEY("voucher_id") REFERENCES "vouchers"("id")
);

CREATE TABLE "order_items"(
    "id" UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(), 
    "order_id" UNIQUEIDENTIFIER NOT NULL, 
    "product_variant_id" UNIQUEIDENTIFIER NOT NULL, 
    "quantity" INT NOT NULL, 
    "price_at_purchase" DECIMAL(18, 2) NOT NULL, 
    "created_at" DATETIMEOFFSET NOT NULL DEFAULT SYSDATETIMEOFFSET(),
    PRIMARY KEY("id"),
    CONSTRAINT "order_items_order_id_foreign" FOREIGN KEY("order_id") REFERENCES "orders"("id"),
    CONSTRAINT "order_items_product_variant_id_foreign" FOREIGN KEY("product_variant_id") REFERENCES "product_variants"("id")
);

CREATE TABLE "payments"(
    "id" UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(), 
    "order_id" UNIQUEIDENTIFIER NOT NULL, 
    "method" NVARCHAR(50) NOT NULL CHECK ("method" IN('cod', 'banking', 'momo', 'vnpay')),
    "status" NVARCHAR(50) NOT NULL CHECK ("status" IN('pending', 'paid', 'failed', 'refunded')),
    "amount" DECIMAL(18, 2) NOT NULL,
    "created_at" DATETIMEOFFSET NOT NULL DEFAULT SYSDATETIMEOFFSET(),
    PRIMARY KEY("id"),
    CONSTRAINT "payments_order_id_foreign" FOREIGN KEY("order_id") REFERENCES "orders"("id")
);

CREATE TABLE "reviews"(
    "id" UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(), 
    "user_id" UNIQUEIDENTIFIER NOT NULL, 
    "product_id" UNIQUEIDENTIFIER NOT NULL, 
    "rating" INT NOT NULL, 
    "comment" NVARCHAR(MAX) NULL, 
    "created_at" DATETIMEOFFSET NOT NULL DEFAULT SYSDATETIMEOFFSET(),
    PRIMARY KEY("id"),
    CONSTRAINT "reviews_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "users"("id"),
    CONSTRAINT "reviews_product_id_foreign" FOREIGN KEY("product_id") REFERENCES "products"("id")
);