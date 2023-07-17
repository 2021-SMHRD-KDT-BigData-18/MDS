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

/*도로명주소*/
function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }


/*아이디 중복 체크*/
$(document).ready(function(){
		var input = $('#u_id');
		input.on("input", idCheck);
	});
	
	function idCheck(){
		
		var value = $(this).val();
		/*console.log(value);*/
		
		$.ajax({
			url : 'idCheck.com',
			type : 'post',
			data : {
				"u_id" : value
			},
			success : function(res){
				/*console.log(res);*/
				
				var p = $('#id_check');
				
				if(res == "true"){
					p.html('사용이 가능한 아이디 입니다.');
					p.css("color", "green"); // css("style 이름", "값")
				}else {
					p.html("사용이 불가능한 아이디 입니다.").css("color", "red");
				}
				
			},
			error : function(e){
				alert("요청 실패");
			}
		});
	}
	

/*비밀번호 재확인*/
$('#u_pw_confirm').keyup(function(){
			let pass1 = $('#u_pw').val();
			let pass2 = $('#u_pw_confirm').val();
			
			if(pass1 != "" || pass2 != ""){
				if(pass1 == pass2){
					$('#confirmMsg').html("비밀번호 일치");
					$('#confirmMsg').css('color', 'green');
				} else {
					$('#confirmMsg').html("비밀번호 불일치");
					$('#confirmMsg').css('color', 'red');
				}
			}
		})
		
		
/*이메일 인증*/
$('#mail-Check-Btn').click(function(){
			var email = $('#u_email').val();
			console.log(email);
			var checkEmail = $('.mail-check-input');
			
			$.ajax({
				url : 'checkEmail.com',
				type : 'post',
				data : {"u_email" : email},
				success : function(data){
					console.log(data);
					checkEmail.attr('disabled', false);
					code = data;
					alert('인증번호가 전송되었습니다.');
				}
			})
		})
		
	// 인증번호 비교 
	// blur -> focus가 벗어나는 경우 발생
	$('.mail-check-input').blur(function () {
		const inputCode = $(this).val();
		const $resultMsg = $('#mail-check-warn');
		
		if(inputCode === code){
			$resultMsg.html('인증번호가 일치합니다.');
			$resultMsg.css('color','green');
			$('#mail-Check-Btn').attr('disabled',true);
			$('#userEamil1').attr('readonly',true);
			$('#userEamil2').attr('readonly',true);
			$('#userEmail2').attr('onFocus', 'this.initialSelect = this.selectedIndex');
	         $('#userEmail2').attr('onChange', 'this.selectedIndex = this.initialSelect');
		}else{
			$resultMsg.html('인증번호가 불일치 합니다. 다시 확인해주세요!.');
			$resultMsg.css('color','red');
		}
	});
