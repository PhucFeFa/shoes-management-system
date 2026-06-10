<%-- Author: PhucLHCE191132 --%>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html class="light" lang="en">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>SOLE_LAB - Authentication</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&amp;display=swap" rel="stylesheet"/>
    <style>
        .material-symbols-outlined {
            font-family: 'Material Symbols Outlined';
            font-weight: normal;
            font-style: normal;
            font-size: 24px;
            line-height: 1;
            letter-spacing: normal;
            text-transform: none;
            display: inline-block;
            white-space: nowrap;
            word-wrap: normal;
            direction: ltr;
            -webkit-font-smoothing: antialiased;
        }
        /* Custom scrollbar for minimalist feel */
        ::-webkit-scrollbar { width: 6px; }
        ::-webkit-scrollbar-track { background: #f9f9f9; }
        ::-webkit-scrollbar-thumb { background: #dcdcdc; }
        ::-webkit-scrollbar-thumb:hover { background: #1a1c1c; }
        
        /* Hide number input spinners */
        input[type="number"]::-webkit-inner-spin-button,
        input[type="number"]::-webkit-outer-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }
    </style>
    <script id="tailwind-config">
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    "colors": {
                        "surface-dim": "#dadada",
                        "surface-container-high": "#e8e8e8",
                        "surface-container": "#eeeeee",
                        "on-surface-variant": "#444748",
                        "background": "#f9f9f9",
                        "secondary": "#5d5f5f",
                        "on-tertiary": "#ffffff",
                        "surface-container-lowest": "#ffffff",
                        "secondary-container": "#e2e3e2",
                        "on-surface": "#1a1c1c",
                        "on-tertiary-fixed": "#1b1b1b",
                        "primary": "#000000",
                        "tertiary-container": "#1b1b1b",
                        "error": "#ba1a1a",
                        "primary-container": "#1b1b1b",
                        "surface-tint": "#5e5e5e",
                        "on-primary-container": "#848484",
                        "secondary-fixed": "#e2e3e2",
                        "on-tertiary-container": "#848484",
                        "on-error": "#ffffff",
                        "inverse-on-surface": "#f0f1f1",
                        "surface-bright": "#f9f9f9",
                        "surface-variant": "#e2e2e2",
                        "on-primary-fixed-variant": "#474747",
                        "on-background": "#1a1c1c",
                        "primary-fixed-dim": "#c6c6c6",
                        "on-secondary-fixed-variant": "#454747",
                        "inverse-primary": "#c6c6c6",
                        "surface-container-highest": "#e2e2e2",
                        "error-container": "#ffdad6",
                        "secondary-fixed-dim": "#c6c7c6",
                        "tertiary-fixed": "#e2e2e2",
                        "surface": "#f9f9f9",
                        "on-error-container": "#93000a",
                        "inverse-surface": "#2f3131",
                        "on-secondary-container": "#636565",
                        "surface-container-low": "#f3f3f4",
                        "outline-variant": "#cfc4c5",
                        "on-primary-fixed": "#1b1b1b",
                        "on-tertiary-fixed-variant": "#474747",
                        "on-secondary": "#ffffff",
                        "on-primary": "#ffffff",
                        "on-secondary-fixed": "#1a1c1c",
                        "primary-fixed": "#e2e2e2",
                        "tertiary": "#000000",
                        "outline": "#7e7576",
                        "tertiary-fixed-dim": "#c6c6c6"
                    },
                    "borderRadius": {
                        "DEFAULT": "0.25rem",
                        "lg": "0.5rem",
                        "xl": "0.75rem",
                        "full": "9999px"
                    },
                    "spacing": {
                        "margin-desktop": "64px",
                        "margin-mobile": "20px",
                        "base": "8px",
                        "gutter": "24px",
                        "margin-tablet": "32px",
                        "container-max": "1440px"
                    },
                    "fontFamily": {
                        "label-sm": ["Inter"],
                        "display-lg-mobile": ["Inter"],
                        "headline-lg": ["Inter"],
                        "headline-md": ["Inter"],
                        "display-lg": ["Inter"],
                        "body-lg": ["Inter"],
                        "body-md": ["Inter"],
                        "label-md": ["Inter"]
                    },
                    "fontSize": {
                        "label-sm": ["12px", { "lineHeight": "1.0", "letterSpacing": "0", "fontWeight": "500" }],
                        "display-lg-mobile": ["40px", { "lineHeight": "1.2", "letterSpacing": "-0.02em", "fontWeight": "800" }],
                        "headline-lg": ["32px", { "lineHeight": "1.2", "letterSpacing": "-0.02em", "fontWeight": "700" }],
                        "headline-md": ["24px", { "lineHeight": "1.3", "letterSpacing": "-0.01em", "fontWeight": "600" }],
                        "display-lg": ["72px", { "lineHeight": "1.1", "letterSpacing": "-0.04em", "fontWeight": "800" }],
                        "body-lg": ["18px", { "lineHeight": "1.6", "letterSpacing": "0", "fontWeight": "400" }],
                        "body-md": ["16px", { "lineHeight": "1.5", "letterSpacing": "0", "fontWeight": "400" }],
                        "label-md": ["14px", { "lineHeight": "1.0", "letterSpacing": "0.05em", "fontWeight": "600" }]
                    }
                }
            }
        }
    </script>
</head>
<body class="bg-background text-on-background antialiased selection:bg-primary selection:text-on-primary">
<div class="min-h-screen flex flex-col md:flex-row w-full max-w-container-max mx-auto">
    <!-- Left Side: Lifestyle Image -->
    <div class="hidden md:flex md:w-1/2 lg:w-7/12 relative bg-surface-container-high overflow-hidden" style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuAndYwBN84UeC0US17gsvQ_p5Py-jrMUiR7JRAgWPIUD6t01B0qPabS8cpG5eiia3RL9dcrYliTpv7TQXnyIbeo1lU3gKC3I4ylRN0rT-FPxtznwBowO8uUflsyiJ0olMzxSrMtim-Q9vrhlqIuD7aaYVYpeDhx1ZkWJmkfK724EB1M_DZqy-_N7fb5BnIVwe66-q5eIclOIm-qPQHvsxyYxcEx6JIjV3PENNEdGNkFGk8s5w012wnXMd7hGEZ2Wh9t0kJPRJiXwwE'); background-size: cover; background-position: center;">
        <div class="absolute inset-0 bg-gradient-to-t from-black/40 to-transparent"></div>
    </div>
    
    <!-- Right Side: Form Area -->
    <div class="w-full md:w-1/2 lg:w-5/12 flex flex-col min-h-screen relative bg-surface-container-lowest">
        <!-- Minimal Header -->
        <div class="w-full pt-12 pb-8 flex justify-center items-center">
            <a class="text-headline-md font-headline-md font-extrabold tracking-tighter text-primary" href="${pageContext.request.contextPath}/home">SOLE_LAB</a>
        </div>
        
        <!-- Form Canvas -->
        <div class="flex-1 flex flex-col justify-center px-8 sm:px-12 md:px-16 lg:px-24 pb-24">
            
            <c:if test="${not empty error}">
                <div class="bg-error-container text-on-error-container border border-error p-4 mb-6 rounded-sm text-label-md font-label-md">
                    ${error}
                </div>
            </c:if>

            <!-- Tab Toggles -->
            <div class="flex items-center space-x-8 mb-12 border-b border-outline-variant" id="tab-container">
                <button class="pb-4 text-label-md font-label-md uppercase tracking-widest text-primary border-b-2 border-primary transition-all" id="tab-login" onclick="switchTab('login')">Log In</button>
                <button class="pb-4 text-label-md font-label-md uppercase tracking-widest text-secondary hover:text-primary transition-colors border-b-2 border-transparent" id="tab-register" onclick="switchTab('register')">Register</button>
            </div>
            
            <!-- LOGIN FORM -->
            <form class="flex flex-col space-y-6 w-full opacity-100 transition-opacity duration-300" id="form-login" action="${pageContext.request.contextPath}/login" method="POST">
                <div class="flex flex-col space-y-2">
                    <label class="text-label-sm font-label-sm uppercase text-secondary" for="login-email">Email Address</label>
                    <input class="w-full bg-surface-container text-body-md font-body-md text-primary border-none p-4 rounded-none focus:ring-2 focus:ring-primary focus:outline-none placeholder:text-secondary/50 transition-shadow" id="login-email" name="email" placeholder="ENTER EMAIL" type="email" required/>
                </div>
                <div class="flex flex-col space-y-2">
                    <div class="flex justify-between items-center">
                        <label class="text-label-sm font-label-sm uppercase text-secondary" for="login-password">Password</label>
                        <a class="text-label-sm font-label-sm text-secondary hover:text-primary underline underline-offset-4 transition-colors" href="#" onclick="showOTP()">FORGOT? (TEST OTP)</a>
                    </div>
                    <div class="relative">
                        <input class="w-full bg-surface-container text-body-md font-body-md text-primary border-none p-4 rounded-none focus:ring-2 focus:ring-primary focus:outline-none placeholder:text-secondary/50 transition-shadow" id="login-password" name="password" placeholder="ENTER PASSWORD" type="password" required/>
                        <button class="absolute right-4 top-1/2 -translate-y-1/2 text-secondary hover:text-primary transition-colors" type="button">
                            <span class="material-symbols-outlined text-[20px]">visibility_off</span>
                        </button>
                    </div>
                </div>
                <button class="w-full bg-primary text-on-primary py-5 mt-4 text-label-md font-label-md uppercase tracking-widest hover:bg-primary/90 transition-colors flex justify-center items-center group" type="submit">
                    SECURE LOGIN
                    <span class="material-symbols-outlined ml-2 opacity-0 -translate-x-2 group-hover:opacity-100 group-hover:translate-x-0 transition-all text-[18px]">arrow_forward</span>
                </button>
            </form>
            
            <!-- REGISTER FORM (Hidden by default) -->
            <form class="flex flex-col space-y-6 w-full hidden opacity-0 transition-opacity duration-300" id="form-register">
                <div class="flex flex-col space-y-2">
                    <label class="text-label-sm font-label-sm uppercase text-secondary" for="reg-name">Full Name</label>
                    <input class="w-full bg-surface-container text-body-md font-body-md text-primary border-none p-4 rounded-none focus:ring-2 focus:ring-primary focus:outline-none placeholder:text-secondary/50 transition-shadow" id="reg-name" name="fullName" placeholder="JANE DOE" type="text"/>
                </div>
                <div class="flex flex-col space-y-2">
                    <label class="text-label-sm font-label-sm uppercase text-secondary" for="reg-email">Email Address</label>
                    <input class="w-full bg-surface-container text-body-md font-body-md text-primary border-none p-4 rounded-none focus:ring-2 focus:ring-primary focus:outline-none placeholder:text-secondary/50 transition-shadow" id="reg-email" name="email" placeholder="ENTER EMAIL" type="email"/>
                </div>
                <div class="flex flex-col space-y-2">
                    <label class="text-label-sm font-label-sm uppercase text-secondary" for="reg-phone">Phone (Optional)</label>
                    <input class="w-full bg-surface-container text-body-md font-body-md text-primary border-none p-4 rounded-none focus:ring-2 focus:ring-primary focus:outline-none placeholder:text-secondary/50 transition-shadow" id="reg-phone" name="phone" placeholder="+1 (555) 000-0000" type="tel"/>
                </div>
                <div class="flex flex-col space-y-2">
                    <label class="text-label-sm font-label-sm uppercase text-secondary" for="reg-password">Create Password</label>
                    <div class="relative">
                        <input class="w-full bg-surface-container text-body-md font-body-md text-primary border-none p-4 rounded-none focus:ring-2 focus:ring-primary focus:outline-none placeholder:text-secondary/50 transition-shadow" id="reg-password" name="password" placeholder="MIN 8 CHARACTERS" type="password"/>
                    </div>
                </div>
                <button class="w-full bg-primary text-on-primary py-5 mt-4 text-label-md font-label-md uppercase tracking-widest hover:bg-primary/90 transition-colors flex justify-center items-center group" type="submit">
                    CREATE ACCOUNT
                    <span class="material-symbols-outlined ml-2 opacity-0 -translate-x-2 group-hover:opacity-100 group-hover:translate-x-0 transition-all text-[18px]">person_add</span>
                </button>
            </form>
            
            <!-- OTP VERIFICATION STATE (Hidden by default) -->
            <div class="flex-col space-y-8 w-full hidden opacity-0 transition-opacity duration-300" id="form-otp">
                <div class="text-center space-y-2">
                    <h3 class="text-headline-md font-headline-md text-primary">VERIFY IDENTITY</h3>
                    <p class="text-body-md font-body-md text-secondary">Enter the 6-digit code sent to your device.</p>
                </div>
                <div class="flex justify-center space-x-2 sm:space-x-4">
                    <input autofocus="" class="w-12 h-14 sm:w-14 sm:h-16 bg-surface-container text-center text-headline-md font-headline-md text-primary border-none rounded-none focus:ring-2 focus:ring-primary focus:bg-surface-container-high transition-colors" maxlength="1" type="text"/>
                    <input class="w-12 h-14 sm:w-14 sm:h-16 bg-surface-container text-center text-headline-md font-headline-md text-primary border-none rounded-none focus:ring-2 focus:ring-primary focus:bg-surface-container-high transition-colors" maxlength="1" type="text"/>
                    <input class="w-12 h-14 sm:w-14 sm:h-16 bg-surface-container text-center text-headline-md font-headline-md text-primary border-none rounded-none focus:ring-2 focus:ring-primary focus:bg-surface-container-high transition-colors" maxlength="1" type="text"/>
                    <input class="w-12 h-14 sm:w-14 sm:h-16 bg-surface-container text-center text-headline-md font-headline-md text-primary border-none rounded-none focus:ring-2 focus:ring-primary focus:bg-surface-container-high transition-colors" maxlength="1" type="text"/>
                    <input class="w-12 h-14 sm:w-14 sm:h-16 bg-surface-container text-center text-headline-md font-headline-md text-primary border-none rounded-none focus:ring-2 focus:ring-primary focus:bg-surface-container-high transition-colors" maxlength="1" type="text"/>
                    <input class="w-12 h-14 sm:w-14 sm:h-16 bg-surface-container text-center text-headline-md font-headline-md text-primary border-none rounded-none focus:ring-2 focus:ring-primary focus:bg-surface-container-high transition-colors" maxlength="1" type="text"/>
                </div>
                <div class="flex flex-col space-y-4 pt-4">
                    <button class="w-full bg-primary text-on-primary py-5 text-label-md font-label-md uppercase tracking-widest hover:bg-primary/90 transition-colors" type="button">VERIFY CODE</button>
                    <button class="w-full bg-transparent text-secondary py-4 text-label-sm font-label-sm uppercase tracking-widest hover:text-primary transition-colors" onclick="cancelOTP()" type="button">CANCEL</button>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function switchTab(tab) {
        const loginForm = document.getElementById('form-login');
        const registerForm = document.getElementById('form-register');
        const otpForm = document.getElementById('form-otp');
        const loginTab = document.getElementById('tab-login');
        const registerTab = document.getElementById('tab-register');
        const tabContainer = document.getElementById('tab-container');

        otpForm.classList.add('hidden');
        otpForm.classList.remove('opacity-100');
        tabContainer.classList.remove('hidden');

        if (tab === 'login') {
            loginTab.classList.add('text-primary', 'border-primary');
            loginTab.classList.remove('text-secondary', 'border-transparent');
            registerTab.classList.remove('text-primary', 'border-primary');
            registerTab.classList.add('text-secondary', 'border-transparent');

            registerForm.classList.remove('opacity-100');
            setTimeout(() => {
                registerForm.classList.add('hidden');
                loginForm.classList.remove('hidden');
                setTimeout(() => loginForm.classList.add('opacity-100'), 50);
            }, 300);
        } else {
            registerTab.classList.add('text-primary', 'border-primary');
            registerTab.classList.remove('text-secondary', 'border-transparent');
            loginTab.classList.remove('text-primary', 'border-primary');
            loginTab.classList.add('text-secondary', 'border-transparent');

            loginForm.classList.remove('opacity-100');
            setTimeout(() => {
                loginForm.classList.add('hidden');
                registerForm.classList.remove('hidden');
                setTimeout(() => registerForm.classList.add('opacity-100'), 50);
            }, 300);
        }
    }

    function showOTP() {
        const loginForm = document.getElementById('form-login');
        const tabContainer = document.getElementById('tab-container');
        const otpForm = document.getElementById('form-otp');

        loginForm.classList.remove('opacity-100');
        tabContainer.classList.add('hidden');
        
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
            if (e.target.value.length === 1 && index < otpInputs.length - 1) {
                otpInputs[index + 1].focus();
            }
        });
        input.addEventListener('keydown', (e) => {
            if (e.key === 'Backspace' && e.target.value.length === 0 && index > 0) {
                otpInputs[index - 1].focus();
            }
        });
    });
</script>
</body>
</html>
