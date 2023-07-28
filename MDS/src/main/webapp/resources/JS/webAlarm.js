/**
 * 
 */

/* 알림 클릭 시 알림 데이터 확인*/
	$("#webAlarm").click(function(){
		/*console.log(data);*/
			$.ajax({
				type:'post',
				url : "http://127.0.0.1:9000/webAlarm",
				/*data : JSON.stringify(postdata),*/
				data : {'u_id':data},
				dataType : 'json',
				/*contentType : 'application/json',*/
				success : function(result){
					console.log(result);
					/*console.log(result[0][0].sah_img_link);
					console.log(result[1][0].sac_img_link);*/
					/*console.log(BigInt(result[0][0].sah_num));
					console.log(BigInt(result[1][0].sac_num));*/
					/*console.log(result[1][1].sac_num);*/
					
					for(let i = 0; i < result[1].length; i++){
						result[1][i].sac_num = BigInt(result[1][i].sac_num);
						$('#page4-content').append(
								`<table>
									<tr>
										<td>자동차 이미지</td>
										<td>자동차 번호</td>
										<td>알림 내용</td>
										<td>알림 시간</td>
									</tr>
									<tr>
										<td><img src="showImage.com?fileName=${(result[1][i]).sac_img_link}"></td>
										<td>${(result[1][i]).car_num}</td>
										<td>${(result[1][i]).sac_content}</td>
										<td>${(result[1][i]).sac_at}</td>
									</tr>
								</table>`)
								
								
									let sac_num = BigInt((result[1][i]).sac_num);
									console.log(sac_num);
									
									$.ajax({
										type : 'post',
										url : 'sac_numUpdate.com',
										data : {'sac_num' : sac_num},
										success : function(res){
											console.log(res);
										},
										error : function(request,status,error){
											console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
										}
									})
								
								
					}
					
					for(let i = 0; i < result[0].length; i++){
						result[0][i].sah_num = BigInt(result[0][i].sah_num);
						$('#page4-content').append(
								`<table>
									<tr>
										<td>사람 이미지</td>
										<td>침입 인원 수</td>
										<td>알림 내용</td>
										<td>알림 시간</td>
									</tr>
									<tr>
										<td><img src="showImage.com?fileName=${(result[0][i]).sah_img_link}"></td>
										<td>${(result[0][i]).sah_total}</td>
										<td>${(result[0][i]).sah_content}</td>
										<td>${(result[0][i]).sah_at}</td>
									</tr>
								</table>`)
								
								
									let sah_num = BigInt((result[0][i]).sah_num);
									console.log(sah_num);
									
									$.ajax({
										type : 'post',
										url : 'sah_numUpdate.com',
										data : {'sah_num' : sah_num},
										success : function(res){
											console.log(res);
										},
										error : function(e){
											console.log("요청 실패");
										}
									})
							
								
					}
					
				},
				error : function(e){
					alert("요청 실패");
				}
			})
		});