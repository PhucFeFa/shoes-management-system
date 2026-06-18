<%-- Author: PhucLHCE191132 --%>
    <%@ page contentType="text/html" pageEncoding="UTF-8" %>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/include/header.jsp" />
<!-- Transactional Page Layout: Suppressed Main Nav, Split Screen Design -->
<div class="pt-16 min-h-screen flex flex-col md:flex-row w-full max-w-container-max mx-auto">
                    <!-- Left Side: Lifestyle Image (Hidden on Mobile) -->
                    <div class="hidden md:flex md:w-1/2 lg:w-7/12 relative bg-surface-container-high overflow-hidden"
                        data-alt="A striking, high-contrast lifestyle photograph of a futuristic performance sneaker resting on a brutalist concrete block. The lighting is harsh and directional, creating deep shadows that emphasize the shoe's complex textures and aerodynamic silhouette. The color palette is strictly monochromatic, dominated by deep blacks, crisp whites, and cool greys. The aesthetic is extremely minimalist, clinical, and engineered, capturing a sense of raw speed and technical precision."
                        style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuAndYwBN84UeC0US17gsvQ_p5Py-jrMUiR7JRAgWPIUD6t01B0qPabS8cpG5eiia3RL9dcrYliTpv7TQXnyIbeo1lU3gKC3I4ylRN0rT-FPxtznwBowO8uUflsyiJ0olMzxSrMtim-Q9vrhlqIuD7aaYVYpeDhx1ZkWJmkfK724EB1M_DZqy-_N7fb5BnIVwe66-q5eIclOIm-qPQHvsxyYxcEx6JIjV3PENNEdGNkFGk8s5w012wnXMd7hGEZ2Wh9t0kJPRJiXwwE'); background-size: cover; background-position: center;">
                        <!-- Overlay for contrast -->
                        <div class="absolute inset-0 bg-gradient-to-t from-black/40 to-transparent"></div>
                    </div>
                    <!-- Right Side: Form Area -->
                    <div
                        class="w-full md:w-1/2 lg:w-5/12 flex flex-col min-h-screen relative bg-surface-container-lowest">
                        <!-- Minimal Header -->
                        <div class="w-full pt-12 pb-8 flex justify-center items-center">
                            <a class="text-headline-md font-headline-md font-extrabold tracking-tighter text-primary"
                                href="${pageContext.request.contextPath}/home">Adidis</a>
                        </div>
                        <!-- Form Canvas -->
                        <div class="flex-1 flex flex-col justify-center px-8 sm:px-12 md:px-16 lg:px-24 pb-24">
                            <c:if test="${not empty error}">
                                <div
                                    class="bg-error-container text-on-error-container border border-error p-4 mb-6 rounded-sm text-label-md font-label-md">
                                    ${error}
                                </div>
                            </c:if>

                            <!-- REGISTER FORM -->
                            <form
                                class="flex flex-col space-y-6 w-full transition-opacity duration-300 <c:if test='${showOTP}'>hidden opacity-0</c:if>"
                                id="form-register" action="${pageContext.request.contextPath}/register" method="POST">
                                <div class="flex flex-col space-y-2">
                                    <label class="text-label-sm font-label-sm uppercase text-secondary"
                                        for="register-fullname">Full Name</label>
                                    <input
                                        class="w-full bg-surface-container text-body-md font-body-md text-primary border-none p-4 rounded-none focus:ring-2 focus:ring-primary focus:outline-none placeholder:text-secondary/50 transition-shadow"
                                        id="register-fullname" name="fullName" placeholder="ENTER FULL NAME" type="text"
                                        required />
                                </div>
                                <div class="flex flex-col space-y-2">
                                    <label class="text-label-sm font-label-sm uppercase text-secondary"
                                        for="register-email">Email Address</label>
                                    <input
                                        class="w-full bg-surface-container text-body-md font-body-md text-primary border-none p-4 rounded-none focus:ring-2 focus:ring-primary focus:outline-none placeholder:text-secondary/50 transition-shadow"
                                        id="register-email" name="email" placeholder="ENTER EMAIL" type="email"
                                        required />
                                </div>
                                <div class="flex flex-col space-y-2">
                                    <label class="text-label-sm font-label-sm uppercase text-secondary"
                                        for="register-password">Password</label>
                                    <input
                                        class="w-full bg-surface-container text-body-md font-body-md text-primary border-none p-4 rounded-none focus:ring-2 focus:ring-primary focus:outline-none placeholder:text-secondary/50 transition-shadow"
                                        id="register-password" name="password" placeholder="••••••••" type="password"
                                        required />
                                </div>
                                <div class="flex flex-col space-y-2">
                                    <label class="text-label-sm font-label-sm uppercase text-secondary"
                                        for="register-confirm">Confirm Password</label>
                                    <input
                                        class="w-full bg-surface-container text-body-md font-body-md text-primary border-none p-4 rounded-none focus:ring-2 focus:ring-primary focus:outline-none placeholder:text-secondary/50 transition-shadow"
                                        id="register-confirm" name="confirmPassword" placeholder="••••••••"
                                        type="password" required />
                                </div>
                                <button
                                    class="w-full bg-primary text-on-primary py-5 mt-4 text-label-md font-label-md uppercase tracking-widest hover:bg-primary/90 transition-colors flex justify-center items-center group"
                                    type="submit">
                                    CREATE ACCOUNT
                                    <span
                                        class="material-symbols-outlined ml-2 opacity-0 -translate-x-2 group-hover:opacity-100 group-hover:translate-x-0 transition-all text-[18px]">arrow_forward</span>
                                </button>
                                <div class="pt-4 text-center"><a
                                        class="text-label-sm font-label-sm text-secondary hover:text-primary transition-colors uppercase tracking-widest"
                                        href="${pageContext.request.contextPath}/login">Already have an account? Log
                                        in</a></div>
                            </form>

                            <!-- OTP VERIFICATION STATE -->
                            <div class="flex-col space-y-8 w-full transition-opacity duration-300 <c:if test='${not showOTP}'>hidden opacity-0</c:if>"
                                id="form-otp">
                                <div class="text-center space-y-2">
                                    <h3 class="text-headline-md font-headline-md text-primary">VERIFY IDENTITY</h3>
                                    <p class="text-body-md font-body-md text-secondary">Enter the 6-digit code sent to
                                        your email.</p>
                                </div>
                                <div class="flex justify-center space-x-2 sm:space-x-4">
                                    <input
                                        class="otp-box w-12 h-14 sm:w-14 sm:h-16 bg-surface-container text-center text-headline-md font-headline-md text-primary border-none rounded-none focus:ring-2 focus:ring-primary focus:bg-surface-container-high transition-colors"
                                        maxlength="1" type="text" autofocus />
                                    <input
                                        class="otp-box w-12 h-14 sm:w-14 sm:h-16 bg-surface-container text-center text-headline-md font-headline-md text-primary border-none rounded-none focus:ring-2 focus:ring-primary focus:bg-surface-container-high transition-colors"
                                        maxlength="1" type="text" />
                                    <input
                                        class="otp-box w-12 h-14 sm:w-14 sm:h-16 bg-surface-container text-center text-headline-md font-headline-md text-primary border-none rounded-none focus:ring-2 focus:ring-primary focus:bg-surface-container-high transition-colors"
                                        maxlength="1" type="text" />
                                    <input
                                        class="otp-box w-12 h-14 sm:w-14 sm:h-16 bg-surface-container text-center text-headline-md font-headline-md text-primary border-none rounded-none focus:ring-2 focus:ring-primary focus:bg-surface-container-high transition-colors"
                                        maxlength="1" type="text" />
                                    <input
                                        class="otp-box w-12 h-14 sm:w-14 sm:h-16 bg-surface-container text-center text-headline-md font-headline-md text-primary border-none rounded-none focus:ring-2 focus:ring-primary focus:bg-surface-container-high transition-colors"
                                        maxlength="1" type="text" />
                                    <input
                                        class="otp-box w-12 h-14 sm:w-14 sm:h-16 bg-surface-container text-center text-headline-md font-headline-md text-primary border-none rounded-none focus:ring-2 focus:ring-primary focus:bg-surface-container-high transition-colors"
                                        maxlength="1" type="text" />
                                </div>
                                <form action="${pageContext.request.contextPath}/verify-otp" method="POST"
                                    id="verify-form">
                                    <input type="hidden" name="otp" id="hidden-otp" value="" />
                                    <div class="flex flex-col space-y-4 pt-4">
                                        <button onclick="submitOTP()" type="button"
                                            class="w-full bg-primary text-on-primary py-5 text-label-md font-label-md uppercase tracking-widest hover:bg-primary/90 transition-colors">
                                            VERIFY CODE
                                        </button>
                                        <a href="${pageContext.request.contextPath}/register"
                                            class="text-center w-full bg-transparent text-secondary py-4 text-label-sm font-label-sm uppercase tracking-widest hover:text-primary transition-colors">
                                            CANCEL
                                        </a>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <jsp:include page="/WEB-INF/include/footer.jsp" />
                <script>
                    // OTP Box Navigation Logic
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