const Stream = require('node-rtsp-stream');


const streamUrl1 = "rtsp://210.99.70.120:1935/live/cctv004.stream"; // rtsp 영상 주소가 없다면 아래 첨부해놓은 주소 쓰면됨
stream1 = new Stream({
  name: 'foscam_stream',
  streamUrl: streamUrl1,
  wsPort: 9999, // 10000이나 10001 등으로 안겹칠만한 포트번호로 설정하면 된다.
  width: 720,
  height: 480
});

const streamUrl2 = "rtsp://210.99.70.120:1935/live/cctv001.stream"; // rtsp 영상 주소가 없다면 아래 첨부해놓은 주소 쓰면됨
stream1 = new Stream({
  name: 'foscam_stream',
  streamUrl: streamUrl2,
  wsPort: 10000, // 10000이나 10001 등으로 안겹칠만한 포트번호로 설정하면 된다.
  width: 640,
  height: 480
});


const streamUrl3 = "rtsp://210.99.70.120:1935/live/cctv033.stream"; // rtsp 영상 주소가 없다면 아래 첨부해놓은 주소 쓰면됨
stream1 = new Stream({
  name: 'foscam_stream',
  streamUrl: streamUrl3,
  wsPort: 10001, // 10000이나 10001 등으로 안겹칠만한 포트번호로 설정하면 된다.
  width: 640,
  height: 480
});

const streamUrl4 = "rtsp://210.99.70.120:1935/live/cctv030.stream"; // rtsp 영상 주소가 없다면 아래 첨부해놓은 주소 쓰면됨
stream1 = new Stream({
  name: 'foscam_stream',
  streamUrl: streamUrl4,
  wsPort: 10002, // 10000이나 10001 등으로 안겹칠만한 포트번호로 설정하면 된다.
  width: 640,
  height: 480
});

