# AI Coding Guidelines for ShoeStore Project

## 1. Core Architecture & Philosophy
*   **Pattern:** Standard MVC (Model-View-Controller) using Java Servlet, JSP, and JDBC.
*   **Philosophy:** Keep it simple, readable, and "human-like". Prioritize explicit, easy-to-understand code over complex optimizations or over-engineering.
*   **Flow:** Client Request -> Servlet (Controller) -> DAO (Database Access) -> Servlet (Set Attributes) -> JSP (View Rendering via JSTL).

## 2. Directory & Package Structure
*   `src/main/java/controller/`: Contains Servlets (e.g., `HomeServlet.java`, `ProductServlet.java`).
*   `src/main/java/dao/`: Contains Data Access Objects for CRUD operations.
*   `src/main/java/model/`: Contains DTO/Entity classes (e.g., `Product`, `User`).
*   `src/main/java/db/`: Contains Database connection utilities (`DBContext`).
*   `src/main/java/util/`: Contains helper/utility classes.

## 3. UI & JSP Componentization Rules
*   **Do NOT create a separate `head.jsp`.**
*   **`WEB-INF/include/header.jsp`:** Must contain `<!DOCTYPE html>`, `<html>`, `<head>` (with CSS links, title, meta), opening `<body>` tag, and the `<header>` navigation bar.
*   **`WEB-INF/include/footer.jsp`:** Must contain the `<footer>` section, `<script>` tags, closing `</body>`, and closing `</html>`.
*   **Main Pages (e.g., `home.jsp`):** Should only contain the specific `<main>` content and wrap itself with:
    ```jsp
    <jsp:include page="/WEB-INF/include/header.jsp" />
    <!-- Page specific content here -->
    <jsp:include page="/WEB-INF/include/footer.jsp" />
    ```

## 4. Database Rules
*   Database Engine: SQL Server.
*   Primary Keys use `UNIQUEIDENTIFIER` (UUID/NEWID()). Map these to `String` in Java for simplicity.
*   Use standard JDBC `PreparedStatement` to prevent SQL Injection.

## 5. UI/CSS Rules
*   Use Tailwind CSS.
*   Extract reusable styles and colors as defined in the master HTML template.
*   Keep designs matching the provided UI/UX guidelines (modern, engineered speed aesthetic).

## 6. Code Attribution (Author)
*   **MANDATORY:** Every single code file (.java, .jsp, etc.) created or significantly modified by the AI MUST include the following author comment at the very top of the file:
    *   For Java files: `// Author: PhucLHCE191132`
    *   For JSP files: `<%-- Author: PhucLHCE191132 --%>`
