  // 가격 데이터 배열
    var price = [0, -95, -30, -65, -35, -215, -95, -70, -115];

    /* 미래 사용을 위한 데이터 파싱 함수 */
    function updatePrice() {
      var inputPrices = $('#values').val();
      var priceArr = inputPrices.split(',');
      price = priceArr;
      for (i = 0; i < priceArr.length; i++) {
        var parsedPrice = parseInt(priceArr[i]);
        function isNeg(parsedPrice) {
          if (parsedPrice > 0) {
            parsedPrice *= -1;
            return parsedPrice;
          } else {
            parsedPrice = 0;
            return parsedPrice;
          }
        }
        price[i] = isNeg(parsedPrice);
      }
      console.log(price);
    }

    // 차트 값 설정
    var chartH = $('#svg').height();
    var chartW = $('#svg').width();

    // 가격을 SVG의 하단에 맞추기 위해 값을 변환
    var prices = [];
    for (i = 0; i < price.length; i++) {
      prices[i] = price[i] + $('#svg').height();
    }

    function draw() {
      // Snap.svg를 정의하고 스텝 수 계산
      var paper = Snap('#svg');
      var steps = prices.length;

      // X축 방향으로 점들을 균등하게 배치하는 함수
      function step(i, chartW) {
        return chartW / prices.length * i;
      }

      var points = [];
      var breakPointsX = [];
      var breakPointsY = [];
      var point = {};

      for (i = 1; i < prices.length; i++) {
        // 현재 지점 계산
        var currStep = step(i, chartW);
        var y = prices[i];
        point.x = Math.floor(currStep);
        point.y = y;

        // 이전 지점 계산
        var prev = i - 1;
        var prevStep = step(prev, chartW);
        var prevY = prices[prev];
        point.prevX = Math.floor(prevStep);
        point.prevY = prevY;
        if (point.prevX === 0 || point.prevY === 0) {
          point.prevX = 15;
          point.prevY = chartH - 15;
        }
        // 경로를 배열에 저장
        points[i] = " M" + point.prevX + "," + point.prevY + " L" + point.x + "," + point.y;

        // 브레이크포인트 위치를 저장
        var r = 30;
        breakPointsX[i] = point.x;
        breakPointsY[i] = point.y;
      }

      // 라인 그리기
      for (i = 0; i < points.length; i++) {
        var myPath = paper.path(points[i]);
        var len = myPath.getTotalLength();
        myPath.attr({
          'stroke-dasharray': len,
          'stroke-dashoffset': len,
          'stroke': 'white',
          'stroke-linecap': 'round',
          'stroke-width': 4,
          'stroke-linejoin': 'round',
          'id': 'myLine' + i,
          'class': 'line'
        });
      }

      // 브레이크포인트 그리기
      for (i = 0; i < points.length; i++) {
        var circle = paper.circle(breakPointsX[i], breakPointsY[i], 5);
        circle.attr({
          'fill': '#FF4864',
          'stroke': 'white',
          'stroke-width': 3,
          'id': 'myCirc' + i,
          'class': 'breakpoint'
        });
      }

      // 좌표축 그리기
      var xAxis = paper.path('M0,' + chartH + 'L' + chartW + "," + chartH);
      var yAxis = paper.path('M0,' + chartH + 'L0,0');

      var xOff = xAxis.getTotalLength();
      var yOff = yAxis.getTotalLength();
      var start = (prices.length * 250 + "ms");

      yAxis.attr({
        'stroke': 'white',
        'stroke-width': 1,
        'stroke-dasharray': yOff,
        'stroke-dashoffset': yOff,
        'id': 'yAxis'
      });
      xAxis.attr({
        'stroke': 'white',
        'stroke-width': 1,
        'stroke-dasharray': xOff,
        'stroke-dashoffset': xOff,
        'id': 'xAxis'
      });

      console.log(start);
      $('#yAxis').css({
        '-webkit-transition-delay': start,
        '-webkit-transition': 'all 200ms ease-in'
      });
      $('#xAxis').css({
        '-webkit-transition-delay': start,
        '-webkit-transition': 'all 200ms ease-in'
      });

      $('#xAxis').animate({
        'stroke-dashoffset': '0'
      });
      $('#yAxis').animate({
        'stroke-dashoffset': '0'
      });
    }

    function animate() {
      for (i = 0; i < prices.length; i++) {
        var circ = $('#myCirc' + i);
        var line = $('#myLine' + i);
        circ.css({
          '-webkit-transition': 'all 550ms cubic-bezier(.84,0,.2,1)',
          '-webkit-transition-delay': 375 + (i * 125) + "ms"
        });
        line.css({
          '-webkit-transition': 'all 250ms cubic-bezier(.84,0,.2,1)',
          '-webkit-transition-delay': i * 125 + "ms"
        });
        line.animate({
          'stroke-dashoffset': 0
        });
        circ.css({
          'transform': 'scale(1)'
        });
      }
    }



    // 창 로드 시 차트 그리기와 애니메이션 실행
    $(window).load(function () {
      draw();
      animate();
    });

    // '차트 그리기' 버튼 클릭 시 차트 다시 그리기와 애니메이션 실행
    $('#draw').on('click', function () {
      $('#svg').empty();
      draw();
      animate();
    });