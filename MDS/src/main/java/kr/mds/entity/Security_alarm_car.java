package kr.mds.entity;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Security_alarm_car {
	private int sac_num;
	private String cctv_id;
	private String car_num;
	private Date car_inout_at;
	private String alarm_content;
	private Date alarm_at;
	private String alarm_read;
	private Date alarm_read_at;
	private String car_img_link;
	
}
