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
                            <c:if test="${not empty param.message}">
                                <div
                                    class="bg-surface-container-high text-primary border border-primary p-4 mb-6 rounded-sm text-label-md font-label-md">
                                    ${param.message}
                                </div>
                            </c:if>
                            <!-- Tab Toggles -->
                            <!-- LOGIN FORM -->
                            <form class="flex flex-col space-y-6 w-full opacity-100 transition-opacity duration-300"
                                id="form-login" action="${pageContext.request.contextPath}/login" method="POST">
                                <div class="flex flex-col space-y-2">
                                    <label class="text-label-sm font-label-sm uppercase text-secondary"
                                        for="login-email">Email Address</label>
                                    <input
                                        class="w-full bg-surface-container text-body-md font-body-md text-primary border-none p-4 rounded-none focus:ring-2 focus:ring-primary focus:outline-none placeholder:text-secondary/50 transition-shadow"
                                        id="login-email" name="email" placeholder="ENTER EMAIL" type="email" required />
                                </div>
                                <div class="flex flex-col space-y-2">
                                    <div class="flex justify-between items-center">
                                        <label class="text-label-sm font-label-sm uppercase text-secondary"
                                            for="login-password">Password</label>
                                        <a class="relative z-10 block text-label-sm font-label-sm text-secondary hover:text-primary underline underline-offset-4 transition-colors"
                                            href="${pageContext.request.contextPath}/forgot-password">FORGOT PASSWORD?</a>
                                    </div>
                                    <div class="relative">
                                        <input
                                            class="w-full bg-surface-container text-body-md font-body-md text-primary border-none p-4 rounded-none focus:ring-2 focus:ring-primary focus:outline-none placeholder:text-secondary/50 transition-shadow"
                                            id="login-password" name="password" placeholder="ENTER PASSWORD"
                                            type="password" required />
                                        <button
                                            class="absolute right-4 top-1/2 -translate-y-1/2 text-secondary hover:text-primary transition-colors"
                                            type="button">
                                            <span class="material-symbols-outlined text-[20px]">visibility_off</span>
                                        </button>
                                    </div>
                                </div>
                                <button
                                    class="w-full bg-primary text-on-primary py-5 mt-4 text-label-md font-label-md uppercase tracking-widest hover:bg-primary/90 transition-colors flex justify-center items-center group"
                                    type="submit">
                                    LOGIN
                                    <span
                                        class="material-symbols-outlined ml-2 opacity-0 -translate-x-2 group-hover:opacity-100 group-hover:translate-x-0 transition-all text-[18px]">arrow_forward</span>
                                </button>
                                <div class="pt-4 text-center relative z-10">
                                    <a class="inline-block text-label-sm font-label-sm text-secondary hover:text-primary transition-colors uppercase tracking-widest"
                                        href="${pageContext.request.contextPath}/register">Don't have an account? Create
                                        one</a>
                                </div>
                            </form>
                            <!-- REGISTER FORM (Hidden by default) -->
                            <!-- OTP VERIFICATION STATE (Hidden by default) -->
                            <div class="flex-col space-y-8 w-full hidden opacity-0 transition-opacity duration-300"
                                id="form-otp">
                                <div class="text-center space-y-2">
                                    <h3 class="text-headline-md font-headline-md text-primary">VERIFY IDENTITY</h3>
                                    <p class="text-body-md font-body-md text-secondary">Enter the 6-digit code sent to
                                        your device.</p>
                                </div>
                                <div class="flex justify-center space-x-2 sm:space-x-4">
                                    <input autofocus=""
                                        class="w-12 h-14 sm:w-14 sm:h-16 bg-surface-container text-center text-headline-md font-headline-md text-primary border-none rounded-none focus:ring-2 focus:ring-primary focus:bg-surface-container-high transition-colors"
                                        maxlength="1" type="text" />
                                    <input
                                        class="w-12 h-14 sm:w-14 sm:h-16 bg-surface-container text-center text-headline-md font-headline-md text-primary border-none rounded-none focus:ring-2 focus:ring-primary focus:bg-surface-container-high transition-colors"
                                        maxlength="1" type="text" />
                                    <input
                                        class="w-12 h-14 sm:w-14 sm:h-16 bg-surface-container text-center text-headline-md font-headline-md text-primary border-none rounded-none focus:ring-2 focus:ring-primary focus:bg-surface-container-high transition-colors"
                                        maxlength="1" type="text" />
                                    <input
                                        class="w-12 h-14 sm:w-14 sm:h-16 bg-surface-container text-center text-headline-md font-headline-md text-primary border-none rounded-none focus:ring-2 focus:ring-primary focus:bg-surface-container-high transition-colors"
                                        maxlength="1" type="text" />
                                    <input
                                        class="w-12 h-14 sm:w-14 sm:h-16 bg-surface-container text-center text-headline-md font-headline-md text-primary border-none rounded-none focus:ring-2 focus:ring-primary focus:bg-surface-container-high transition-colors"
                                        maxlength="1" type="text" />
                                    <input
                                        class="w-12 h-14 sm:w-14 sm:h-16 bg-surface-container text-center text-headline-md font-headline-md text-primary border-none rounded-none focus:ring-2 focus:ring-primary focus:bg-surface-container-high transition-colors"
                                        maxlength="1" type="text" />
                                </div>
                                <div class="flex flex-col space-y-4 pt-4">
                                    <button
                                        class="w-full bg-primary text-on-primary py-5 text-label-md font-label-md uppercase tracking-widest hover:bg-primary/90 transition-colors"
                                        type="button">
                                        VERIFY CODE
                                    </button>
                                    <button
                                        class="w-full bg-transparent text-secondary py-4 text-label-sm font-label-sm uppercase tracking-widest hover:text-primary transition-colors"
                                        onclick="cancelOTP()" type="button">
                                        CANCEL
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <jsp:include page="/WEB-INF/include/footer.jsp" />
                <script>
                    // Tab Switching Logic
                    function switchTab(tab) {
                        const loginForm = document.getElementById('form-login');
                        const registerForm = document.getElementById('form-register');
                        const otpForm = document.getElementById('form-otp');
                        const loginTab = document.getElementById('tab-login');
                        const registerTab = document.getElementById('tab-register');
                        const tabContainer = document.getElementById('tab-container');

                        // Reset UI states
                        otpForm.classList.add('hidden');
                        otpForm.classList.remove('opacity-100');
                        if (tabContainer) tabContainer.classList.remove('hidden');

                        if (tab === 'login') {
                            // Update Tabs
                            if (loginTab) {
                                loginTab.classList.add('text-primary', 'border-primary');
                                loginTab.classList.remove('text-secondary', 'border-transparent');
                            }
                            if (registerTab) {
                                registerTab.classList.remove('text-primary', 'border-primary');
                                registerTab.classList.add('text-secondary', 'border-transparent');
                            }

                            // Switch Forms
                            if (registerForm) registerForm.classList.remove('opacity-100');
                            setTimeout(() => {
                                if (registerForm) registerForm.classList.add('hidden');
                                loginForm.classList.remove('hidden');
                                setTimeout(() => loginForm.classList.add('opacity-100'), 50);
                            }, 300);

                        } else {
                            // Update Tabs
                            if (registerTab) {
                                registerTab.classList.add('text-primary', 'border-primary');
                                registerTab.classList.remove('text-secondary', 'border-transparent');
                            }
                            if (loginTab) {
                                loginTab.classList.remove('text-primary', 'border-primary');
                                loginTab.classList.add('text-secondary', 'border-transparent');
                            }

                            // Switch Forms
                            loginForm.classList.remove('opacity-100');
                            setTimeout(() => {
                                loginForm.classList.add('hidden');
                                if (registerForm) registerForm.classList.remove('hidden');
                                setTimeout(() => { if (registerForm) registerForm.classList.add('opacity-100'); }, 50);
                            }, 300);
                        }
                    }

                    // OTP Display Logic
                    function showOTP() {
                        const loginForm = document.getElementById('form-login');
                        const tabContainer = document.getElementById('tab-container');
                        const otpForm = document.getElementById('form-otp');

                        loginForm.classList.remove('opacity-100');
                        if (tabContainer) tabContainer.classList.add('hidden');

                        setTimeout(() => {
                            loginForm.classList.add('hidden');
                            otpForm.classList.remove('hidden');
                            otpForm.style.display = 'flex';
                            setTimeout(() => otpForm.classList.add('opacity-100'), 50);
                        }, 300);
                    }

                    function cancelOTP() {
                        switchTab('login');
                    }

                    // OTP Input Auto-advance logic
                    const otpInputs = document.querySelectorAll('#form-otp input');
                    otpInputs.forEach((input, index) => {
                        input.addEventListener('input', (e) => {
                            if (e.target.value.length === 1) {
                                if (index < otpInputs.length - 1) {
                                    otpInputs[index + 1].focus();
                                }
                            }
                        });
                        input.addEventListener('keydown', (e) => {
                            if (e.key === 'Backspace' && e.target.value.length === 0) {
                                if (index > 0) {
                                    otpInputs[index - 1].focus();
                                }
                            }
                        });
                    });
                </script>