// Set new default font family and font color to mimic Bootstrap's default styling
Chart.defaults.global.defaultFontFamily = '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#292b2c';

// Area Chart Example

/* 체크박스 선택시 값 불러오기 */
let result = [];

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
			
			let labels = ["00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23"];
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
				/*console.log(res.sac[i].sac_in_at.substring(11,13));*/
				sac_intrusion_time.push(res.sac[i].sac_in_at.slice(11,13));
				sac_entrance_time.push(res.sac[i].sac_out_at.slice(11,13));
				/*console.log(sac_intrusion_time);*/
				/*console.log(typeof(res.sac[i].sac_out_at.slice(11,13)));*/
				/*console.log(res.sac[i].sac_out_count);*/
				
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
				sah_intrusion_time.push(res.sah[i].sah_in_at.slice(11,13));
				if(res.sah[i].sah_out_at !==undefined && !isNaN(res.sah[i].sah_out_at)){
					res.sah[i].sah_out_at = res.sah[i].sah_out_at.slice(11,13);
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
			
			AreaChart(labels, sac_intrusion_count, sac_entrance_count, sah_intrusion_count, sah_entrance_count);
			
		}
	});
})

function AreaChart(labels, sac_intrusion_count, sac_entrance_count, sah_intrusion_count, sah_entrance_count){

var ctx = document.getElementById("myAreaChart");
var myLineChart = new Chart(ctx, {
	type: 'line',
	data: {
		labels: labels,
		datasets: [{
			label: "출입:차량",
			lineTension: 0.3,
			backgroundColor: "rgba(255, 72, 33, 0.4)",
			borderColor: "rgba(255, 72, 33,1)",
			pointRadius: 5,
			pointBackgroundColor: "rgba(255, 72, 33,1)",
			pointBorderColor: "rgba(255,255,255,0.8)",
			pointHoverRadius: 5,
			pointHoverBackgroundColor: "rgba(255, 72, 33,1)",
			pointHitRadius: 50,
			pointBorderWidth: 2,
			data: sac_entrance_count,
			pointStyle: true,
			fill: true
		},
		{
			label: "출입:사람",
			lineTension: 0.3,
			backgroundColor: "rgba(255, 183, 33,0.3)",
			borderColor: "rgba(255, 183, 33,1)",
			pointRadius: 5,
			pointBackgroundColor: "rgba(255, 183, 33,1)",
			pointBorderColor: "rgba(255,255,255,0.8)",
			pointHoverRadius: 5,
			pointHoverBackgroundColor: "rgba(255, 183, 33,1)",
			pointHitRadius: 50,
			pointBorderWidth: 2,
			data: sah_entrance_count,
			pointStyle: true,
			fill: true
		},
		{
			label: "침입:차량",
			lineTension: 0.3,
			backgroundColor: "rgba(141, 33, 255,0.3)",
			borderColor: "rgba(141, 33, 255,1)",
			pointRadius: 5,
			pointBackgroundColor: "rgba(141, 33, 255,1)",
			pointBorderColor: "rgba(255,255,255,0.8)",
			pointHoverRadius: 5,
			pointHoverBackgroundColor: "rgba(141, 33, 255,1)",
			pointHitRadius: 50,
			pointBorderWidth: 2,
			data: sac_intrusion_count,
			pointStyle: true,
			fill: true
		},
		{
			label: "침입:사람",
			lineTension: 0.3,
			backgroundColor: "rgba(247, 164, 20,0.3)",
			borderColor: "rgba(247, 164, 20,1)",
			pointRadius: 5,
			pointBackgroundColor: "rgba(247, 164, 20,1)",
			pointBorderColor: "rgba(255,255,255,0.8)",
			pointHoverRadius: 5,
			pointHoverBackgroundColor: "rgba(247, 164, 20,1)",
			pointHitRadius: 50,
			pointBorderWidth: 2,
			data: sah_intrusion_count,
			pointStyle: true,
			fill: true
		}],
	},
	options: {
		responsive: false, // 반응형 비활성화
        maintainAspectRatio: false, // 종횡비 유지 비활성화
		scales: {
			xAxes: [{
				time: {
					unit: 'date'
				},
				gridLines: {
					display: false
				},
				ticks: {
					maxTicksLimit:24
				}
			}],
			yAxes: [{
				ticks: {
		          beginAtZero: true,
		          max: 5,
		          stepSize: 1,
		          maxTicksLimit: 6
				},
				gridLines: {
					color: "rgba(0, 0, 0, .125)",
				}
			}],
		},
		legend: {
			display: false
		}
	}
});

myLineChart.data.datasets[0].data = [];
myLineChart.data.datasets[1].data = [];
myLineChart.data.datasets[2].data = [];
myLineChart.data.datasets[3].data = [];	
myLineChart.update();



/* 전송받은 값 토대로 데이터 표시여부 설정 */
$('.datachkbx').on('click', function() {
	console.log(this.value);
	result=[];
	result.push(this.value);
	/*passing 출입*/
	if(result.includes('passing')) {
			myLineChart.data.datasets[0].data = [1,3,2,4,0,0,0,0,0,1,1,2,3,4,3,2,1,1,0,0,0,4,5,5];
			myLineChart.data.datasets[1].data = [2,2,2,1,0,1,2,2,4,4,3,1,0,0,2,2,3,1,4,4,1,0,0,0];
			myLineChart.data.datasets[2].data = [];
			myLineChart.data.datasets[3].data = [];
			myLineChart.update();
	/*intrude 침입*/
	}else if(result.includes('intrude')){
			myLineChart.data.datasets[0].data = [];
			myLineChart.data.datasets[1].data = [];
			myLineChart.data.datasets[2].data = [3,2,2,1,1,2,2,3,3,0,0,0,0,0,2,5,5,4,3,1,1,0,0,0];
			myLineChart.data.datasets[3].data = [2,2,1,0,0,3,3,0,0,0,2,5,5,4,1,0,1,2,3,2,0,0,0,0];
			myLineChart.update();
	}else if(!result.includes('passing')&&!result.includes('intrude')){
			myLineChart.data.datasets[0].data = [];
			myLineChart.data.datasets[1].data = [];
			myLineChart.data.datasets[2].data = [];
			myLineChart.data.datasets[3].data = [];
			myLineChart.update();
	};
});
}