# 📚 TÀI LIỆU THUYẾT TRÌNH — LÂM HOÀNG PHÚC (CE191132)

> Dựa trên Backlog thực tế và đọc trực tiếp từ source code.

---

## 🗂️ DANH SÁCH CHỨC NĂNG CỦA BẠN (Theo Backlog)

| # | Chức năng | Nhóm | Servlet / File chính |
|---|---|---|---|
| 1 | Logout | Authentication | `LogoutServlet.java` |
| 2 | Login with Account | Authentication | `LoginServlet.java` |
| 3 | Register Account | Authentication | `RegisterServlet.java` + `VerifyOTPServlet.java` |
| 4 | Forgot Password | Authentication | `ForgotPasswordServlet.java` + `VerifyForgotOTPServlet.java` + `ResetPasswordServlet.java` |
| 5 | View List Product | View Products | `ProductCatalogServlet.java` |
| 6 | View Product Reviews | View Products | `ProductDetailServlet.java` |
| 7 | Submit Product Review | Product Reviews | `ReviewServlet.java` (action=add) |
| 8 | Edit Product Review | Product Reviews | `ReviewServlet.java` (action=update) |
| 9 | Delete Product Review | Product Reviews | `ReviewServlet.java` (action=delete) |
| 10 | Filter Review | Product Reviews | `ManageReviewServlet.java` |
| 11 | Place Order | Order Placement | `PlaceOrderServlet.java` |
| 12 | Add Staff | Staff Management | `CreateStaffServlet.java` |
| 13 | Edit Staff Information | Staff Management | `UpdateStaffServlet.java` |
| 14 | Deactivate Staff | Staff Management | `ToggleStaffStatusServlet.java` |
| 15 | Audit Log | Audit Log | `AuditLogServlet.java` |
| 16 | View product list (Admin) | Product Management | `ManageProductServlet.java` |
| 17 | Update product | Product Management | `EditProductServlet.java` |
| 18 | Show/Hide Product | Product Management | `ToggleProductStatusServlet.java` |
| 19 | View Category List | Category Management | `ManageCategoryServlet.java` (doGet) |
| 20 | Add Category | Category Management | `ManageCategoryServlet.java` (action=add) |
| 21 | Edit Category | Category Management | `ManageCategoryServlet.java` (action=edit) |
| 22 | Delete Category | Category Management | `ManageCategoryServlet.java` (action=delete) |
| 23 | View Brand List | Brand Management | `ManageBrandServlet.java` (doGet) |
| 24 | Add / Edit / Delete Brand | Brand Management | `ManageBrandServlet.java` |
| 25 | View Variant List | Variant Management | `ManageProductDetailsServlet.java` (doGet) |
| 26 | Add Variant | Variant Management | `ManageProductDetailsServlet.java` (action=add_variant) |
| 27 | Edit Variant | Variant Management | `ManageProductDetailsServlet.java` (action=edit_variant) |
| 28 | Delete Variant | Variant Management | `ManageProductDetailsServlet.java` (action=delete_variant) |

---

## 1. 🔑 ĐĂNG NHẬP (`LoginServlet.java`)

**URL:** `/login`  |  **View:** `login.jsp`

### Luồng xử lý
```
User nhập email + password → LoginServlet.doPost()
  → Bắt null/empty: email & password
  → UserDAO.login(email, password)     ← check bảng "users"
  → Nếu null → StaffDAO.checkLogin()  ← check bảng "staffs"
  → Lưu user vào session["currentUser"]
  → Redirect theo role:
      Admin  → /dashboard
      Staff  → /staff/orders
      khác   → /home
  → Sai → "Invalid email or password."
```

### Validation
| Điều kiện | Thông báo |
|---|---|
| email hoặc password null/rỗng/khoảng trắng | "Email and Password cannot be empty or just spaces." |
| Không tìm thấy user trong DB | "Invalid email or password." |

> **Q: Sao check 2 bảng?** → Hệ thống có 2 loại user: Customer (bảng `users`) và Staff/Admin (bảng `staffs`). Login phải check cả hai.

> **Q: Mật khẩu kiểm tra thế nào?** → Dùng `BCrypt.checkpw(password, hash)`. Không lưu plaintext bao giờ.

---

## 2. 📝 ĐĂNG KÝ (`RegisterServlet.java` + `VerifyOTPServlet.java`)

**URL:** `/register`  |  **View:** `register.jsp`

### Luồng xử lý
```
User nhập form → RegisterServlet.doPost()
  → Bắt null/empty: fullName, email, password, confirmPassword
  → Validate: password == confirmPassword
  → UserDAO.isEmailExists(email) → nếu trùng → báo lỗi
  → EmailUtil.generateOTP() → tạo OTP 6 số
  → EmailUtil.sendOTPEmail(email, otp, "register") → gửi Gmail
  → Lưu session: "pendingUser", "otpCode", "otpExpiry" (5 phút)
  → Hiện ô nhập OTP trên register.jsp (showOTP=true)
       ↓
User nhập OTP → VerifyOTPServlet.doPost()
  → Kiểm tra session["pendingUser"] != null
  → Kiểm tra System.currentTimeMillis() > otpExpiry → hết hạn
  → sessionOtp.equals(inputOtp) → đúng hay sai
  → Đúng: UserDAO.registerUser(pendingUser) → lưu DB
  → Xóa session OTP, redirect về /login
```

### Validation (Backend & Frontend)
**1. Frontend (`register.jsp` - Regex Patterns):**

- **Email Pattern:** `pattern="[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}"`
  - *Ý nghĩa:* Ép người dùng nhập đúng chuẩn email (ví dụ: `ten@mien.com`).
  - *Giải thích từng ký hiệu:*
    - `[a-zA-Z0-9._%+\-]+` : Định nghĩa phần tên trước chữ `@`. Cho phép chữ cái (hoa/thường), số và các ký tự đặc biệt (`. _ % + -`). Dấu `+` ở cuối nghĩa là phần này phải có ít nhất 1 ký tự.
    - `@` : Bắt buộc phải có ký tự `@`.
    - `[a-zA-Z0-9.\-]+` : Tên miền (ví dụ: `gmail`, `fpt`). Cho phép chữ cái, số, dấu chấm và gạch ngang. Dấu `+` là ít nhất 1 ký tự.
    - `\.` : Bắt buộc phải có một dấu chấm `.` (Dấu `\` dùng để escape ký tự `.`).
    - `[a-zA-Z]{2,}` : Phần đuôi tên miền (như `com`, `vn`, `edu`). Bắt buộc là chữ cái và có độ dài từ 2 ký tự trở lên (`{2,}`).
  - *Thông báo khi sai:* "Please enter a valid email address".

- **Password Pattern:** `pattern="(?=.*\d)(?=.*[A-Z]).{6,}"`
  - *Ý nghĩa:* Kiểm tra độ mạnh của mật khẩu (có số, có chữ hoa, tối thiểu 6 ký tự).
  - *Giải thích từng ký hiệu:*
    - `(?=.*\d)` : Cú pháp Lookahead. Quét toàn bộ chuỗi để đảm bảo có chứa ít nhất một chữ số (`\d`). Phần `.*` nghĩa là trước chữ số có thể có ký tự khác.
    - `(?=.*[A-Z])` : Quét toàn bộ chuỗi để đảm bảo có chứa ít nhất một chữ cái in hoa (`[A-Z]`).
    - `.{6,}` : Ký tự `.` đại diện cho "bất kỳ ký tự nào". `{6,}` nghĩa là phải có ít nhất 6 ký tự. (Tổng độ dài >= 6).
  - *Thông báo khi sai:* "Must contain at least one uppercase letter and one number".

**2. Backend (`RegisterServlet.java`):**
| Điều kiện | Thông báo lỗi |
|---|---|
| Bất kỳ field nào null/rỗng | "All fields are required and cannot be empty or just spaces." |
| password ≠ confirmPassword | "Passwords do not match." |
| Email đã có trong DB | "Email is already registered." |
| OTP hết hạn (> 5 phút) | "OTP has expired. Please register again." |
| OTP sai | "Invalid OTP code. Please try again." |

> **Q: Bắt trùng email ở đâu?** → `userDAO.isEmailExists(email)` → SQL: `SELECT COUNT(*) FROM users WHERE email = ?`

> **Q: OTP lưu ở đâu?** → `HttpSession`, key: `"otpCode"` và `"otpExpiry"` (timestamp System.currentTimeMillis() + 5*60*1000)

---

## 3. 🔓 QUÊN & ĐẶT LẠI MẬT KHẨU

**URLs:** `/forgot-password` → `/verify-forgot-otp` → `/reset-password`

### Luồng xử lý
```
User nhập Email → ForgotPasswordServlet.doPost()
  → UserDAO.isEmailExists() → nếu không có → "Email address not found."
  → Tạo OTP: String.format("%06d", new Random().nextInt(999999))
  → Lưu session: "forgotEmail", "forgotOtp", "forgotOtpTime"
  → EmailUtil.sendOTPEmail() → gửi email
       ↓
User nhập OTP → VerifyForgotOTPServlet.doPost()
  → Check thời gian (5 phút)
  → So sánh OTP
  → Đúng: session["otpVerified"] = true → redirect /reset-password
       ↓
User nhập mật khẩu mới → ResetPasswordServlet.doPost()
  → Check session["otpVerified"] == true (nếu không → về /forgot-password)
  → Bắt null/rỗng: password
  → Validate: password == confirmPassword
  → UserDAO.updatePassword(email, password)
  → Xóa tất cả session liên quan (forgotEmail, forgotOtp, otpVerified...)
  → Redirect /login?message=success
```

### Validation Reset Password
| Điều kiện | Thông báo |
|---|---|
| Chưa verify OTP | Redirect về /forgot-password |
| Password null/rỗng/khoảng trắng | "Password cannot be empty or just spaces." |
| password ≠ confirmPassword | "Passwords do not match." |

---

## 4. 🔏 ĐỔI MẬT KHẨU (`ChangePasswordServlet.java`)

**URL:** `/profile/change-password`  *(Chức năng này reviewer là Lâm Hoàng Phúc, người làm là Lâm Gia Bảo)*

### Validation — 8 bước theo thứ tự (dòng 30–66)
| Bước | Điều kiện | Thông báo |
|---|---|---|
| 1 | Chưa đăng nhập | Redirect /login |
| 2 | Bất kỳ field null/rỗng | "All fields are required." |
| 3 | newPassword ≠ confirmPassword | "New password and confirmation do not match." |
| 4 | newPassword bắt đầu/kết thúc bằng space | "New password cannot start or end with a space." |
| 5 | newPassword == oldPassword | "New password cannot be the same as your current password." |
| 6 | newPassword.length() < 6 | "New password must be at least 6 characters long." |
| 7 | Không có chữ hoa (`.*[A-Z].*`) HOẶC không có số (`.*\\d.*`) | "New password must contain at least one uppercase letter and one number." |
| 8 | oldPassword sai (verify lại qua BCrypt) | "Incorrect old password." |

> **Đây là chức năng có validation chặt nhất trong project.**

---

## 5. 🛍️ DANH SÁCH SẢN PHẨM + TÌM KIẾM (`ProductCatalogServlet.java`)

**URL:** `/products`  |  **View:** `products.jsp`  |  **DAO:** `ProductDAO.searchAndFilterProducts()`

### Tìm kiếm được gì?
5 tiêu chí cùng lúc:
1. **Tên sản phẩm** (`search`) → SQL: `LIKE '%keyword%'`
2. **Danh mục** (`category[]`) → nhiều lựa chọn
3. **Thương hiệu** (`brand[]`) → nhiều lựa chọn
4. **Giá tối thiểu** (`minPrice`) → `price >= minPrice`
5. **Giá tối đa** (`maxPrice`) → `price <= maxPrice`

### Phân trang
- 20 sản phẩm/trang
- URL param: `?page=2`
- `page < 1` → reset về 1

### Bắt null
```java
// Nếu giá nhập vào không phải số → bỏ qua, KHÔNG văng lỗi
try {
    minPrice = Double.parseDouble(minPriceParam);
} catch (NumberFormatException e) { /* ignore */ }
```

---

## 6. ⭐ ĐÁNH GIÁ SẢN PHẨM (`ReviewServlet.java`)

**URL:** `/review`  |  **Xử lý:** `action = add / update / delete`

### Submit Review (action=add)
**Điều kiện tiên quyết — bắt ở DAO:**
1. `reviewDAO.canUserReview(userId, productId)` → chỉ được review nếu **đã đặt hàng và đơn DELIVERED**
2. `reviewDAO.getReviewByUserAndProduct()` → nếu đã review rồi → "You have already reviewed this product."

**Validation nội dung:**
| Điều kiện | Thông báo |
|---|---|
| rating < 1 hoặc > 5 | "Invalid rating. Rating must be between 1 and 5." |
| comment rỗng | "Review comment cannot be empty." |

**Chống XSS (dòng 154–158):**
```java
private String sanitizeComment(String comment) {
    // Thay < và > bằng HTML entity để chặn script injection
    return comment.replaceAll("<", "&lt;").replaceAll(">", "&gt;").trim();
}
```

### Edit Review (action=update)
- Validate rating (1–5), comment không rỗng
- Check review tồn tại
- **Chỉ được sửa 1 lần:** `if (existingReview.isUpdated()) → "You can only update your review once."`

### Delete Review (action=delete)
- `reviewDAO.deleteReview(reviewId, currentUser.getId())` → đảm bảo chỉ xóa review của chính mình

---

## 7. 💳 ĐẶT HÀNG (`PlaceOrderServlet.java`)

**URL:** `/place-order`

### Luồng 12 bước
```
1.  Check session + user
2.  Lấy checkoutItems từ session
3.  Validate addressId != null (địa chỉ giao hàng)
4.  Với từng CartItem → variantDAO.getStockByVariant() → nếu stock < quantity → báo lỗi
5.  Tính subTotal = sum(price * quantity)
6.  Nếu có voucher → voucherDAO.getVoucherById() → trừ discount
7.  Nếu totalAmount < 0 → set về 0
8.  OrderDAO.createOrder() → tạo đơn (trả về orderId)
9.  Nếu có voucher → voucherDAO.decreaseVoucherQuantity()
10. Với từng item:
     - OrderDAO.addOrderItem() → thêm dòng chi tiết đơn
     - ProductVariantDAO.updateProductStock() → trừ tồn kho
     - CartDAO.removeCartItem() → xóa khỏi giỏ
11. session.removeAttribute("checkoutItems")
12. Redirect /order-success?orderId=...
```

### Validation
| Điều kiện | Hành động |
|---|---|
| checkoutItems null/rỗng | Redirect về /Cart |
| addressId null/rỗng | "Please select a shipping address." → về /checkout |
| stock < quantity cần mua | "X only has Y items left in stock." → về /checkout |

---

## 8. 🏷️ QUẢN LÝ CATEGORY (`ManageCategoryServlet.java`)

**URL:** `/admin/manage-categories`

### View (doGet)
- Lấy toàn bộ danh mục
- **Search:** lọc theo tên — `c.getName().toLowerCase().contains(q)` (tìm trong memory Java, không SQL)
- Phân trang: 10 category/trang

### Add Category (action=add)
| Điều kiện | Thông báo |
|---|---|
| name null/rỗng | "Category name cannot be empty." |
| name chỉ toàn số (`\\d+`) | "Category name cannot consist only of numbers." |
| Tên đã tồn tại (so sánh equalsIgnoreCase) | "This category already exists in the system." |

### Edit Category (action=edit)
- Validate giống Add
- **Bắt trùng loại trừ chính nó:** `.anyMatch(c -> c.getName().equalsIgnoreCase(name) && !c.getId().equals(id))`

### Delete Category (action=delete)
- `dao.deleteCategory(id)` → nếu category đang có sản phẩm → SQL bắt lỗi FK → trả về false
- Thông báo: "Cannot delete. This category contains products!"

---

## 9. 👟 QUẢN LÝ VARIANT (`ManageProductDetailsServlet.java`)

**URL:** `/admin/product/details`

### View (doGet)
- Search theo **size hoặc màu**: `v.getColor().toLowerCase().contains(q) || v.getSize().toLowerCase().contains(q)`
- Phân trang: 10 variant/trang

### Add Variant (action=add_variant)
| Điều kiện | Thông báo |
|---|---|
| size hoặc color null/rỗng | "Size and color cannot be empty." |
| size không phải số (`^\\d+(\\.\\d+)?$`) | "Size must be a valid number." |
| color chỉ toàn số (`\\d+`) | "Color cannot consist only of numbers." |
| Cặp (size+color) đã tồn tại (equalsIgnoreCase) | "This variant (Size + Color) already exists." |

### Edit Variant (action=edit_variant)
- Validate y như Add
- Bắt trùng loại trừ chính variant đang sửa
- **Giữ nguyên stock hiện có:** `v.setStockQuantity(currentStock)`

### Delete Variant (action=delete_variant)
- Nếu variant đã có trong đơn hàng → SQL FK error → false → "Failed to delete. This variant might have been ordered."

---

## 10. 📋 DUYỆT PHIẾU NHẬP HÀNG (`AdminImportDetailServlet.java`)

**URL:** `/admin/import-detail`

### doGet — Xem chi tiết phiếu
- Check role phải là **Admin** (không phải Staff)
- `id` param null/rỗng → redirect về `/import`
- `ImportDAO.getImportByID(importID)` → nếu không tìm thấy → redirect

### doPost — Duyệt/Hủy phiếu
| Điều kiện | Hành động |
|---|---|
| `note` null/rỗng | "Admin Note is strictly required for all actions." |
| action = "approve" | Status → APPROVED |
| action = "cancel" | Status → CANCELLED |

> **Q: Duyệt rồi tồn kho có tăng không?** → **Không ngay.** Phải đủ 4 bước: REQUESTING → APPROVED → REPORTED (Staff báo số lượng thực nhận) → COMPLETE (Stock mới được cộng bởi `completeStockIn()`)

---

## 11. 🗄️ GIẢI THÍCH TOÀN BỘ CẤU TRÚC DATABASE (ERD)

Vì bạn là người thiết kế Database, thầy sẽ hỏi rất kỹ về **lý do chuẩn hóa (Normalization)** và **tại sao lại chia bảng như vậy**. Dưới đây là giải thích toàn bộ 15 bảng trong hệ thống, chia theo từng nhóm nghiệp vụ:

### Nhóm 1: Quản lý Tài khoản (`users`, `staffs`, `roles`)
Hệ thống cố tình **tách làm 2 bảng riêng biệt** thay vì gộp chung một bảng `Accounts`.
- **`users` (Khách hàng & Người dùng ngoài):** Bảng này có khóa ngoại `role_id` liên kết với bảng `roles`. Khách hàng mua sắm sẽ bị ràng buộc với bảng giỏ hàng, địa chỉ và đơn hàng.
- **`staffs` (Nhân viên nội bộ):** Bảng này **KHÔNG CÓ cột role_id hay role_name**, chỉ lưu (`email`, `password_hash`, `full_name`, `status`). 
  - Tại sao không có Role? Vì hệ thống thiết kế tách hẳn mảng Nội bộ ra. Ai đã nằm trong bảng `staffs` thì mặc định là nhân viên nội bộ (khi login, Java Backend `StaffDAO.java` sẽ tự gán quyền truy cập quản trị).
- **Lý do chuẩn hóa (Tách bảng):** Để bảo mật tuyệt đối và tránh phình to dữ liệu. Người mua hàng (users) không bao giờ được phép lẫn lộn với nhân viên (staffs). Nếu gộp chung lại và chỉ phân biệt bằng cột Role, lỡ code bị lỗi phân quyền, hacker hoặc khách hàng có thể chọc vào đường dẫn quản trị. Việc tách thành 2 bảng riêng biệt giúp hệ thống kiểm soát độc lập (ví dụ Login phải dò 2 bảng).

### Nhóm 2: Catalog Sản phẩm (`categories`, `brands`, `products`, `product_images`, `product_variants`)
Đây là nhóm phức tạp nhất để quản lý bán lẻ thời trang:
- **`categories` & `brands`:** Các bảng chuẩn hóa (chuẩn 1NF) lưu Danh mục và Thương hiệu. `products` sẽ liên kết khóa ngoại (`category_id`, `brand_id`) tới đây để tiện lọc (Filter) và tìm kiếm.
- **`products`:** Bảng cha. Chỉ lưu các thông tin **dùng chung** cho cả dòng sản phẩm (Tên giày, Mô tả, Giá gốc, Trạng thái).
- **`product_images`:** Bảng lưu URL hình ảnh. Việc tách bảng giúp 1 sản phẩm có một thư viện ảnh (gallery) thay vì bị giới hạn 1-2 cột cố định.
  - **Câu hỏi của thầy:** *"Tại sao hiện tại anh thấy trên web mỗi đôi giày chỉ có 1 ảnh mà lại tách ra 1 bảng riêng, sao không nhét luôn cột image_url vào bảng products?"*
  - **Trả lời:** *"Dạ đúng là hiện tại Form upload (frontend HTML) nhóm em chỉ đang cho phép chọn 1 ảnh. Tuy nhiên, việc em thiết kế tách riêng bảng `product_images` (quan hệ 1-N) là tư duy thiết kế mở rộng (Scalable). Nó giúp hệ thống sẵn sàng cho việc nâng cấp chức năng slider/gallery nhiều góc chụp cho giày trong tương lai mà không cần phải đập đi xây lại cấu trúc Database."*
  - **Cách lấy ảnh chính:** Bảng này có cột `sort_order` (thứ tự sắp xếp). Trong file DAO, hệ thống dùng câu Subquery: `(SELECT TOP 1 image_url FROM product_images pi WHERE pi.product_id = p.id ORDER BY sort_order ASC)`. Code sẽ lấy ra đúng 1 tấm ảnh có `sort_order` nhỏ nhất để làm ảnh đại diện (thumbnail) hiển thị ra ngoài.
- **`product_variants` (Biến thể):** Bảng con của `products`. Mối quan hệ 1-Nhiều. 
  - **Lý do tách bảng:** Trong ngành giày, một đôi giày (Product) sẽ có nhiều Size và Màu khác nhau. Tồn kho (Stock) phải được đếm trên **từng đôi giày cụ thể (từng biến thể)** chứ không thể đếm chung chung.
  - **Cột quan trọng:** `size`, `color`, `stock_quantity`. Khi bán hàng hoặc nhập hàng, mọi thao tác tăng giảm số lượng đều chọc vào bảng `product_variants`, KHÔNG chọc vào `products`.

### Nhóm 3: Mua sắm & Khuyến mãi (`addresses`, `carts`, `vouchers`)
- **`addresses`:** 1 User có nhiều địa chỉ nhận hàng (nhà riêng, công ty). Liên kết khóa ngoại `user_id`. Tách bảng giúp lúc Checkout user có thể chọn địa chỉ nhanh chóng mà không cần gõ lại.
- **`carts` (Giỏ hàng):** Thiết kế phẳng (flat structure), mỗi dòng là một sản phẩm trong giỏ của một user cụ thể. Nối `user_id` và `product_variant_id`. 
  - **Tại sao không nối với `product_id`?** Vì user thêm vào giỏ là thêm "Giày size 42 màu Đen" (biến thể - variant), chứ không phải thêm "Giày chung chung".
- **`vouchers`:** Quản lý mã giảm giá. Có các cột `discount_value` (trị giá), `min_order_amount` (điều kiện áp dụng), `max_discount_amount` (giới hạn), `quantity` (số lượng). Khi thanh toán, hệ thống sẽ check các cột này.

### Nhóm 4: Xử lý Đơn hàng (`orders`, `order_items`, `order_staff_logs`)
- **`orders`:** Lưu thông tin tổng quát của 1 lần mua hàng (Mã KH `user_id`, Mã địa chỉ `address_id`, `total_amount`, `status`, `payment_method`).
- **`order_items`:** Lưu chi tiết đơn (mua những biến thể nào). Liên kết `order_id` và `variant_id`.
  - **Cột cực kỳ quan trọng:** `price` (Giá tại thời điểm mua). Dù giá sản phẩm có thay đổi ở bảng `products` vào ngày mai, thì hóa đơn lịch sử hôm nay vẫn phải giữ đúng mức giá mà khách đã mua. Do đó, `price` phải được lưu cứng vào `order_items`.
- **`order_staff_logs`:** Bảng lịch sử (Audit Log). Ghi nhận lại Staff nào (`staff_id`) đã thay đổi trạng thái Đơn hàng nào (`order_id`) vào lúc nào. Dùng để truy vết trách nhiệm nếu có sai sót.

### Nhóm 5: Quản lý Kho bãi (`imports`, `import_details`)
- **Mục đích:** Để minh bạch quy trình nhập kho (Không cho phép tự ý tăng số lượng `stock_quantity` bằng tay, mọi sự tăng stock đều phải qua chứng từ nhập kho).
- **`imports`:** Hóa đơn nhập từ Nhà cung cấp (`supplier`). Liên kết người lập phiếu (`user_id` lấy từ session của bảng `staffs`).
- **`import_details`:** Chi tiết nhập lô hàng nào (`variant_id`), số lượng bao nhiêu, đơn giá nhập (`import_price`) là bao nhiêu. Khi trạng thái `imports` chuyển thành `COMPLETE`, trigger/logic code mới lấy số lượng từ đây để cộng vào bảng `product_variants`.

### Nhóm 6: Tương tác Khách hàng (`reviews`)
- **`reviews`:** Bảng trung gian nối `users` và `products`.
- **Ý nghĩa:** Cho phép Khách hàng đã mua sản phẩm để lại Điểm số (`rating` 1-5) và Bình luận (`comment`). Logic backend đảm bảo 1 user chỉ được review 1 lần cho 1 sản phẩm, và chỉ review khi trạng thái order là `DELIVERED`.

---

## 12. 🔑 KIẾN THỨC NỀN TẢNG CẦN NẮM

### Kiến trúc MVC
```
Browser → Servlet (Controller) → DAO (Model) → SQL Server DB
                ↓
           JSP (View) ← request.setAttribute(...)
```

### Pattern bắt null chuẩn xuyên suốt project
```java
if (field == null || field.trim().isEmpty()) {
    request.setAttribute("error", "Thông báo lỗi");
    request.getRequestDispatcher("/file.jsp").forward(request, response);
    return; // LUÔN PHẢI có return để dừng xử lý
}
```

### Session & Phân quyền
- User đăng nhập được lưu vào: `session.setAttribute("currentUser", user)`
- Phân quyền trong Servlet: `user.getRoleName()` → `"Admin"` / `"Staff"` / Customer
- `AuthFilter.java` tự động chặn các URL nhạy cảm (`/profile/*`, `/Cart`, `/checkout`, `/admin/*`, `/staff/*`) nếu chưa đăng nhập

### 12.5. BCrypt (Mã hóa mật khẩu)
- Mật khẩu lưu trong DB là đoạn Hash không thể dịch ngược.
- Đăng ký: Dùng `BCrypt.hashpw(password, BCrypt.gensalt())` để băm.
- Đăng nhập/verify: Dùng `BCrypt.checkpw(plainPassword, hashInDB)` để so sánh. Không bao giờ gán `if (pass == hash)`.

### 12.6. Cơ chế Upload Ảnh (File Upload)
Trong chức năng thêm sản phẩm (`AddProductServlet`), luồng xử lý ảnh hoạt động như sau:
1. **Frontend:** Form HTML phải có thuộc tính `enctype="multipart/form-data"` để trình duyệt chia nhỏ file ảnh gửi lên server.
2. **Cấu hình Servlet:** Servlet phải có annotation `@MultipartConfig` (giới hạn dung lượng max 10MB) thì mới nhận được file.
3. **Lưu file vật lý (Vào ổ cứng):**
   - Code dùng `request.getParts()` để lấy ra các file.
   - Khi tải ảnh lên, để tránh bị trùng tên (ví dụ 2 đôi giày khác nhau cùng tải lên ảnh `giay.png` sẽ đè nhau mất ảnh), hệ thống dùng `UUID.randomUUID().toString()` gắn vào trước tên gốc. Ảnh sẽ có tên dạng `550e8400-e29b-..._giay.png`.
   - File được ghi thẳng vào ổ cứng ngoài tại: `D:\Upload_ShoesStore`.
4. **Lưu đường dẫn vào Database (Logical Path):**
   - Database không lưu cả file ảnh (gây nặng DB), mà chỉ lưu chuỗi đường dẫn (VD: `/ShoeStore/uploads/550e8400..._giay.png`).
   - Ứng dụng Tomcat được cấu hình (Virtual Directory Mapping trong `server.xml`) để cứ khi nào người dùng vào đường dẫn `/uploads/`, hệ thống sẽ tự động trỏ vào đọc ổ `D:\Upload_ShoesStore`.

---

## ❓ CÂU HỎI — CÂU TRẢ LỜI MẪU

**Q: Em bắt valid password ở đâu?**
> "Em bắt trong `ChangePasswordServlet.doPost()`, gồm 8 bước theo thứ tự: null check → 2 password khớp → không có khoảng trắng đầu/cuối → không trùng password cũ → tối thiểu 6 ký tự → phải có chữ hoa và số → cuối cùng mới verify password cũ bằng BCrypt qua DB."

**Q: Em bắt trùng email ở đâu?**
> "Em gọi `userDAO.isEmailExists(email)` trong `RegisterServlet`. Hàm này chạy SQL `SELECT COUNT(*) FROM users WHERE email = ?`. Nếu count > 0 là email trùng, em set error và forward lại form."

**Q: OTP hoạt động như nào?**
> "OTP 6 số được tạo bằng `EmailUtil.generateOTP()`, gửi qua Gmail SMTP. OTP và thời gian hết hạn (5 phút) lưu trong HttpSession. Khi user nhập OTP, em so sánh với session và kiểm tra `System.currentTimeMillis() > otpExpiry`. Sau khi verify xong thì xóa hết OTP khỏi session."

**Q: Search sản phẩm tìm được gì?**
> "Trang `/products` hỗ trợ lọc đồng thời 5 tiêu chí: tên sản phẩm (LIKE), danh mục (multi-select), thương hiệu (multi-select), giá tối thiểu và giá tối đa. Có phân trang 20 sản phẩm/trang."

**Q: Tại sao không xóa được category/variant?**
> "Vì Database có ràng buộc khóa ngoại (Foreign Key). Category đang gắn với sản phẩm, variant đang nằm trong đơn hàng thì SQL Server sẽ chặn lệnh DELETE và trả về lỗi. Em bắt exception đó và hiển thị thông báo cho người dùng."

**Q: Review có điều kiện gì?**
> "Chỉ review được khi đơn hàng đã DELIVERED. Em check qua `reviewDAO.canUserReview()`. Mỗi user chỉ review 1 lần/sản phẩm, và chỉ được sửa đúng 1 lần (`isUpdated()` check)."

**Q: Đặt hàng rồi tồn kho có giảm không?**
> "Có. Trong `PlaceOrderServlet`, sau khi tạo đơn thành công, em gọi `variantDAO.updateProductStock()` để trừ tồn kho của từng biến thể. Đồng thời xóa item khỏi giỏ hàng của user."

**Q: Phân quyền em làm ở đâu?**
> "Em có 2 lớp: Thứ nhất là `AuthFilter.java` tự động chặn các URL theo pattern nếu chưa đăng nhập. Thứ hai là trong mỗi Servlet em kiểm tra `user.getRoleName()`, ví dụ `AdminImportDetailServlet` chỉ cho phép role 'Admin', Staff cố truy cập sẽ bị redirect về /login."
