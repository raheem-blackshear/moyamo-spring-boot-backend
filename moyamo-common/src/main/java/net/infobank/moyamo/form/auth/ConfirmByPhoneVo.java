package net.infobank.moyamo.form.auth;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;

@Data
@EqualsAndHashCode(callSuper = false)
@NoArgsConstructor
@AllArgsConstructor
public class ConfirmByPhoneVo{
	@NotBlank
	String authId;
	@NotBlank
	String nickName;
}
