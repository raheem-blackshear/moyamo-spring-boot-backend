package net.infobank.moyamo.form;

import lombok.Builder;
import lombok.Data;
import net.infobank.moyamo.enumeration.MailType;

@Data
@Builder
public class CreateMailVo {
	private String nickName;
	private String email;
	private String authKey;
	private String password;
	private String title;
	private MailType type;

	private String template;
	private String templateUrl;
	private String subject;
}
