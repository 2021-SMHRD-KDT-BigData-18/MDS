/**
 * 
 */
const modr = document.getElementById('modr');
/* 알림 개수 카운트 */
		$.ajax({
			type:'post',
			url: 'countAlarm.com',
			data : {'u_id':data},
			dataType: 'text',
			success:function(res){
				console.log(res);
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
		/*console.log(data);*/
			$.ajax({
				type:'post',
				url : "http://127.0.0.1:9000/webAlarm",
				/*data : JSON.stringify(postdata),*/
				data : {'u_id':data},
				dataType : 'json',
				/*contentType : 'application/json',*/
				success : function(result){
				modr.style.display = 'none';
					console.log(result);
					/*console.log(result[0][0].sah_img_link);
					console.log(result[1][0].sac_img_link);*/
					/*console.log(BigInt(result[0][0].sah_num));
					console.log(BigInt(result[1][0].sac_num));*/
					/*console.log(result[1][1].sac_num);*/
					/*console.log(result.length);*/
					
					for(let i = 0; i < result[1].length; i++){
						result[1][i].sac_num = BigInt(result[1][i].sac_num);
						$('#webAlarm_content').append(
								`<p>${(result[1][i]).car_num}가 ${(result[1][i]).sac_at}에 ${(result[1][i]).sac_content}</p>
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
								`<p>${(result[0][i]).sah_total}명이
								 ${(result[0][i]).sah_at}에
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