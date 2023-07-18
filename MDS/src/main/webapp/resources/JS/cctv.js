
var client = new WebSocket('ws://localhost:9999');
  var canvas1 = document.getElementById('video1');
  var canvas2 = document.getElementById('video2');
  var player = new jsmpeg(client, {
    canvas: canvas1
  });

const Stream = require('node-rtsp-stream');
const streamUrl1 = "${list.rtsp_address}"; // rtsp 영상 주소가 없다면 아래 첨부해놓은 주소 쓰면됨
const streamUrl2 = "${list.rtsp_address2}"; // rtsp 영상 주소가 없다면 아래 첨부해놓은 주소 쓰면됨

stream = new Stream({
  name: 'foscam_stream',
  streamUrl: streamUrl1,
  wsPort: 9999, // 10000이나 10001 등으로 안겹칠만한 포트번호로 설정하면 된다.
  width: 640,
  height: 480
});


