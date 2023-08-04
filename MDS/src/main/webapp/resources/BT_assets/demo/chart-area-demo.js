// Set new default font family and font color to mimic Bootstrap's default styling
Chart.defaults.global.defaultFontFamily = '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#292b2c';

// Area Chart Example

/* 체크박스 선택시 값 불러오기 */
let result = [];

/* 체크박스 선택시 값 불러오기 - 출입침입선택 */
function getNavChkbxVal(test) {
	if (test.checked) {
		result = [];
		result.push(test.value);
		test.checked=false;
	}
	console.log(result);
};

/* 체크박스 선택시 값 불러오기 - 차량사람선택 */
function getChkbxVal(test) {
	if (test.checked) {
		if (!result.includes(test.value)) {
			result.push(test.value);
		}
	} else {
		const index = result.indexOf(test.value);
		if (index !== -1) {
			result.splice(index, 1);
		}
	}
	console.log(result);
};


var ctx = document.getElementById("myAreaChart");
var myLineChart = new Chart(ctx, {
	type: 'line',
	data: {
		labels: ["00:00", "01:00", "02:00", "03:00", "04:00", "05:00", "06:00", "07:00", "08:00", "09:00", "10:00", "11:00", "12:00", "13:00", "14:00", "15:00", "16:00", "17:00", "18:00", "19:00", "20:00", "21:00", "22:00", "23:00"],
		datasets: [{
			label: "출입:차량",
			lineTension: 0.3,
			backgroundColor: "rgba(201, 34, 28, 0.2)",
			borderColor: "rgba(201, 34, 28,1)",
			pointRadius: 5,
			pointBackgroundColor: "rgba(201, 34, 28,1)",
			pointBorderColor: "rgba(255,255,255,0.8)",
			pointHoverRadius: 5,
			pointHoverBackgroundColor: "rgba(201, 34, 28,1)",
			pointHitRadius: 50,
			pointBorderWidth: 2,
			data: [],
			pointStyle: true,
			fill: true
		},
		{
			label: "출입:사람",
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
			data: [],
			pointStyle: true,
			fill: true
		},
		{
			label: "침입:차량",
			lineTension: 0.3,
			backgroundColor: "rgba(247, 119, 20,0.2)",
			borderColor: "rgba(247, 119, 20,1)",
			pointRadius: 5,
			pointBackgroundColor: "rgba(247, 119, 20,1)",
			pointBorderColor: "rgba(255,255,255,0.8)",
			pointHoverRadius: 5,
			pointHoverBackgroundColor: "rgba(247, 119, 20,1)",
			pointHitRadius: 50,
			pointBorderWidth: 2,
			data: [],
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
			data: [],
			pointStyle: true,
			fill: true
		}],
	},
	options: {
		scales: {
			xAxes: [{
				time: {
					unit: 'date'
				},
				gridLines: {
					display: false
				},
				ticks: {
					maxTicksLimit: 7
				}
			}],
			yAxes: [{
				ticks: {
					min: 0,
					max: 40000,
					maxTicksLimit: 5
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

/* 전송받은 값 토대로 데이터 표시여부 설정 */
$('.datachkbx').on('click', function() {
	console.log("up!");
	if(result.includes('passing')) {
		if (result.includes('car') && !result.includes('human') && result.includes('passing')) {
			myLineChart.data.datasets[0].data = [10000, 30162, 26263, 18394, 18287, 28682, 31274, 33259, 25849, 24159, 32651, 31984, 38451];
			myLineChart.data.datasets[1].data = [];
			myLineChart.data.datasets[2].data = [];
			myLineChart.data.datasets[3].data = [];
		} else if(!result.includes('car') && result.includes('human') && result.includes('passing')){
			myLineChart.data.datasets[0].data = [];
			myLineChart.data.datasets[1].data = [10000, 30162, 26263, 18394, 18287, 28682, 31274, 33259, 25849, 24159, 32651, 31984, 38451];
			myLineChart.data.datasets[2].data = [];
			myLineChart.data.datasets[3].data = [];
		} else if(result.includes('car') && result.includes('human') && result.includes('passing')) {
			myLineChart.data.datasets[0].data = [10000, 30162, 26263, 18394, 18287, 28682, 31274, 33259, 25849, 24159, 32651, 31984, 38451];
			myLineChart.data.datasets[1].data = [5000, 30162, 13131, 18394, 18287, 28682, 31274, 33259, 25849, 24159, 32651, 31984, 38451];
			myLineChart.data.datasets[2].data = [];
			myLineChart.data.datasets[3].data = [];
		} else {
			myLineChart.data.datasets[0].data = [];
			myLineChart.data.datasets[1].data = [];
			myLineChart.data.datasets[2].data = [];
			myLineChart.data.datasets[3].data = [];
		};
	}else if(result.includes('intrude')){
		if (result.includes('car') && !result.includes('human') && result.includes('intrude')) {
			myLineChart.data.datasets[0].data = [];
			myLineChart.data.datasets[1].data = [];
			myLineChart.data.datasets[2].data = [10000, 30162, 26263, 18394, 18287, 28682, 31274, 33259, 25849, 24159, 32651, 31984, 38451];
			myLineChart.data.datasets[3].data = [];
		} else if(!result.includes('car') && result.includes('human') && result.includes('intrude')){
			myLineChart.data.datasets[0].data = [];
			myLineChart.data.datasets[1].data = [];
			myLineChart.data.datasets[2].data = [];
			myLineChart.data.datasets[3].data = [10000, 30162, 26263, 18394, 18287, 28682, 31274, 33259, 25849, 24159, 32651, 31984, 38451];
		} else if(result.includes('car') && result.includes('human') && result.includes('intrude')) {
			myLineChart.data.datasets[0].data = [];
			myLineChart.data.datasets[1].data = [];
			myLineChart.data.datasets[2].data = [10000, 30162, 26263, 18394, 18287, 28682, 31274, 33259, 25849, 24159, 32651, 31984, 38451];
			myLineChart.data.datasets[3].data = [5000, 30162, 13131, 18394, 18287, 28682, 31274, 33259, 25849, 24159, 32651, 31984, 38451];
		} else {
			myLineChart.data.datasets[0].data = [];
			myLineChart.data.datasets[1].data = [];
			myLineChart.data.datasets[2].data = [];
			myLineChart.data.datasets[3].data = [];
		};
	};
	myLineChart.update();
});