/**
 * 
 */

$("#radio-4").click(function(){
	/*console.log(data);*/
	$.ajax({
		url:'getEntryLog',
		type: 'post',
		data : {'u_id':data},
		dataType:'json',
		success:function(res){
			console.log(res);
			console.log(res[0].car_img_link);
			for(let i = 0; i < res.length; i++){
						$('#page4-content').append(
								`<table>
									<tr>
										<td>자동차 이미지</td>
										<td>자동차 번호</td>
										<td>차량 출입 시간</td>
										<td>cctv ID</td>
									<tr>
									<tr>
										<td><img src="${res[i].car_img_link}"></td>
										<td>${res[i].car_num}</td>
										<td>${res[i].car_inout_at}</td>
										<td>${res[i].cctv_id}</td>
									</tr>
								</table>`)
					}
		},
		error : function(){
			console.log('실패');
		}
	})
});
