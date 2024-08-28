document.addEventListener("DOMContentLoaded", function() {
    const buttons = document.querySelectorAll('.nav-btn');
    const sections = document.querySelectorAll('.content-section');

    buttons.forEach(button => {
        button.addEventListener('click', function() {
            const sectionId = this.getAttribute('data-section');
            
            sections.forEach(section => {
                if (section.id === sectionId) {
                    section.classList.add('active');
                } else {
                    section.classList.remove('active');
                }
            });
        });
    });
});
document.addEventListener("DOMContentLoaded", function() {
    const counterElement = document.getElementById('counter');

    // Function to fetch the visitor count from the Azure Function
    async function fetchVisitorCount() {
        try {
            const response = await fetch('https://bdfunc1337.azurewebsites.net/api/updateCounter?code=46TKEYCQPMd7IW1s-nU42DS0PKO6TjTy3oSquLUGx0YAAzFuRDuzzw%3D%3D');
            if (response.ok) {
                const count = await response.text();
                counterElement.textContent = count;

                counterElement.classList.remove('animate');
                void counterElement.offsetWidth; // Trigger reflow to restart the animation
                counterElement.classList.add('animate');
            } else {
                counterElement.textContent = 'Error';
            }
        } catch (error) {
            counterElement.textContent = 'Error';
            console.error('Failed to fetch visitor count:', error);
        }
    }

    // Fetch visitor count on page load
    fetchVisitorCount();
});