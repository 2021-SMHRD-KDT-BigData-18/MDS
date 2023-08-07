/**
 * 
 */
 
/*메인페이지 침입, 카운트 수 출력*/

	/*console.log(data);*/
	$.ajax({
		type:'post',
		url : 'http://127.0.0.1:9000/connectMain',
		data : {'login_id': data},
		dataType : 'json',
		success: function(res){
			/*console.log(res[0][0].sac_out_count);*/
			console.log(res[0][0].sac_img_link);
			
			/*for(var i = 0; i < res.length; i++){
				$('#countList').append(`
				<div class="bieberhouse">
					<div class="bieber_card">
						<div>
							<img src="showImage.com?fileName=${res[i][i].sac_img_link_two}">
							<div class="bieber_content">
								<ol>차번호 : ${res[i][i].car_num}</ol>
								<ol>출입 시간 : ${res[i][i].sac_out_at}</ol>
							</div>
						</div>
					</div><br>
				`);
				
				
				if(res[i][i].sah_out_count !== 0){
				$('#countList').append(`
					<div class="bieber_card">
						<div>
							<img src="showImage.com?fileName=${res[i][i].sah_img_link}">
							<div class="bieber_content">
								<ol>출입 인원 : ${res[i][i].sah_out_count}명</ol>
								<ol>출입 시간 : ${res[i][i].sah_out_at}</ol>
							</div>
						</div>
					</div>
				</div><br>
				
				`);
				}
				
				if(res[i][i].sac_in_count !== 0){
				$('#intrusionList').append(`
				<div class="bieberhouse">
					<div class="bieber_card">
						<div>
							<img src="showImage.com?fileName=${res[i][i].sac_img_link}">
							<div class="bieber_content">
								<ol>차번호 : ${res[i][i].car_num}</ol>
								<ol>침입 시간 : ${res[i][i].sac_in_at}</ol>
							</div>
						</div>
					</div><br>
				`);
				}
				
				if(res[i][i].sah_in_count !== 0){
				$('#intrusionList').append(`
					<div class="bieber_card">
						<div>
							<img src="showImage.com?fileName=${res[i][i].sah_img_link}">
							<div class="bieber_content">
								<ol>침입 수 : ${res[i][i].sah_in_count}명</ol>
								<ol>침입 시간 : ${res[i][i].sah_in_at}</ol>
							</div>
						</div>
					</div></br>
				`);
				}
				
			}*/
			
			$('#countList').append(`
				<div class="bieberhouse">
					<div class="bieber_card">
						<div>
							<img src="showImage.com?fileName=C:/Users/smhrd/git/MDS/MDS/src/main/webapp/resources/alarmCapture_c1/car5.png">
							<div class="bieber_content">
								<ol>차번호 : 27허7862</ol>
								<ol>출입 시간 : 2023-08-07 09:19:53</ol>
							</div>
						</div>
					</div><br>
				`);
				
			$('#countList').append(`
				<div class="bieberhouse">
					<div class="bieber_card">
						<div>
							<img src="showImage.com?fileName=C:/Users/smhrd/git/MDS/MDS/src/main/webapp/resources/alarmCapture_c/car3.png">
							<div class="bieber_content">
								<ol>차번호 : 64너3985</ol>
								<ol>출입 시간 : 2023-08-07 09:19:53</ol>
							</div>
						</div>
					</div><br>
				`);
				
			$('#countList').append(`
					<div class="bieber_card">
						<div>
							<img src="showImage.com?fileName=C:/Users/smhrd/git/MDS/MDS/src/main/webapp/resources/alarmCapture_h/person_1691208439.3765712.jpg" wi>
							<div class="bieber_content">
								<ol>출입 수 : 1명</ol>
								<ol>침입 시간 : 2023-08-07 09:19:53</ol>
							</div>
						</div>
					</div></br>
				`);	
				
			$('#intrusionList').append(`
					<div class="bieber_card">
						<div>
							<img src="showImage.com?fileName=C:/Users/smhrd/git/MDS/MDS/src/main/webapp/resources/alarmCapture_h1/person1.png">
							<div class="bieber_content">
								<ol>침입 수 : 1명</ol>
								<ol>침입 시간 : 2023-08-07 09:19:53</ol>
							</div>
						</div>
					</div></br>
				`);	
				
		}
	})
 
const modr = document.getElementById('modr');
/* 알림 개수 카운트 */
		$.ajax({
			type:'post',
			url: 'countAlarm.com',
			data : {'u_id':data},
			dataType: 'text',
			success:function(res){
				/*console.log(res);*/
				modr.style.display = 'block';
				$('#countAlarm').append(res);
				$('#modal-close-btn').click(function(){
					$('#countAlarm').html("0");
				})
			},
			error: function(e){
				console.log("알림 개수 왜 안넘어와");
			}
		})

/* 알림 클릭 시 알림 데이터 확인*/
	$("#icon-button").click(function(){
		console.log(data);
			$.ajax({
				type:'post',
				url : "http://127.0.0.1:9000/webAlarm",
				/*data : JSON.stringify(postdata),*/
				data : {'u_id':data},
				dataType : 'json',
				/*contentType : 'application/json',*/
				success : function(result){
				modr.style.display = 'none';
					
					for(let i = 0; i < result[1].length; i++){
						result[1][i].sac_num = BigInt(result[1][i].sac_num);
						$('#webAlarm_content').append(
								`<p>${(result[1][i]).car_num}가 ${(result[1][i]).sac_in_at}에 ${(result[1][i]).sac_content}</p>
								 `)
								
								
									let sac_num = BigInt((result[1][i]).sac_num);
									/*console.log(sac_num);*/
									
									$.ajax({
										type : 'post',
										url : 'sac_numUpdate.com',
										data : {'sac_num' : sac_num},
										success : function(res){
											console.log(res);
										}
									})
								
								
					}
					
					for(let i = 0; i < result[0].length; i++){
						result[0][i].sah_num = BigInt(result[0][i].sah_num);
						$('#webAlarm_content').append(
								`<p>${(result[0][i]).sah_in_count}명이
								 ${(result[0][i]).sah_in_at}에
								 ${(result[0][i]).sah_content}</p>
								`)
								
								
									let sah_num = BigInt((result[0][i]).sah_num);
									/*console.log(sah_num);*/
									
									$.ajax({
										type : 'post',
										url : 'sah_numUpdate.com',
										data : {'sah_num' : sah_num},
										success : function(res){
											console.log(res);
										}
									});
							
								
					}
					
					
					
				},
				error : function(e){
					alert("요청 실패");
				}
			})
			
		});
		
/*<p><img src="showImage.com?fileName=${(result[0][i]).sah_img_link}"></p>*/
/*<p><img src="showImage.com?fileName=${(result[1][i]).sac_img_link}"></p>*/