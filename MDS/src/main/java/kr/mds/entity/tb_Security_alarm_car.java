package kr.mds.entity;

import java.math.BigInteger;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class tb_Security_alarm_car {
	private long sac_num;
	private String cctv_id;
	private String car_num;
	private String sac_content;
	private String sac_read;
	private String sac_read_at;
	private String sac_img_link;
	private String u_id;
	private String sac_video_link;
	private int sac_in_count;
	private int sac_out_count;
	private String sac_in_at;
	private String sac_out_at;
}
