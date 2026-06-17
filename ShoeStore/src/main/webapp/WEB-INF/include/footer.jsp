<!-- Footer -->
<footer class="bg-primary dark:bg-surface-container-lowest w-full py-24">
    <div
        class="grid grid-cols-1 md:grid-cols-4 gap-gutter px-margin-mobile md:px-margin-desktop w-full max-w-container-max mx-auto">
        <div class="md:col-span-1">
            <span class="text-headline-lg font-headline-lg font-black text-on-primary">ADIDIS</span>
            <p class="text-body-md text-on-primary/70 mt-6 max-w-xs">Engineered speed for the uncompromising athlete.
                Clinically tested performance footwear.</p>
        </div>
        <div class="flex flex-col gap-4">
            <h4 class="text-label-md font-label-md uppercase text-on-primary mb-2">EXPLORE</h4>
            <a class="text-label-sm font-label-sm text-on-primary/70 hover:text-on-primary transition-colors"
                href="#">SHOP ALL</a>
            <a class="text-label-sm font-label-sm text-on-primary/70 hover:text-on-primary transition-colors"
                href="#">NEW RELEASES</a>
            <a class="text-label-sm font-label-sm text-on-primary/70 hover:text-on-primary transition-colors"
                href="#">LABS</a>
            <a class="text-label-sm font-label-sm text-on-primary/70 hover:text-on-primary transition-colors"
                href="#">COLLECTIONS</a>
        </div>
        <div class="flex flex-col gap-4">
            <h4 class="text-label-md font-label-md uppercase text-on-primary mb-2">SUPPORT</h4>
            <a class="text-label-sm font-label-sm text-on-primary/70 hover:text-on-primary transition-colors"
                href="#">ABOUT US</a>
            <a class="text-label-sm font-label-sm text-on-primary/70 hover:text-on-primary transition-colors"
                href="#">CUSTOMER SERVICE</a>
            <a class="text-label-sm font-label-sm text-on-primary/70 hover:text-on-primary transition-colors"
                href="#">TERMS</a>
            <a class="text-label-sm font-label-sm text-on-primary/70 hover:text-on-primary transition-colors"
                href="#">SHIPPING</a>
        </div>
        <div class="flex flex-col gap-4">
            <h4 class="text-label-md font-label-md uppercase text-on-primary mb-2">SOCIAL</h4>
            <a class="text-label-sm font-label-sm text-on-primary/70 hover:text-on-primary transition-colors"
                href="#">INSTAGRAM</a>
            <a class="text-label-sm font-label-sm text-on-primary/70 hover:text-on-primary transition-colors"
                href="#">TWITTER</a>
            <a class="text-label-sm font-label-sm text-on-primary/70 hover:text-on-primary transition-colors"
                href="#">YOUTUBE</a>
        </div>
    </div>
    <div
        class="mt-24 px-margin-mobile md:px-margin-desktop w-full max-w-container-max mx-auto border-t border-on-primary/10 pt-8 flex flex-col md:flex-row justify-between items-center gap-4">
        <span class="text-label-sm font-label-sm text-on-primary/50">© 2026 ADIDIS. ENGINEERED SPEED.</span>
        <div class="flex gap-8">
            <span class="text-label-sm font-label-sm text-on-primary/50 uppercase tracking-widest">EST. 2026</span>
            <span class="text-label-sm font-label-sm text-on-primary/50 uppercase tracking-widest">GLOBAL
                DISTRIBUTION</span>
        </div>
    </div>
</footer>

<!-- Logout Toast Notification -->
<div class="fixed bottom-8 right-8 z-[100] transform translate-y-20 opacity-0 transition-all duration-500 ease-in-out pointer-events-none"
    id="logout-toast">
    <div class="bg-primary text-on-primary px-6 py-4 flex items-center gap-3 shadow-xl border border-outline-variant">
        <span class="material-symbols-outlined">check_circle</span>
        <p class="text-label-md font-label-md uppercase tracking-wider">Successfully logged out</p>
    </div>
</div>

<!-- Scripts -->
<script>
    // Micro-interaction for hover effects on buttons
    document.querySelectorAll('button').forEach(button => {
        button.addEventListener('mousedown', () => {
            button.style.transform = 'scale(0.95)';
        });
        button.addEventListener('mouseup', () => {
            button.style.transform = 'scale(1)';
        });
    });

    // Sticky Header scroll effect
    window.addEventListener('scroll', () => {
        const header = document.querySelector('header');
        if (window.scrollY > 20) {
            header.classList.add('bg-surface/95');
            header.classList.add('shadow-sm');
        } else {
            header.classList.remove('bg-surface/95');
            header.classList.remove('shadow-sm');
        }
    });

    // Logout Toast Logic
    const logoutBtn = document.querySelector('header button[title="Logout"]');
    const toast = document.getElementById('logout-toast');

    if (logoutBtn && toast) {
        logoutBtn.addEventListener('click', () => {
            // Show toast
            toast.classList.remove('translate-y-20', 'opacity-0', 'pointer-events-none');
            toast.classList.add('translate-y-0', 'opacity-100');

            // Hide toast after 3 seconds
            setTimeout(() => {
                toast.classList.add('translate-y-20', 'opacity-0', 'pointer-events-none');
                toast.classList.remove('translate-y-0', 'opacity-100');
            }, 3000);
        });
    }
</script>
</body>

</html>