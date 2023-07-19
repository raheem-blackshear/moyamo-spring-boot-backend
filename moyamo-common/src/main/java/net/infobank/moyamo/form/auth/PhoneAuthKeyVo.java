package net.infobank.moyamo.form.auth;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

@Data
@EqualsAndHashCode(callSuper = false)
@NoArgsConstructor
@AllArgsConstructor
public class PhoneAuthKeyVo{
	@NotBlank
	@NotNull
    //@Pattern(message = ValidationPattern.PATTERN_PASSWORD_MESSAGE, regexp = ValidationPattern.PATTERN_PASSWORD_REGEXP)
	String phone;

}
