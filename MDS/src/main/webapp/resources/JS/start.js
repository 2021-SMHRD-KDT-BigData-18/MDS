// 모달 창 관련 동작을 위한 JavaScript 코드
var loginModal = document.getElementById('loginModal');
var signupModal = document.getElementById('signupModal');
var loginButton = document.getElementById('loginButton');
var signupButton = document.getElementById('signupButton');
var closeButtons = document.getElementsByClassName('close-button');

loginButton.addEventListener('click', function() {
  loginModal.style.display = 'block';
});

signupButton.addEventListener('click', function() {
  signupModal.style.display = 'block';
});

for (var i = 0; i < closeButtons.length; i++) {
  closeButtons[i].addEventListener('click', function() {
    loginModal.style.display = 'none';
    signupModal.style.display = 'none';
  });
}

window.addEventListener('click', function(event) {
  if (event.target == loginModal || event.target == signupModal) {
    loginModal.style.display = 'none';
    signupModal.style.display = 'none';
  }
});
