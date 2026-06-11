Shoes Store

Chào mừng các thành viên của nhóm đã tham gia vào dự án! Đây là tài liệu hướng dẫn giúp mọi người thiết lập môi trường chạy thử dự án và nắm vững quy trình làm việc với GitHub để tránh tối đa xung đột (conflict) mã nguồn.

---

## 🛠 1. Công nghệ Sử dụng (Tech Stack)
* **Frontend:** JSP, JSTL, HTML5, CSS3, JavaScript (Bootstrap / Tailwind)
* **Backend:** Java Servlet (Java EE / Jakarta EE)
* **Kiến trúc:** Pattern MVC với DAO (Data Access Object)
* **Công cụ quản lý thư viện:** Maven (hoặc Gradle)
* **Hệ quản trị CSDL:** MS SQL Server (hoặc MySQL)
* **Web Server:** Apache Tomcat (Phiên bản khuyến nghị: [Ví dụ: Tomcat 9])

---

## 💻 2. Hướng dẫn Cài đặt Môi trường (Setup)

Mọi thành viên cần đảm bảo máy tính đã cài đặt các công cụ sau trước khi chạy dự án:

### Bước 1: Chuẩn bị công cụ
1. Cài đặt **JDK** (Khuyến nghị phiên bản [Ví dụ: JDK 11 hoặc 17]).
2. Tải và giải nén **Apache Tomcat** tương thích với phiên bản Java.
3. Cài đặt IDE thích hợp: **IntelliJ IDEA Ultimate** hoặc **Eclipse Enterprise Edition**.
4. Cài đặt **MS SQL Server** và **SQL Server Management Studio (SSMS)**.

### Bước 2: Thiết lập Cơ sở dữ liệu
1. Mở SSMS, tạo một database mới tên là `[Tên_Database_Của_Bạn]`.
2. Mở file script đính kèm trong thư mục `/database/script.sql` của dự án, copy và chạy (Execute) toàn bộ để tạo bảng và dữ liệu mẫu.
3. Vào thư mục `src/main/java/.../utils/DBContext.java` (hoặc file cấu hình kết nối tương đương) để chỉnh sửa lại **Username** và **Password** tài khoản SQL Server của máy bạn.

---

## 🚀 3. Quy trình Làm việc với GitHub (Git Workflow)

Để đảm bảo code của dự án luôn chạy ổn định và không ai ghi đè lên code của ai, toàn bộ thành viên **TUYỆT ĐỐI KHÔNG** code trực tiếp trên nhánh `main`. Nhánh `main` chỉ dùng để chứa code đã hoàn chỉnh và chạy được.

### Quy trình 5 bước phát triển tính năng mới:

#### Bước 1: Cập nhật code mới nhất từ nhóm về máy
Trước khi bắt đầu code bất cứ thứ gì, hãy chuyển về nhánh `main` và kéo code mới nhất về:
```bash
git checkout main
git pull origin main
