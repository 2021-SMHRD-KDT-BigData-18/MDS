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
      label: "Revenue",
      backgroundColor: "rgba(201, 34, 28,1)",
      borderColor: "rgba(201, 34, 28,1)",
      data: sac_entrance_count,
    },
    {
      label: "Revenue",
      backgroundColor: "rgba(247, 164, 20,1)",
      borderColor: "rgba(247, 164, 20,1)",
      data: sac_intrusion_count,
    },
    {
      label: "Revenue",
      backgroundColor: "rgba(201, 34, 28,1)",
      borderColor: "rgba(201, 34, 28,1)",
      data: sah_entrance_count,
    },
    {
      label: "Revenue",
      backgroundColor: "rgba(247, 164, 20,1)",
      borderColor: "rgba(247, 164, 20,1)",
      data: sah_intrusion_count,
    }],
  },
  options: {
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

/* 전송받은 값 토대로 데이터 표시여부 설정 */
$('.datachkbx').on('click', function() {
	console.log("up!");
	if(result.includes('passing')) {
		if (result.includes('car') && !result.includes('human') && result.includes('passing')) {
			mySquareChart.data.datasets[0].data = sac_entrance_count;
			mySquareChart.data.datasets[1].data = [];
			mySquareChart.data.datasets[2].data = [];
			mySquareChart.data.datasets[3].data = [];
		} else if(!result.includes('car') && result.includes('human') && result.includes('passing')){
			mySquareChart.data.datasets[0].data = [];
			mySquareChart.data.datasets[1].data = sah_entrance_count;
			mySquareChart.data.datasets[2].data = [];
			mySquareChart.data.datasets[3].data = [];
		} else if(result.includes('car') && result.includes('human') && result.includes('passing')) {
			mySquareChart.data.datasets[0].data = sac_entrance_count;
			mySquareChart.data.datasets[1].data = sah_entrance_count;
			mySquareChart.data.datasets[2].data = [];
			mySquareChart.data.datasets[3].data = [];
		} else {
			mySquareChart.data.datasets[0].data = [];
			mySquareChart.data.datasets[1].data = [];
			mySquareChart.data.datasets[2].data = [];
			mySquareChart.data.datasets[3].data = [];
		};
	}else if(result.includes('intrude')){
		if (result.includes('car') && !result.includes('human') && result.includes('intrude')) {
			mySquareChart.data.datasets[0].data = [];
			mySquareChart.data.datasets[1].data = [];
			mySquareChart.data.datasets[2].data = sac_intrusion_count;
			mySquareChart.data.datasets[3].data = [];
		} else if(!result.includes('car') && result.includes('human') && result.includes('intrude')){
			mySquareChart.data.datasets[0].data = [];
			mySquareChart.data.datasets[1].data = [];
			mySquareChart.data.datasets[2].data = [];
			mySquareChart.data.datasets[3].data = sah_intrusion_count;
		} else if(result.includes('car') && result.includes('human') && result.includes('intrude')) {
			mySquareChart.data.datasets[0].data = [];
			mySquareChart.data.datasets[1].data = [];
			mySquareChart.data.datasets[2].data = sac_intrusion_count;
			mySquareChart.data.datasets[3].data = sah_intrusion_count;
		} else {
			mySquareChart.data.datasets[0].data = [];
			mySquareChart.data.datasets[1].data = [];
			mySquareChart.data.datasets[2].data = [];
			mySquareChart.data.datasets[3].data = [];
		};
	};
	mySquareChart.update();
});
}