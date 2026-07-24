<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <jsp:include page="/WEB-INF/include/header.jsp" />
        <div class="min-h-screen py-12 px-4 flex items-center justify-center w-full">
            <div
                class="w-full max-w-5xl md:h-[750px] flex flex-col md:flex-row bg-surface-container-lowest rounded-[2rem] shadow-2xl overflow-hidden">
                <div class="hidden md:flex md:w-7/12 lg:w-3/5 relative bg-surface-container-high"
                    style="background-image: url('${pageContext.request.contextPath}/assets/poster.png'); background-size: cover; background-position: left center; background-repeat: no-repeat;">
                    <div class="absolute inset-0 bg-gradient-to-t from-black/20 to-transparent"></div>
                </div>
                <div
                    class="w-full md:w-5/12 lg:w-2/5 flex flex-col justify-start pt-12 md:pt-16 lg:pt-20 px-8 sm:px-12 lg:px-12 pb-8 overflow-y-auto relative scrollbar-hide">
                    <c:if test="${not empty error}">
                        <div
                            class="bg-error-container text-on-error-container border border-error p-4 mb-8 rounded-2xl text-label-md font-label-md shadow-sm">
                            ${error}
                        </div>
                    </c:if>

                    <form class="flex flex-col space-y-6 w-full opacity-100 transition-opacity duration-300"
                        id="form-reset" action="${pageContext.request.contextPath}/reset-password" method="POST">
                        <div class="text-center space-y-2 mb-2">
                            <h3 class="text-headline-md font-headline-md text-primary font-bold uppercase">Reset
                                Password</h3>
                            <p class="text-body-md font-body-md text-secondary">Please enter your new password.</p>
                        </div>
                        <div class="flex flex-col space-y-2">
                            <label class="text-label-sm font-label-sm uppercase text-secondary ml-4"
                                for="reset-password">New Password</label>
                            <input
                                class="w-full bg-surface-container text-body-md font-body-md text-primary border border-transparent p-4 rounded-full focus:ring-2 focus:ring-primary focus:outline-none placeholder:text-secondary/50 transition-shadow shadow-sm hover:shadow-md"
                                id="reset-password" name="password" placeholder="••••••••" type="password" required />
                        </div>
                        <div class="flex flex-col space-y-2">
                            <label class="text-label-sm font-label-sm uppercase text-secondary ml-4"
                                for="reset-confirm">Confirm Password</label>
                            <input
                                class="w-full bg-surface-container text-body-md font-body-md text-primary border border-transparent p-4 rounded-full focus:ring-2 focus:ring-primary focus:outline-none placeholder:text-secondary/50 transition-shadow shadow-sm hover:shadow-md"
                                id="reset-confirm" name="confirmPassword" placeholder="••••••••" type="password"
                                required />
                        </div>
                        <button
                            class="w-full bg-primary text-on-primary py-4 mt-2 rounded-full text-label-md font-label-md uppercase tracking-widest hover:bg-primary/90 transition-all shadow-md hover:shadow-lg flex justify-center items-center group font-bold"
                            type="submit">
                            CONFIRM NEW PASSWORD
                            <span
                                class="material-symbols-outlined ml-2 opacity-0 -translate-x-2 group-hover:opacity-100 group-hover:translate-x-0 transition-all text-[18px]">arrow_forward</span>
                        </button>
                        <div class="pt-6 text-center">
                            <a class="inline-block text-label-sm font-label-sm text-secondary hover:text-primary transition-colors uppercase tracking-widest font-medium"
                                href="${pageContext.request.contextPath}/login">Back to Login</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <jsp:include page="/WEB-INF/include/footer.jsp" />