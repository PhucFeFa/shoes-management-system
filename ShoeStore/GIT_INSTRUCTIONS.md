
File này lưu trữ quy trình và các câu lệnh mẫu để bạn có thể yêu cầu tôi thực hiện quy trình quản lý Source Code (Git) một cách an toàn và đúng chuẩn.

## 1. Mục đích của quy trình này
Khi làm việc với Git, đặc biệt là trong dự án nhóm (như dự án môn SWP391), việc tuân thủ quy tắc là bắt buộc để tránh làm hỏng code (conflict) hoặc gây lỗi cho hệ thống.
Quy trình của chúng ta sẽ luôn là:
1. Không code trực tiếp trên nhánh `main` hoặc `dev`.
2. Tạo một nhánh mới (branch) cho mỗi chức năng.
3. Commit code với thông điệp (message) rõ ràng.
4. Push nhánh mới đó lên GitHub để bạn (hoặc team) có thể Pull Request (PR) về nhánh `dev`.

## 2. Câu lệnh (Prompt) khuyên dùng
Khi bạn vừa code xong một tính năng và muốn tôi thực hiện việc Push code chuẩn chỉ, hãy gửi nguyên văn câu lệnh sau cho tôi:

> **"Hãy đọc file `GIT_INSTRUCTIONS.md`. Sau đó kiểm tra lỗi, loại bỏ các file rác/file MD. Tạo một nhánh mới tên là [TÊN NHÁNH, ví dụ: feature/login-page]. Hãy commit toàn bộ code chức năng vừa làm với description rõ ràng và push lên nhánh đó."**

## 3. Tiêu chuẩn Git (Dành cho AI)
Khi AI nhận được yêu cầu push code, AI (tôi) phải tuân thủ nghiêm ngặt các bước sau qua Terminal:
1. **Kiểm tra trạng thái**: `git status` để xem có file rác, file `.log`, hoặc thư mục `target/`, `node_modules/` không. Nếu có, tuyệt đối không được add.
2. **Bỏ qua file hướng dẫn**: Bỏ qua các file như `UML_INSTRUCTIONS.md` hoặc `GIT_INSTRUCTIONS.md` (bằng lệnh `git restore --staged *.md` nếu lỡ add).
3. **Tạo nhánh mới**: Dùng lệnh `git checkout -b feature/[tên-chức-năng]`. KHÔNG ĐƯỢC push thẳng lên `dev` hay `main`.
4. **Commit đúng chuẩn**: Sử dụng [Conventional Commits](https://www.conventionalcommits.org/). Ví dụ:
   - `feat: [Tên chức năng]` cho tính năng mới.
   - `fix: [Lỗi đã sửa]` cho việc fix bug.
   - Bổ sung **Description** rõ ràng bên trong commit message mô tả chi tiết đã làm gì.
5. **Push Code**: Dùng lệnh `git push -u origin [tên-nhánh]`.

---
*Lưu ý: Sau khi AI push xong, bạn (User) sẽ vào GitHub, tạo một Pull Request từ nhánh vừa push vào nhánh `dev` để kiểm duyệt trước khi merge vào source chính.*
