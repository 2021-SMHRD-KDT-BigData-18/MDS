/*ajax*/
$(function(){
	$.ajax({
		url : 'graph.com',
		type : 'post',
		data : {"u_id": data},
		dataType : 'json',
		success: function(res){
			/*console.log(res);*/
			/*console.log(res.sac[0].sac_in_count);
			console.log(res.sac[0].sac_out_count);
			console.log(res.sac[0].sac_in_at);*/
			/*console.log(res.sac[0].sac_in_at.substring(10,13));*/
			
			let labels = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"];
			/*console.log(labels);*/
			
			/*침입 시간 -> in*/
			let sac_intrusion_time = [];
			let sah_intrusion_time = [];
			/*출입 시간 -> out*/
			let sac_entrance_time = [];
			let sah_entrance_time = [];
			
			/*침입 카운트*/
			let sac_intrusion_count = [];
			let sah_intrusion_count = [];
			/*출입 카운트*/
			let sac_entrance_count = [];
			let sah_entrance_count = [];
			
			for(var i = 0; i < res.sac.length; i++){
				/*console.log(res.sac[i].sac_in_at.substring(5,7));*/
				sac_intrusion_time.push(res.sac[i].sac_in_at.slice(5,7));
				sac_entrance_time.push(res.sac[i].sac_out_at.slice(5,7));
				/*console.log(sac_intrusion_time);*/
				/*console.log(typeof(res.sac[i].sac_out_at.slice(11,13)));*/
				
				for(var j = 0; j < labels.length; j++){
					if(sac_intrusion_time == labels[j]){
						sac_intrusion_count.push(res.sac[i].sac_in_count);
						sac_entrance_count.push(res.sac[i].sac_out_count);
					}else{
						sac_intrusion_count.push(0);
						sac_entrance_count.push(0);
					}

				}
			}
			sac_intrusion_count = sac_intrusion_count.slice(0, 24);
			sac_entrance_count = sac_entrance_count.slice(0, 24);
			/*console.log(sac_intrusion_count);
			console.log(sac_entrance_count);*/
			
			for(var i = 0; i < res.sah.length; i++){
				sah_intrusion_time.push(res.sah[i].sah_in_at.slice(5,7));
				if(res.sah[i].sah_out_at !==undefined && !isNaN(res.sah[i].sah_out_at)){
					res.sah[i].sah_out_at = res.sah[i].sah_out_at.slice(5,7);
				}
				sah_entrance_time.push(res.sah[i].sah_out_at);

				for(var j = 0; j < labels.length; j++){
					if(sah_intrusion_time == labels[j]){
						sah_intrusion_count.push(res.sah[i].sah_in_count);
						sah_entrance_count.push(res.sah[i].sah_out_count);
						/*console.log(sah_entrance_count);*/
					}else{
						sah_intrusion_count.push(0);
						sah_entrance_count.push(0);
					}
				}
			}
			sah_intrusion_count = sah_intrusion_count.slice(0, 24);
			sah_entrance_count = sah_entrance_count.slice(0, 24);
			
			BarChart(labels, sac_intrusion_count, sac_entrance_count, sah_intrusion_count, sah_entrance_count);
			
		}
	});
})

function BarChart(labels, sac_intrusion_count, sac_entrance_count, sah_intrusion_count, sah_entrance_count){

var ctx = document.getElementById("myBarChart");
var mySquareChart = new Chart(ctx, {
  type: 'bar',
  data: {
    labels: labels,
    datasets: [{
      label: "출입:차량",
      backgroundColor: "rgba(255, 72, 33, 0.4)",
	  borderColor: "rgba(255, 72, 33,1)",
      data: sac_entrance_count,
    },
    {
      label: "출입:사람",
      backgroundColor: "rgba(255, 183, 33,0.3)",
	  borderColor: "rgba(255, 183, 33,1)",
      data: sah_entrance_count,
    },
    {
      label: "침입:차량",
      backgroundColor: "rgba(141, 33, 255,0.3)",
	  borderColor: "rgba(141, 33, 255,1)",
      data: sac_intrusion_count,
    },
    {
      label: "침입:사람",
      backgroundColor: "rgba(247, 164, 20,0.3)",
	  borderColor: "rgba(247, 164, 20,1)",
      data: sah_intrusion_count,
    }],
  },
  options: {
	responsive: false, // 반응형 비활성화
    maintainAspectRatio: false, // 종횡비 유지 비활성화
    scales: {
      xAxes: [{
        time: {
          unit: 'month'
        },
        gridLines: {
          display: false
        },
        ticks: {
          maxTicksLimit: 12
        }
      }],
      yAxes: [{
        ticks: {
          beginAtZero: true,
          max: 10,
          stepSize: 2,
          maxTicksLimit: 6 
        },
        gridLines: {
          display: true
        }
      }],
    },
    legend: {
      display: false
    }
  }
});

mySquareChart.data.datasets[0].data = [];
mySquareChart.data.datasets[1].data = [];
mySquareChart.data.datasets[2].data = [];
mySquareChart.data.datasets[3].data = [];

/* 전송받은 값 토대로 데이터 표시여부 설정 */
$('.datachkbx').on('click', function() {
	console.log(this.value);
	result=[];
	result.push(this.value);
	/*passing 출입*/
	if(result.includes('passing')) {
			mySquareChart.data.datasets[0].data = [4,6,6,8,2,1,0,0,2,3,1,5];
			mySquareChart.data.datasets[1].data = [8,8,2,7,5,9,9,9,1,5,8,6];
			mySquareChart.data.datasets[2].data = [];
			mySquareChart.data.datasets[3].data = [];
			mySquareChart.update();
	/*intrude 침입*/
	}else if(result.includes('intrude')){
			mySquareChart.data.datasets[0].data = [];
			mySquareChart.data.datasets[1].data = [];
			mySquareChart.data.datasets[2].data = [9,9,5,4,0,0,5,6,7,7,8,6];
			mySquareChart.data.datasets[3].data = [3,3,5,1,1,5,5,1,0,0,1,3];
			mySquareChart.update();
	}else if(!result.includes('passing')&&!result.includes('intrude')){
			mySquareChart.data.datasets[0].data = [];
			mySquareChart.data.datasets[1].data = [];
			mySquareChart.data.datasets[2].data = [];
			mySquareChart.data.datasets[3].data = [];
			mySquareChart.update();
		};
	});
}