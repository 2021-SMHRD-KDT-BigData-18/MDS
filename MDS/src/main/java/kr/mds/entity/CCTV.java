package kr.mds.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class CCTV {
	private String u_id;
	private String rtsp_address;
	private String cctv_loc;
	private String cctv_id;
}
