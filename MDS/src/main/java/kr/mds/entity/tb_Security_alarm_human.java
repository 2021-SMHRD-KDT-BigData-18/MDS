package kr.mds.entity;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class tb_Security_alarm_human {
	private int sah_num;
	private String cctv_id;
	private String sah_content;
	private Date sah_at;
	private String sah_read;
	private Date sah_read_at;
	private String human_img_link;
	private int sah_total;
	private String u_id;
}
