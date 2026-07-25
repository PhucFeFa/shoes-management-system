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
                    <form
                        class="flex flex-col space-y-6 w-full transition-opacity duration-300 <c:if test='${showOTP}'>hidden opacity-0</c:if>"
                        id="form-forgot" action="${pageContext.request.contextPath}/forgot-password" method="POST">
                        <div class="text-center space-y-2 mb-2">
                            <h3 class="text-headline-md font-headline-md text-primary font-bold uppercase">Forgot
                                Password</h3>
                            <p class="text-body-md font-body-md text-secondary">Enter your email address to receive a
                                recovery code.</p>
                        </div>
                        <div class="flex flex-col space-y-2">
                            <label class="text-label-sm font-label-sm uppercase text-secondary ml-4"
                                for="forgot-email">Email Address</label>
                            <input
                                class="w-full bg-surface-container text-body-md font-body-md text-primary border border-transparent p-4 rounded-full focus:ring-2 focus:ring-primary focus:outline-none placeholder:text-secondary/50 transition-shadow shadow-sm hover:shadow-md"
                                id="forgot-email" name="email" placeholder="ENTER EMAIL" type="email" required />
                        </div>
                        <button
                            class="w-full bg-primary text-on-primary py-4 mt-2 rounded-full text-label-md font-label-md uppercase tracking-widest hover:bg-primary/90 transition-all shadow-md hover:shadow-lg flex justify-center items-center group font-bold"
                            type="submit">
                            SEND RECOVERY CODE
                            <span
                                class="material-symbols-outlined ml-2 opacity-0 -translate-x-2 group-hover:opacity-100 group-hover:translate-x-0 transition-all text-[18px]">arrow_forward</span>
                        </button>
                        <div class="pt-6 text-center">
                            <a class="inline-block text-label-sm font-label-sm text-secondary hover:text-primary transition-colors uppercase tracking-widest font-medium"
                                href="${pageContext.request.contextPath}/login">Back to Login</a>
                        </div>
                    </form>
                    <div class="flex-col space-y-10 w-full transition-opacity duration-300 <c:if test='${not showOTP}'>hidden opacity-0</c:if>"
                        id="form-otp">
                        <div class="text-center space-y-2">
                            <h3 class="text-headline-md font-headline-md text-primary font-bold uppercase">Verify
                                Identity</h3>
                            <p class="text-body-md font-body-md text-secondary">Enter the 6-digit code sent to your
                                email.</p>
                        </div>
                        <div class="flex justify-center gap-2 sm:gap-3">
                            <input
                                class="otp-box w-10 h-12 sm:w-12 sm:h-14 md:w-14 md:h-16 flex-shrink-0 bg-surface-container text-center text-headline-md font-headline-md text-primary border border-transparent rounded-2xl focus:ring-2 focus:ring-primary focus:bg-surface-container-high transition-all shadow-sm hover:shadow-md"
                                maxlength="1" type="text" autofocus />
                            <input
                                class="otp-box w-10 h-12 sm:w-12 sm:h-14 md:w-14 md:h-16 flex-shrink-0 bg-surface-container text-center text-headline-md font-headline-md text-primary border border-transparent rounded-2xl focus:ring-2 focus:ring-primary focus:bg-surface-container-high transition-all shadow-sm hover:shadow-md"
                                maxlength="1" type="text" />
                            <input
                                class="otp-box w-10 h-12 sm:w-12 sm:h-14 md:w-14 md:h-16 flex-shrink-0 bg-surface-container text-center text-headline-md font-headline-md text-primary border border-transparent rounded-2xl focus:ring-2 focus:ring-primary focus:bg-surface-container-high transition-all shadow-sm hover:shadow-md"
                                maxlength="1" type="text" />
                            <input
                                class="otp-box w-10 h-12 sm:w-12 sm:h-14 md:w-14 md:h-16 flex-shrink-0 bg-surface-container text-center text-headline-md font-headline-md text-primary border border-transparent rounded-2xl focus:ring-2 focus:ring-primary focus:bg-surface-container-high transition-all shadow-sm hover:shadow-md"
                                maxlength="1" type="text" />
                            <input
                                class="otp-box w-10 h-12 sm:w-12 sm:h-14 md:w-14 md:h-16 flex-shrink-0 bg-surface-container text-center text-headline-md font-headline-md text-primary border border-transparent rounded-2xl focus:ring-2 focus:ring-primary focus:bg-surface-container-high transition-all shadow-sm hover:shadow-md"
                                maxlength="1" type="text" />
                            <input
                                class="otp-box w-10 h-12 sm:w-12 sm:h-14 md:w-14 md:h-16 flex-shrink-0 bg-surface-container text-center text-headline-md font-headline-md text-primary border border-transparent rounded-2xl focus:ring-2 focus:ring-primary focus:bg-surface-container-high transition-all shadow-sm hover:shadow-md"
                                maxlength="1" type="text" />
                        </div>
                        <form action="${pageContext.request.contextPath}/verify-forgot-otp" method="POST"
                            id="verify-form">
                            <input type="hidden" name="otp" id="hidden-otp" value="" />
                            <div class="flex flex-col space-y-4 pt-4">
                                <button onclick="submitOTP()" type="button"
                                    class="w-full bg-primary text-on-primary py-5 rounded-full text-label-md font-label-md uppercase tracking-widest hover:bg-primary/90 transition-all shadow-md hover:shadow-lg font-bold">
                                    VERIFY CODE
                                </button>
                                <a href="${pageContext.request.contextPath}/forgot-password"
                                    class="text-center w-full bg-transparent text-secondary py-4 rounded-full text-label-sm font-label-sm uppercase tracking-widest hover:text-primary transition-colors font-medium">
                                    CANCEL
                                </a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <script>
            const otpBoxes = document.querySelectorAll('.otp-box');
            otpBoxes.forEach((box, index) => {
                box.addEventListener('input', (e) => {
                    if (e.target.value.length === 1 && index < otpBoxes.length - 1) {
                        otpBoxes[index + 1].focus();
                    }
                });
                box.addEventListener('keydown', (e) => {
                    if (e.key === 'Backspace' && e.target.value.length === 0 && index > 0) {
                        otpBoxes[index - 1].focus();
                    }
                });
            });

            function submitOTP() {
                let otpCode = '';
                otpBoxes.forEach(box => { otpCode += box.value; });
                if (otpCode.length === 6) {
                    document.getElementById('hidden-otp').value = otpCode;
                    document.getElementById('verify-form').submit();
                } else {
                    let errorDiv = document.getElementById('otp-error-msg');
                    if (!errorDiv) {
                        errorDiv = document.createElement('div');
                        errorDiv.id = 'otp-error-msg';
                        errorDiv.className = 'bg-error-container text-on-error-container border border-error p-4 mt-4 rounded-sm text-label-md font-label-md text-center';
                        document.getElementById('verify-form').insertBefore(errorDiv, document.getElementById('verify-form').firstChild);
                    }
                    errorDiv.innerText = 'Please enter a full 6-digit OTP code.';
                }
            }
        </script>
        <jsp:include page="/WEB-INF/include/footer.jsp" />