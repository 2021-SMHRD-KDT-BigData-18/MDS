package kr.mds.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class User {
	private String user_id;
	private String user_pw;
	private String user_name;
	private String user_email;
	private String user_farm_address;
	private String user_sa_onoff;
}
