/*!
    * Start Bootstrap - SB Admin v7.0.7 (https://startbootstrap.com/template/sb-admin)
    * Copyright 2013-2023 Start Bootstrap
    * Licensed under MIT (https://github.com/StartBootstrap/startbootstrap-sb-admin/blob/master/LICENSE)
    */
    // 
// Scripts
// 

window.addEventListener('DOMContentLoaded', event => {

    // Toggle the side navigation
    const sidebarToggle = document.body.querySelector('#sidebarToggle');
    if (sidebarToggle) {
        // Uncomment Below to persist sidebar toggle between refreshes
        // if (localStorage.getItem('sb|sidebar-toggle') === 'true') {
        //     document.body.classList.toggle('sb-sidenav-toggled');
        // }
        sidebarToggle.addEventListener('click', event => {
            event.preventDefault();
            document.body.classList.toggle('sb-sidenav-toggled');
            localStorage.setItem('sb|sidebar-toggle', document.body.classList.contains('sb-sidenav-toggled'));
        });
    }

});

// 모달 열기
const iconButton = document.getElementById('icon-button');
const modalBg = document.getElementById('modal-bg');
const modal = document.getElementById('modal');
const modalCloseBtn = document.getElementById('modal-close-btn');

iconButton.addEventListener('click', () => {
  modalBg.style.display = 'block';
});

// 모달 닫기
modalCloseBtn.addEventListener('click', () => {
  $("#webAlarm_content").remove();
  modalBg.style.display = 'none';
});
