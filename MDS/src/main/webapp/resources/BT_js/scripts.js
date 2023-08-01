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
  modr.style.display = 'block';
});


// 내정보수정 js
$(document).ready(function() {
   $(".category>a").click(function() {
      $(this).next("ul").toggleClass("categorybtn");
   });
});
 
 function check_pw() {
		var id = document.getElementById("id").innerHTML;
        	var url = "check_pw.php?id=" + id;
		window.open(url, "chkpw", 'width=500,height=800, scrollbars=no, resizable=no');
	}
	function change_pw() {
		document.getElementById("pw").disabled = false;
		document.getElementById("pw_button").value = "확정";
		document.getElementById("pw_button").style.color = "hotpink";
		document.getElementById("pw_button").setAttribute("onclick", "decide_pw()");
	}
	function decide_pw() {
		document.getElementById("submit").disabled = false;
		document.getElementById("pw2").value = document.getElementById("pw").value;
		document.getElementById("pw").disabled = true;
		document.getElementById("pw_button").disabled = true;
		document.getElementById("pw_button").value = "확정됨";
		document.getElementById("pw_button").style.color = "#ccc";
	}

	function change_name() {
		document.getElementById("name").disabled = false;
		document.getElementById("name_button").value = "확정";
		document.getElementById("name_button").style.color = "hotpink";
		document.getElementById("name_button").setAttribute("onclick", "decide_name()");
	}
	function decide_name() {
		document.getElementById("submit").disabled = false;
		document.getElementById("name2").value = document.getElementById("name").value;
		document.getElementById("name").disabled = true;
		document.getElementById("name_button").disabled = true;
		document.getElementById("name_button").value = "확정됨";
		document.getElementById("name_button").style.color = "#ccc";
	}

	function change_intro() {
		document.getElementById("intro").disabled = false;
		document.getElementById("intro_button").value = "확정";
		document.getElementById("intro_button").style.color = "hotpink";
		document.getElementById("intro_button").setAttribute("onclick", "decide_intro()");
	}
	function decide_intro() {
		document.getElementById("submit").disabled = false;
		document.getElementById("intro2").value = document.getElementById("intro").value;
		document.getElementById("intro").disabled = true;
		document.getElementById("intro_button").disabled = true;
		document.getElementById("intro_button").value = "확정됨";
		document.getElementById("intro_button").style.color = "#ccc";
	}

	function change_phone() {
		document.getElementById("phone").disabled = false;
		document.getElementById("phone_button").value = "확정";
		document.getElementById("phone_button").style.color = "hotpink";
		document.getElementById("phone_button").setAttribute("onclick", "decide_phone()");
	}
	function decide_phone() {
		document.getElementById("submit").disabled = false;
		document.getElementById("phone2").value = document.getElementById("phone").value;
		document.getElementById("phone").disabled = true;
		document.getElementById("phone_button").disabled = true;
		document.getElementById("phone_button").value = "확정됨";
		document.getElementById("phone_button").style.color = "#ccc";
    }

