<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/include/header.jsp" />
    <div class="pt-16 min-h-screen flex flex-col md:flex-row w-full max-w-[1440px] mx-auto">
        <div class="hidden md:flex md:w-1/2 lg:w-7/12 relative bg-surface-container-high overflow-hidden"
            style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuAndYwBN84UeC0US17gsvQ_p5Py-jrMUiR7JRAgWPIUD6t01B0qPabS8cpG5eiia3RL9dcrYliTpv7TQXnyIbeo1lU3gKC3I4ylRN0rT-FPxtznwBowO8uUflsyiJ0olMzxSrMtim-Q9vrhlqIuD7aaYVYpeDhx1ZkWJmkfK724EB1M_DZqy-_N7fb5BnIVwe66-q5eIclOIm-qPQHvsxyYxcEx6JIjV3PENNEdGNkFGk8s5w012wnXMd7hGEZ2Wh9t0kJPRJiXwwE'); background-size: cover; background-position: center;">
            <div class="absolute inset-0 bg-gradient-to-t from-black/40 to-transparent"></div>
        </div>
        <div class="w-full md:w-1/2 lg:w-5/12 flex flex-col min-h-screen relative bg-surface-container-lowest">
            <div class="w-full pt-12 pb-8 flex justify-center items-center">
                <a class="text-headline-md font-headline-md font-extrabold tracking-tighter text-primary" href="${pageContext.request.contextPath}/home">Adidis</a>
            </div>
            <div class="flex-1 flex flex-col justify-center px-8 sm:px-12 md:px-16 lg:px-24 pb-24">
                <c:if test="${not empty error}">
                    <div class="bg-error-container text-on-error-container border border-error p-4 mb-6 rounded-sm text-label-md font-label-md">
                        ${error}
                    </div>
                </c:if>

                <form class="flex flex-col space-y-6 w-full opacity-100 transition-opacity duration-300" id="form-reset" action="${pageContext.request.contextPath}/reset-password" method="POST">
                    <div class="text-center space-y-2 mb-4">
                        <h3 class="text-headline-md font-headline-md text-primary uppercase">Reset Password</h3>
                        <p class="text-body-md font-body-md text-secondary">Please enter your new password.</p>
                    </div>
                    <div class="flex flex-col space-y-2">
                        <label class="text-label-sm font-label-sm uppercase text-secondary" for="reset-password">New Password</label>
                        <input class="w-full bg-surface-container text-body-md font-body-md text-primary border-none p-4 rounded-none focus:ring-2 focus:ring-primary focus:outline-none placeholder:text-secondary/50 transition-shadow"
                            id="reset-password" name="password" placeholder="••••••••" type="password" required />
                    </div>
                    <div class="flex flex-col space-y-2">
                        <label class="text-label-sm font-label-sm uppercase text-secondary" for="reset-confirm">Confirm Password</label>
                        <input class="w-full bg-surface-container text-body-md font-body-md text-primary border-none p-4 rounded-none focus:ring-2 focus:ring-primary focus:outline-none placeholder:text-secondary/50 transition-shadow"
                            id="reset-confirm" name="confirmPassword" placeholder="••••••••" type="password" required />
                    </div>
                    <button class="w-full bg-primary text-on-primary py-5 mt-4 text-label-md font-label-md uppercase tracking-widest hover:bg-primary/90 transition-colors flex justify-center items-center group" type="submit">
                        CONFIRM NEW PASSWORD
                        <span class="material-symbols-outlined ml-2 opacity-0 -translate-x-2 group-hover:opacity-100 group-hover:translate-x-0 transition-all text-[18px]">arrow_forward</span>
                    </button>
                    <div class="pt-4 text-center">
                        <a class="text-label-sm font-label-sm text-secondary hover:text-primary transition-colors uppercase tracking-widest" href="${pageContext.request.contextPath}/login">Back to Login</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <jsp:include page="/WEB-INF/include/footer.jsp" />
