var ctx = document.getElementById("myBarChart");
var mySquareChart = new Chart(ctx, {
  type: 'bar',
  data: {
    labels: ["January", "February", "March", "April", "May", "June"],
    datasets: [{
      label: "Revenue",
      backgroundColor: "rgba(201, 34, 28,1)",
      borderColor: "rgba(201, 34, 28,1)",
      data: [],
    },
    {
      label: "Revenue",
      backgroundColor: "rgba(247, 164, 20,1)",
      borderColor: "rgba(247, 164, 20,1)",
      data: [],
    },
    {
      label: "Revenue",
      backgroundColor: "rgba(201, 34, 28,1)",
      borderColor: "rgba(201, 34, 28,1)",
      data: [],
    },
    {
      label: "Revenue",
      backgroundColor: "rgba(247, 164, 20,1)",
      borderColor: "rgba(247, 164, 20,1)",
      data: [],
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
          maxTicksLimit: 6
        }
      }],
      yAxes: [{
        ticks: {
          min: 0,
          max: 15000,
          maxTicksLimit: 5
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
			mySquareChart.data.datasets[0].data = [1000, 2000, 3000, 8000, 12000, 14000];
			mySquareChart.data.datasets[1].data = [];
			mySquareChart.data.datasets[2].data = [];
			mySquareChart.data.datasets[3].data = [];
		} else if(!result.includes('car') && result.includes('human') && result.includes('passing')){
			mySquareChart.data.datasets[0].data = [];
			mySquareChart.data.datasets[1].data = [1000, 2000, 3000, 8000, 12000, 14000];
			mySquareChart.data.datasets[2].data = [];
			mySquareChart.data.datasets[3].data = [];
		} else if(result.includes('car') && result.includes('human') && result.includes('passing')) {
			mySquareChart.data.datasets[0].data = [14000, 12000, 8000, 3000, 2000, 1000];
			mySquareChart.data.datasets[1].data = [1000, 2000, 3000, 8000, 12000, 14000];
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
			mySquareChart.data.datasets[2].data = [1000, 2000, 3000, 8000, 12000, 14000];
			mySquareChart.data.datasets[3].data = [];
		} else if(!result.includes('car') && result.includes('human') && result.includes('intrude')){
			mySquareChart.data.datasets[0].data = [];
			mySquareChart.data.datasets[1].data = [];
			mySquareChart.data.datasets[2].data = [];
			mySquareChart.data.datasets[3].data = [1000, 2000, 3000, 8000, 12000, 14000];
		} else if(result.includes('car') && result.includes('human') && result.includes('intrude')) {
			mySquareChart.data.datasets[0].data = [];
			mySquareChart.data.datasets[1].data = [];
			mySquareChart.data.datasets[2].data = [14000, 12000, 8000, 3000, 2000, 1000];
			mySquareChart.data.datasets[3].data = [1000, 2000, 3000, 8000, 12000, 14000];
		} else {
			mySquareChart.data.datasets[0].data = [];
			mySquareChart.data.datasets[1].data = [];
			mySquareChart.data.datasets[2].data = [];
			mySquareChart.data.datasets[3].data = [];
		};
	};
	mySquareChart.update();
});