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
                        <c:if test="${not empty param.message}">
                            <div
                                class="bg-surface-container-high text-primary border border-primary p-4 mb-8 rounded-2xl text-label-md font-label-md shadow-sm">
                                ${param.message}
                            </div>
                        </c:if>
                        <c:if test="${not empty sessionScope.successMessage}">
                            <div
                                class="bg-surface-container text-primary border border-outline-variant p-4 mb-8 rounded-2xl text-label-md font-label-md shadow-sm flex items-center gap-2">
                                <span class="material-symbols-outlined text-[18px]">check_circle</span>
                                ${sessionScope.successMessage}
                            </div>
                            <c:remove var="successMessage" scope="session"/>
                        </c:if>

                        <form class="flex flex-col space-y-6 w-full opacity-100 transition-opacity duration-300"
                            id="form-login" action="${pageContext.request.contextPath}/login" method="POST">
                            <div class="text-center space-y-2 mb-2">
                                <h3 class="text-headline-md font-headline-md text-primary font-bold uppercase">Welcome
                                    Back</h3>
                            </div>
                            <div class="flex flex-col space-y-2">
                                <label class="text-label-sm font-label-sm uppercase text-secondary ml-4"
                                    for="login-email">Email Address</label>
                                <input
                                    class="w-full bg-surface-container text-body-md font-body-md text-primary border border-transparent p-4 rounded-full focus:ring-2 focus:ring-primary focus:outline-none placeholder:text-secondary/50 transition-shadow shadow-sm hover:shadow-md"
                                    id="login-email" name="email" placeholder="ENTER EMAIL" type="email" required />
                            </div>
                            <div class="flex flex-col space-y-2">
                                <div class="flex justify-between items-center px-4">
                                    <label class="text-label-sm font-label-sm uppercase text-secondary"
                                        for="login-password">Password</label>
                                    <a class="relative z-10 block text-label-sm font-label-sm text-secondary hover:text-primary transition-colors font-medium"
                                        href="${pageContext.request.contextPath}/forgot-password">Forgot password?</a>
                                </div>
                                <div class="relative">
                                    <input
                                        class="w-full bg-surface-container text-body-md font-body-md text-primary border border-transparent p-4 rounded-full focus:ring-2 focus:ring-primary focus:outline-none placeholder:text-secondary/50 transition-shadow shadow-sm hover:shadow-md"
                                        id="login-password" name="password" placeholder="ENTER PASSWORD" type="password"
                                        required />
                                    <button
                                        class="absolute right-6 top-1/2 -translate-y-1/2 text-secondary hover:text-primary transition-colors"
                                        type="button">
                                        <span class="material-symbols-outlined text-[20px]">visibility_off</span>
                                    </button>
                                </div>
                            </div>
                            <button
                                class="w-full bg-primary text-on-primary py-4 mt-2 rounded-full text-label-md font-label-md uppercase tracking-widest hover:bg-primary/90 transition-all shadow-md hover:shadow-lg flex justify-center items-center group font-bold"
                                type="submit">
                                LOGIN
                                <span
                                    class="material-symbols-outlined ml-2 opacity-0 -translate-x-2 group-hover:opacity-100 group-hover:translate-x-0 transition-all text-[18px]">arrow_forward</span>
                            </button>
                            <div class="pt-6 text-center relative z-10">
                                <a class="inline-block text-label-sm font-label-sm text-secondary hover:text-primary transition-colors uppercase tracking-widest font-medium"
                                    href="${pageContext.request.contextPath}/register">Don't have an account? Create
                                    one</a>
                            </div>
                        </form>

                        <div class="flex-col space-y-10 w-full hidden opacity-0 transition-opacity duration-300"
                            id="form-otp">
                            <div class="text-center space-y-2">
                                <h3 class="text-headline-md font-headline-md text-primary font-bold">VERIFY IDENTITY
                                </h3>
                                <p class="text-body-md font-body-md text-secondary">Enter the 6-digit code sent to your
                                    device.</p>
                            </div>
                            <div class="flex justify-center gap-2 sm:gap-3">
                                <input autofocus
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
                                <input
                                    class="otp-box w-10 h-12 sm:w-12 sm:h-14 md:w-14 md:h-16 flex-shrink-0 bg-surface-container text-center text-headline-md font-headline-md text-primary border border-transparent rounded-2xl focus:ring-2 focus:ring-primary focus:bg-surface-container-high transition-all shadow-sm hover:shadow-md"
                                    maxlength="1" type="text" />
                            </div>
                            <div class="flex flex-col space-y-4 pt-4">
                                <button
                                    class="w-full bg-primary text-on-primary py-5 rounded-full text-label-md font-label-md uppercase tracking-widest hover:bg-primary/90 transition-all shadow-md hover:shadow-lg font-bold"
                                    type="button">
                                    VERIFY CODE
                                </button>
                                <button
                                    class="w-full bg-transparent text-secondary py-4 rounded-full text-label-sm font-label-sm uppercase tracking-widest hover:text-primary transition-colors font-medium"
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