/**
 * 
 */

/* 알림 클릭 시 알림 데이터 확인*/
	$("#radio-5").click(function(){
			$.ajax({
				type:'post',
				url : "http://127.0.0.1:9000/webAlarm",
				/*data : JSON.stringify(postdata),*/
				data : {'u_id':data},
				dataType : 'JSON',
				/*contentType : 'application/json',*/
				success : function(result){
					console.log(result);
					console.log((result[0][0]).cctv_id);
					
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
										<td><img src="${(result[1][i]).car_img_link}"></td>
										<td>${(result[1][i]).car_num}</td>
										<td>${(result[1][i]).sac_content}</td>
										<td>${(result[1][i]).sac_at}</td>
										<td>${(result[1][i]).sac_read}</td>
										<td>${(result[1][i]).sac_read_at}</td>
									</tr>
								</table>`)
					}
					
					for(let i = 0; i < result.length; i++){
						$('#page5-content').append(
								`<table>
									<tr>
										<td>사람 이미지</td>
										<td>침입 인원 수</td>
										<td>알림 내용</td>
										<td>알림 시간</td>
										<td>알림 읽음 여부</td>
										<td>알림 읽음 일시</td>
									<tr>
									<tr>
										<td><img src="${(result[0][i]).human_img_link}"></td>
										<td>${(result[0][i]).sah_total}</td>
										<td>${(result[0][i]).sah_content}</td>
										<td>${(result[0][i]).sah_at}</td>
										<td>${(result[0][i]).sah_read}</td>
										<td>${(result[0][i]).sah_read_at}</td>
									</tr>
								</table>`)
					}
				},
				error : function(e){
					alert("요청 실패");
				}
			})
		});