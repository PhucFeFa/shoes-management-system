# 👟 Shoes Management System (SOLE_LAB)

Chào mừng các thành viên đến với dự án **Shoes Management System** (tên thương hiệu UI: **SOLE_LAB** / **ADIDIS**). Đây là đồ án môn học SWP391, được xây dựng dựa trên mô hình MVC chuẩn, sử dụng Java Web (JSP/Servlet) kết hợp với giao diện hiện đại Tailwind CSS.

Tài liệu này là "kim chỉ nam" cho tất cả các thành viên trong nhóm. Hãy đọc kỹ trước khi bắt đầu code!

---

## 🛠 Tech Stack (Công nghệ sử dụng)
- **Backend:** Java 17+, Servlet, JSP, JSTL.
- **Frontend:** HTML5, CSS3, JavaScript, **Tailwind CSS** (via CDN).
- **Database:** Microsoft SQL Server.
- **Build Tool:** Maven.
- **Server:** Apache Tomcat (v10+).

---

## 🚀 Hướng dẫn cài đặt môi trường (Local Setup)

1. **Clone dự án về máy:**
   ```bash
   git clone https://github.com/PhucFeFa/shoes-management-system.git
   ```

2. **Cài đặt Database:**
   - Mở SQL Server Management Studio (SSMS).
   - Chạy toàn bộ file `ShoesStore_Project_CREATE_statement.sql` để tạo cấu trúc bảng (Lưu ý: Hệ thống đã tách riêng bảng `roles` và có bảng `vouchers`).
   - Chạy toàn bộ file `ShoesStore_Project_INSERT_statement.sql` để tạo dữ liệu mẫu (đã bao gồm tài khoản ảo `test@solelab.com` / `123456`).

3. **Cấu hình Database (DBContext):**
   - Mở file `src/main/java/com/mycompany/shoestore/db/DBContext.java`.
   - Đảm bảo đổi lại `DB_URL`, `USER`, và `PASSWORD` cho khớp với SQL Server trên máy tính cá nhân của bạn.

4. **Chạy Server:**
   - Sử dụng IDE (NetBeans, IntelliJ, hoặc Eclipse) đã tích hợp sẵn Tomcat.
   - Run project và truy cập `http://localhost:8080/ShoeStore/home`.

---

## 👨‍💻 Quy trình làm việc với Git & GitHub (BẮT BUỘC)

Để tránh conflict và hỏng source code của nhóm, **TUYỆT ĐỐI KHÔNG ĐƯỢC PUSH TRỰC TIẾP LÊN NHÁNH `develop` HAY `main`**. Chúng ta áp dụng quy trình chuẩn chuyên nghiệp sau:

### Bước 1: Tạo nhánh mới (Feature Branch)
Khi bạn được giao làm một tính năng mới (ví dụ: giỏ hàng, đăng ký), hãy tạo một nhánh mới từ nhánh `develop` mới nhất.
```bash
git checkout develop
git pull origin develop
git checkout -b feature/[tên-chức-năng]
```
*(Ví dụ: `git checkout -b feature/cart-page`)*

### Bước 2: Code và Gắn định danh Tác giả
- Tuân thủ mô hình MVC (Models, DAO, Controllers, Views).
- **Luôn luôn thêm comment Author** ở dòng đầu tiên của bất kỳ file nào bạn tạo ra hoặc chỉnh sửa chính.
  - File Java: `// Author: Tên-MãSV` (Ví dụ: `// Author: PhucLHCE191132`)
  - File JSP: `<%-- Author: Tên-MãSV --%>`

### Bước 3: Commit Code theo chuẩn Conventional Commits
Chỉ add những file liên quan đến chức năng. Bỏ qua file `.log`, thư mục `target/`, v.v.
```bash
git add .
git commit -m "feat: [Mô tả ngắn gọn chức năng]" -m "- Chi tiết 1" -m "- Chi tiết 2"
```
*Các tiền tố cho phép: `feat` (chức năng mới), `fix` (sửa lỗi), `chore` (cấu hình/linh tinh).*

### Bước 4: Push lên GitHub và tạo Pull Request (PR)
```bash
git push -u origin feature/[tên-chức-năng]
```
Sau đó, hãy lên GitHub:
1. Chuyển sang tab **Pull requests** -> Tạo **New pull request**.
2. Chọn gộp từ nhánh `feature/...` của bạn vào nhánh `develop`.
3. Hệ thống sẽ dựa trên file `.github/CODEOWNERS` để tự động yêu cầu **@PhucFeFa (Code Owner)** duyệt code.
4. Chỉ khi nào PR được Approve và Merge, code của bạn mới chính thức vào source chung.

---

## 🎨 Tiêu chuẩn Giao diện (UI)
- Toàn bộ giao diện sử dụng **Tailwind CSS**.
- **Không code CSS chay trừ khi thật sự cần thiết.** Mọi file đều dùng CDN: `<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>`
- Nếu là trang nội dung bình thường, hãy bọc nội dung bằng `<jsp:include page="/WEB-INF/include/header.jsp" />` và `footer.jsp`. Nếu là trang chuyên biệt (như Login/Register) thì có thể thiết kế độc lập.

Chúc các bạn code vui vẻ, ít Bug và hoàn thành tốt đồ án SWP391! 🎯
