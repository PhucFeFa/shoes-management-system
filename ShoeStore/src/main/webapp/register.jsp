<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>SOLE_LAB | REGISTER</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&amp;display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
    <style>
        body {
            background-color: #f9f9f9;
            color: #1a1c1c;
            -webkit-font-smoothing: antialiased;
        }
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        }
        .input-focus-effect:focus {
            outline: none;
            border-bottom: 2px solid #000000;
        }
    </style>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        "surface": "#f9f9f9",
                        "surface-container": "#eeeeee",
                        "primary": "#000000",
                        "on-primary": "#ffffff",
                        "secondary": "#5d5f5f",
                        "outline-variant": "#cfc4c5",
                        "error-container": "#ffdad6",
                        "error": "#ba1a1a",
                        "on-error-container": "#93000a"
                    }
                }
            }
        };
    </script>
</head>
<body class="overflow-x-hidden">

<header class="fixed top-0 w-full z-50 bg-surface/80 backdrop-blur-xl transition-opacity duration-200">
    <div class="flex justify-between items-center h-20 px-8 max-w-[1440px] mx-auto">
        <div class="text-4xl font-black tracking-tighter text-primary">SOLE_LAB</div>
        <div class="flex items-center gap-6">
            <a href="${pageContext.request.contextPath}/login" class="font-semibold text-sm uppercase tracking-wider text-secondary hover:text-primary transition-colors">LOGIN</a>
        </div>
    </div>
</header>

<main class="min-h-screen pt-20 flex flex-col md:flex-row">
    <!-- Left Side: Cinematic Brand Image -->
    <section class="hidden md:block md:w-1/2 h-[calc(100vh-80px)] overflow-hidden sticky top-20 bg-surface-container relative">
        <img alt="Technical footwear design" class="w-full h-full object-cover grayscale brightness-95" src="https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=2070&auto=format&fit=crop"/>
        <div class="absolute bottom-12 left-12 max-w-sm">
            <span class="bg-primary text-on-primary text-xs px-2 py-1 mb-4 inline-block tracking-widest uppercase">New Prototype</span>
            <h1 class="text-6xl text-primary font-black tracking-tighter leading-none mb-4">ENGINEERED<br/>FOR SPEED.</h1>
            <p class="text-base text-secondary max-w-xs">Join the SOLE_LAB community and get early access to experimental drops and lab-only releases.</p>
        </div>
    </section>

    <!-- Right Side: Registration Form -->
    <section class="w-full md:w-1/2 flex items-center justify-center py-24 px-8 bg-surface">
        <div class="w-full max-w-md relative">
            
            <c:if test="${not empty error}">
                <div class="bg-error-container text-on-error-container border border-error p-4 mb-6 rounded-sm text-sm font-semibold">
                    ${error}
                </div>
            </c:if>

            <div class="mb-12">
                <h2 class="text-3xl font-bold text-primary mb-2">CREATE ACCOUNT</h2>
                <p class="text-base text-secondary">Start your performance journey today.</p>
            </div>

            <!-- REGISTRATION FORM -->
            <form id="form-register" class="space-y-8 transition-opacity duration-300 <c:if test='${showOTP}'>hidden opacity-0</c:if>" action="${pageContext.request.contextPath}/register" method="POST">
                <div class="group">
                    <label class="block text-xs text-secondary uppercase tracking-widest mb-2 transition-colors group-focus-within:text-primary">Full Name</label>
                    <input name="fullName" required class="w-full bg-surface-container border-0 border-b border-outline-variant p-4 text-base transition-all duration-300 input-focus-effect focus:ring-0" placeholder="ALEX MERCER" type="text"/>
                </div>
                <div class="group">
                    <label class="block text-xs text-secondary uppercase tracking-widest mb-2 transition-colors group-focus-within:text-primary">Email Address</label>
                    <input name="email" required class="w-full bg-surface-container border-0 border-b border-outline-variant p-4 text-base transition-all duration-300 input-focus-effect focus:ring-0" placeholder="NAME@DOMAIN.COM" type="email"/>
                </div>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div class="group">
                        <label class="block text-xs text-secondary uppercase tracking-widest mb-2 transition-colors group-focus-within:text-primary">Password</label>
                        <input name="password" required class="w-full bg-surface-container border-0 border-b border-outline-variant p-4 text-base transition-all duration-300 input-focus-effect focus:ring-0" placeholder="••••••••" type="password"/>
                    </div>
                    <div class="group">
                        <label class="block text-xs text-secondary uppercase tracking-widest mb-2 transition-colors group-focus-within:text-primary">Confirm</label>
                        <input name="confirmPassword" required class="w-full bg-surface-container border-0 border-b border-outline-variant p-4 text-base transition-all duration-300 input-focus-effect focus:ring-0" placeholder="••••••••" type="password"/>
                    </div>
                </div>
                <button type="submit" class="w-full bg-primary text-on-primary py-5 text-sm uppercase tracking-widest hover:opacity-90 transition-all active:scale-[0.99] flex items-center justify-center gap-2 group">
                    Create Account
                    <span class="material-symbols-outlined text-[18px] group-hover:translate-x-1 transition-transform">arrow_forward</span>
                </button>
            </form>

            <!-- OTP VERIFICATION FORM -->
            <div id="form-otp" class="flex-col space-y-8 w-full transition-opacity duration-300 <c:if test='${not showOTP}'>hidden opacity-0</c:if>">
                <div class="text-center space-y-2">
                    <h3 class="text-3xl font-bold text-primary">VERIFY EMAIL</h3>
                    <p class="text-base text-secondary">Enter the 6-digit code sent to your email.</p>
                </div>
                <div class="flex justify-center space-x-2 sm:space-x-4">
                    <input class="otp-box w-12 h-14 bg-surface-container text-center text-3xl font-bold text-primary border-none focus:ring-2 focus:ring-primary" maxlength="1" type="text" autofocus/>
                    <input class="otp-box w-12 h-14 bg-surface-container text-center text-3xl font-bold text-primary border-none focus:ring-2 focus:ring-primary" maxlength="1" type="text"/>
                    <input class="otp-box w-12 h-14 bg-surface-container text-center text-3xl font-bold text-primary border-none focus:ring-2 focus:ring-primary" maxlength="1" type="text"/>
                    <input class="otp-box w-12 h-14 bg-surface-container text-center text-3xl font-bold text-primary border-none focus:ring-2 focus:ring-primary" maxlength="1" type="text"/>
                    <input class="otp-box w-12 h-14 bg-surface-container text-center text-3xl font-bold text-primary border-none focus:ring-2 focus:ring-primary" maxlength="1" type="text"/>
                    <input class="otp-box w-12 h-14 bg-surface-container text-center text-3xl font-bold text-primary border-none focus:ring-2 focus:ring-primary" maxlength="1" type="text"/>
                </div>
                
                <form action="${pageContext.request.contextPath}/verify-otp" method="POST" id="verify-form">
                    <input type="hidden" name="otp" id="hidden-otp" value=""/>
                    <div class="flex flex-col space-y-4 pt-4">
                        <button onclick="submitOTP()" type="button" class="w-full bg-primary text-on-primary py-5 text-sm uppercase tracking-widest hover:opacity-90 transition-colors">
                            VERIFY CODE
                        </button>
                        <a href="${pageContext.request.contextPath}/register" class="text-center w-full bg-transparent text-secondary py-4 text-xs uppercase tracking-widest hover:text-primary transition-colors">
                            CANCEL
                        </a>
                    </div>
                </form>
            </div>

            <div class="mt-12 pt-8 border-t border-outline-variant text-center md:text-left">
                <p class="text-base text-secondary">
                    Already have an account? 
                    <a class="text-sm font-semibold text-primary hover:underline ml-2 uppercase" href="${pageContext.request.contextPath}/login">LOG IN</a>
                </p>
            </div>
        </div>
    </section>
</main>

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
        if(otpCode.length === 6) {
            document.getElementById('hidden-otp').value = otpCode;
            document.getElementById('verify-form').submit();
        } else {
            alert('Please enter a 6-digit OTP code.');
        }
    }
</script>
</body>
</html>
