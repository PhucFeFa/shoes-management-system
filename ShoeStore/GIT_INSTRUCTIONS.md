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

> **"Hãy đọc file `GIT_INSTRUCTIONS.md`. Sau đó kiểm tra lỗi, CHỈ ADD NHỮNG FILE BẠN VỪA CODE (Dùng đường dẫn cụ thể, TUYỆT ĐỐI KHÔNG DÙNG `git add .`). Loại bỏ các file rác, thư mục không cần thiết và tuyệt đối KHÔNG push file `.md`. Tạo một nhánh mới tên là [TÊN NHÁNH, ví dụ: feature/login-page]. Hãy commit code chức năng vừa làm với description rõ ràng và push lên nhánh đó."**

## 3. Tiêu chuẩn Git (Dành cho AI)
Khi AI nhận được yêu cầu push code, AI (tôi) phải tuân thủ nghiêm ngặt các bước sau qua Terminal:
1. **QUAY VỀ NHÁNH GỐC TRƯỚC KHI TẠO NHÁNH**: Lệnh `git checkout dev` (hoặc `main`) rồi dùng lệnh `git pull origin dev` để lấy code mới nhất. **TUYỆT ĐỐI KHÔNG rẽ nhánh từ một nhánh feature khác đang code dở dang chưa được merge** để tránh tình trạng PR bị dồn rác code từ các tính năng trước.
2. **Tạo nhánh mới**: Sau khi về nhánh gốc, dùng lệnh `git checkout -b feature/[tên-chức-năng]`. KHÔNG ĐƯỢC push thẳng lên `dev` hay `main`.
3. **Chỉ thêm những file ĐÃ CODE cho chức năng đó**: AI phải dùng lệnh `git diff --name-only` hoặc `git status` để xem xét, sau đó bắt buộc phải liệt kê từng file khi add (Ví dụ: `git add src/main/java/Servlet.java`). **TUYỆT ĐỐI KHÔNG BAO GIỜ SỬ DỤNG `git add .` HOẶC `git add -A` HOẶC `git commit -a`** để tránh lọt file thừa.
4. **Kiểm tra trạng thái**: `git status` để xem có file rác, file `.log`, file IDE, hoặc thư mục `target/`, `node_modules/` không. Nếu có, tuyệt đối không được add.
5. **Bỏ qua file MD**: Tuyệt đối không thêm và không commit bất kỳ file `.md` nào (như `UML_INSTRUCTIONS.md`, `GIT_INSTRUCTIONS.md`, `agent.md`). Nếu lỡ add phải gỡ bằng `git restore --staged *.md`.
6. **Commit đúng chuẩn và BẮT BUỘC CÓ DESCRIPTION**: Lệnh commit phải luôn bao gồm Description chi tiết bằng cách thêm nhiều thẻ `-m`.
   - Cú pháp chuẩn: `git commit -m "feat/fix: [Tiêu đề]" -m "- Chi tiết 1" -m "- Chi tiết 2"`.
   - AI bắt buộc phải tóm tắt ít nhất 2-3 gạch đầu dòng về những thay đổi cốt lõi (như thêm/sửa file nào, sửa lỗi gì) vào description.
7. **Push Code và Pull Request về DEV**: Dùng lệnh `git push -u origin [tên-nhánh]`. LƯU Ý: Toàn bộ branch được tạo và push lên CHỈ ĐƯỢC PHÉP Pull Request về nhánh `dev` (develop), tuyệt đối không bao giờ được gộp vào `main`.

---
*Lưu ý: Sau khi AI push xong, bạn (User) sẽ vào GitHub, tạo một Pull Request từ nhánh vừa push vào nhánh `dev` để kiểm duyệt trước khi merge vào source chính.*
