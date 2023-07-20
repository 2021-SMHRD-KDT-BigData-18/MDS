package kr.mds.entity;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class tb_Security_alarm_car {
	private int sac_num;
	private String cctv_id;
	private String car_num;
	private Date car_inout_at;
	private String sac_content;
	private Date sac_at;
	private String sac_read;
	private Date sac_read_at;
	private String car_img_link;
	private String u_id;
}
