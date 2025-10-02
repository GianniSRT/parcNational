document.addEventListener('DOMContentLoaded', function() {
  const userType = localStorage.getItem('userType');
  console.log('userType:', userType); // Ajout du log
  if (userType && userType.toLowerCase() === 'admin') {
    const adminBtn = document.getElementById('adminBtn');
    if (adminBtn) adminBtn.style.display = 'block';
  }
});