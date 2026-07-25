-- 1. Independent tables (no foreign keys or only reference already-created tables)
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
    "discount_value" DECIMAL(18, 2) NOT NULL,
    "min_order_amount" DECIMAL(18, 2) NOT NULL DEFAULT 0.00 CHECK ("min_order_amount" >= 0),
    "max_discount_amount" DECIMAL(18, 2) NULL,
    "start_date" DATETIMEOFFSET NOT NULL,
    "end_date" DATETIMEOFFSET NOT NULL,
    "quantity" INT NOT NULL,
    "used_quantity" INT NOT NULL DEFAULT 0,
    "status" NVARCHAR(50) NOT NULL DEFAULT 'ACTIVE',
    PRIMARY KEY("id"),
    CONSTRAINT "vouchers_code_unique" UNIQUE("code")
);

-- 2. staffs table (independent — staff are separate from regular users)
CREATE TABLE "staffs"(
    "id" UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(), 
    "email" NVARCHAR(255) NOT NULL, 
    "password_hash" NVARCHAR(MAX) NOT NULL, 
    "full_name" NVARCHAR(255) NULL,
    "status" NVARCHAR(50) NOT NULL DEFAULT 'Active',
    "created_at" DATETIMEOFFSET NOT NULL DEFAULT SYSDATETIMEOFFSET(),
    PRIMARY KEY("id"),
    CONSTRAINT "staffs_email_unique" UNIQUE("email")
);

-- 3. users table (depends on roles)
CREATE TABLE "users"(
    "id" UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(), 
    "email" NVARCHAR(255) NOT NULL, 
    "password_hash" NVARCHAR(MAX) NOT NULL, 
    "role_id" UNIQUEIDENTIFIER NOT NULL,
    "created_at" DATETIMEOFFSET NOT NULL DEFAULT SYSDATETIMEOFFSET(),
    "full_name" NVARCHAR(255) NULL,
    "status" NVARCHAR(50) NOT NULL DEFAULT 'Active',
    PRIMARY KEY("id"),
    CONSTRAINT "users_email_unique" UNIQUE("email"),
    CONSTRAINT "users_role_id_foreign" FOREIGN KEY("role_id") REFERENCES "roles"("id")
);

-- 4. addresses table (depends on users)
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

-- 5. products tables (depend on categories, brands)
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
    "stock_quantity" INT NOT NULL DEFAULT 0, 
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

-- 6. imports tables (StaffID references staffs, VariantID references product_variants)
CREATE TABLE "imports"(
    "ImportID" INT IDENTITY(1,1) NOT NULL,
    "Supplier" NVARCHAR(255) NOT NULL,
    "StaffID" UNIQUEIDENTIFIER NOT NULL,
    "OrderDate" DATETIMEOFFSET NOT NULL DEFAULT SYSDATETIMEOFFSET(),
    "TotalAmount" DECIMAL(18, 2) NOT NULL DEFAULT 0.00,
    "Status" NVARCHAR(50) NOT NULL DEFAULT 'REQUESTING', 
    "Note" NVARCHAR(MAX) NULL,
    PRIMARY KEY("ImportID"),
    CONSTRAINT "imports_staff_id_foreign" FOREIGN KEY("StaffID") REFERENCES "staffs"("id")
);

CREATE TABLE "import_details"(
    "ImportDetailID" INT IDENTITY(1,1) NOT NULL,
    "ImportID" INT NOT NULL,
    "VariantID" UNIQUEIDENTIFIER NOT NULL,
    "ImportQuantity" INT NOT NULL CHECK ("ImportQuantity" > 0),
    "ReceivedQuantity" INT NOT NULL DEFAULT 0 CHECK ("ReceivedQuantity" >= 0),
    "UnitPrice" DECIMAL(18, 2) NOT NULL CHECK ("UnitPrice" >= 0),
    PRIMARY KEY("ImportDetailID"),
    CONSTRAINT "chk_received_quantity_logic" CHECK ("ReceivedQuantity" <= "ImportQuantity"),
    CONSTRAINT "import_details_import_id_foreign" FOREIGN KEY("ImportID") REFERENCES "imports"("ImportID"),
    CONSTRAINT "import_details_variant_id_foreign" FOREIGN KEY("VariantID") REFERENCES "product_variants"("id")
);

-- 7. carts table (flat structure: one row per user+variant, matches CartDAO)
--    No separate cart_items table — product_variant_id and quantity are directly on carts
CREATE TABLE "carts"(
    "id" UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(), 
    "user_id" UNIQUEIDENTIFIER NOT NULL, 
    "product_variant_id" UNIQUEIDENTIFIER NOT NULL,
    "quantity" INT NOT NULL DEFAULT 1,
    "created_at" DATETIMEOFFSET NOT NULL DEFAULT SYSDATETIMEOFFSET(),
    PRIMARY KEY("id"),
    CONSTRAINT "carts_user_variant_unique" UNIQUE("user_id", "product_variant_id"),
    CONSTRAINT "carts_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "users"("id"),
    CONSTRAINT "carts_product_variant_id_foreign" FOREIGN KEY("product_variant_id") REFERENCES "product_variants"("id")
);

-- 8. orders tables
CREATE TABLE "orders"(
    "id" UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(), 
    "user_id" UNIQUEIDENTIFIER NOT NULL, 
    "address_id" UNIQUEIDENTIFIER NOT NULL, 
    "total_amount" DECIMAL(18, 2) NOT NULL, 
    "status" NVARCHAR(50) NOT NULL DEFAULT 'pending' CHECK ("status" IN('pending', 'confirmed', 'shipping', 'completed', 'cancelled')),
    "voucher_id" UNIQUEIDENTIFIER NULL,
    "payment_method" NVARCHAR(50) NOT NULL DEFAULT 'cod' CHECK ("payment_method" IN('cod')),
    "payment_status" NVARCHAR(50) NOT NULL DEFAULT 'pending' CHECK ("payment_status" IN('pending', 'paid', 'failed', 'refunded')),
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

CREATE TABLE "order_staff_logs"(
    "id" UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
    "order_id" UNIQUEIDENTIFIER NOT NULL,
    "staff_id" UNIQUEIDENTIFIER NOT NULL,
    "action" NVARCHAR(255) NOT NULL,
    "created_at" DATETIMEOFFSET NOT NULL DEFAULT SYSDATETIMEOFFSET(),
    PRIMARY KEY("id"),
    CONSTRAINT "order_staff_logs_order_id_foreign" FOREIGN KEY("order_id") REFERENCES "orders"("id"),
    CONSTRAINT "order_staff_logs_staff_id_foreign" FOREIGN KEY("staff_id") REFERENCES "staffs"("id")
);

-- 9. reviews table
CREATE TABLE "reviews"(
    "id" UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(), 
    "user_id" UNIQUEIDENTIFIER NOT NULL, 
    "product_id" UNIQUEIDENTIFIER NOT NULL, 
    "rating" INT NOT NULL, 
    "comment" NVARCHAR(MAX) NULL, 
    "previous_comment" NVARCHAR(MAX) NULL,
    "updated_at" DATETIMEOFFSET NULL,
    "is_updated" BIT NOT NULL DEFAULT 0,
    "created_at" DATETIMEOFFSET NOT NULL DEFAULT SYSDATETIMEOFFSET(),
    "moderation_status" NVARCHAR(50) DEFAULT 'VISIBLE',
    "hide_reason" NVARCHAR(MAX) NULL,
    "reply_comment" NVARCHAR(MAX) NULL,
    "replied_by" UNIQUEIDENTIFIER NULL,
    "reply_updated_at" DATETIMEOFFSET NULL,
    PRIMARY KEY("id"),
    CONSTRAINT "reviews_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "users"("id"),
    CONSTRAINT "reviews_product_id_foreign" FOREIGN KEY("product_id") REFERENCES "products"("id"),
    CONSTRAINT "reviews_replied_by_foreign" FOREIGN KEY("replied_by") REFERENCES "staffs"("id")
);
