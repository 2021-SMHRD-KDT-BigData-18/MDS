package kr.mds.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class tb_CCTV1 {
	private String cctv_id;
	private String u_id;
	private String rtsp_address;
	private String cctv_loc;
	private String rtsp_address2;
}
