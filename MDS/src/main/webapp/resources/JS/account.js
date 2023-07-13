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


/*ID 중복 체크*/
$(document).ready(function(){

	var input = $('#user_id');
	input.on("input", idCheck);
				});

function idCheck(){
	var value = $(this).val();
	console.log(value);
	
	$.ajax({
		url : 'signUp.com',
		type : 'post',
		data : {
			user_id : value
				},
		success : function(res){
		/*console.log(res);*/
		
		var p = $('#idCheck');
							
		if(res == "true"){
			// 사용가능한 아이디입니다.
			p.html('사용이 가능한 이메일 입니다.');
			p.css("color", "green"); // css("style 이름", "값")
		}else {
			// 사용 불가능한 아이디입니다.
			p.html("사용이 불가능한 아이디 입니다.").css("color", "red");
				}
							
		},
		error : function(e){
			alert("요청 실패");
				}
					});
};