/**
 * 
 */
 /* button 클릭 시 로그인 화면으로 ㄱㄱ
$(document).ready(function(){
        $('.signIn').on('click', function(){
            console.log($(this).text())
            
            location.href = "signIn.com";
            
        });
    }); */
    
/* button 클릭 시 회원가입 화면으로 ㄱㄱ
$(document).ready(function(){
        $('.signUp').on('click', function(){
            console.log($(this).text())
            
            location.href = "signUp.com";
            
            
        });
    }); */

$(document).ready(function(){
	$('#createAccount').on('click', function(){
		$('#signUp').children().remove();
	});

});
