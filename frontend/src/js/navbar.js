if (user.type_utilisateur === 'admin') {
    const adminLink = document.createElement('li');
    adminLink.className = 'nav-item';
    adminLink.innerHTML = '<a class="nav-link" href="dashboard.html">Dashboard</a>';
    document.querySelector('.navbar-nav').appendChild(adminLink);
}