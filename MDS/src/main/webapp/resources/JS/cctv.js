
var client = new WebSocket('ws://localhost:9999');
  var canvas = document.querySelector('canvas');
  var player = new jsmpeg(client, {
    canvas: canvas 
  });

const Stream = require('node-rtsp-stream');
const streamUrl = "${list.rtsp_address}"; // rtsp 영상 주소가 없다면 아래 첨부해놓은 주소 쓰면됨

stream = new Stream({
  name: 'foscam_stream',
  streamUrl: streamUrl,
  wsPort: 9999, // 10000이나 10001 등으로 안겹칠만한 포트번호로 설정하면 된다.
  width: 640,
  height: 480
});