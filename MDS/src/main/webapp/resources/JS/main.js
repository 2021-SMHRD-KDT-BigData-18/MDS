
// script.js
$(document).ready(function() {
    // 페이지 1 로드 버튼 클릭 시
    $("#radio-1").click(function() {
        // 비동기로 페이지 2의 내용을 가져와서 main-content에 삽입하고, 기존 내용은 숨깁니다.
        $("#page2-content").hide();
        $("#page3-content").hide();
        $("#page4-content").hide();
        $("#page5-content").hide();
        
        $("#page1-content").show();
    });

    // 페이지 2 로드 버튼 클릭 시
    $("#radio-2").click(function() {
        // 비동기로 페이지 2의 내용을 가져와서 main-content에 삽입하고, 기존 내용은 숨깁니다.
        $("#page1-content").hide();
        $("#page3-content").hide();
        $("#page4-content").hide();
        $("#page5-content").hide();
        
        $("#page2-content").show();
    });
    
    $("#radio-3").click(function() {
        // 비동기로 페이지 3의 내용을 가져와서 main-content에 삽입하고, 기존 내용은 숨깁니다.
        $("#page1-content").hide();
        $("#page2-content").hide();
        $("#page4-content").hide();
        $("#page5-content").hide();
        
        $("#page3-content").show();
    });
    
    $("#radio-4").click(function() {
        // 비동기로 페이지 4의 내용을 가져와서 main-content에 삽입하고, 기존 내용은 숨깁니다.
        $("#page1-content").hide();
        $("#page2-content").hide();
        $("#page3-content").hide();
        $("#page5-content").hide();
        $("#page4-content").show();
    });
    
    $("#radio-5").click(function() {
        // 비동기로 페이지 5의 내용을 가져와서 main-content에 삽입하고, 기존 내용은 숨깁니다.
        $("#page1-content").hide();
        $("#page2-content").hide();
        $("#page3-content").hide();
        $("#page4-content").hide();
        $("#page5-content").show();
    });
});


/* 알림 클릭 시 알림 데이터 확인*/
	$("#radio-5").click(function(){
			
			var postdata = {'u_id':id};
			
			$.ajax({
				type:'post',
				url : "http://127.0.0.1:9000/webAlarm",
				/*data : JSON.stringify(postdata),*/
				data : postdata,
				dataType : 'JSON',
				/*contentType : 'application/json',*/
				success : function(result){
					/*console.log(result);
					console.log(result[0].car_num);*/
					for(let i = 0; i < result.length; i++){
						$('#page5-content').append(
								`<table>
									<tr>
										<td>자동차 이미지</td>
										<td>자동차 번호</td>
										<td>알림 내용</td>
										<td>알림 시간</td>
										<td>알림 읽음 여부</td>
										<td>알림 읽음 일시</td>
									<tr>
									<tr>
										<td>\${result[i].car_img_link}</td>
										<td>\${result[i].car_num}</td>
										<td>\${result[i].sac_content}</td>
										<td>\${result[i].sac_at}</td>
										<td>\${result[i].sac_read}</td>
										<td>\${result[i].sac_read_at}</td>
									</tr>
								</table>`)
					}
				},
				error : function(e){
					alert("요청 실패");
				}
			})
		}); 
	
	