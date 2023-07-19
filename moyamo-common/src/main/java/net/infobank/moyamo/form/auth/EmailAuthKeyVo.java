package net.infobank.moyamo.form.auth;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

@Data
@EqualsAndHashCode(callSuper = false)
@NoArgsConstructor
@AllArgsConstructor
public class EmailAuthKeyVo{
	@NotBlank(message = "이메일 주소를 입력해 주세요.")
	@NotNull
    @Email(message = "메일의 양식을 지켜주세요.")
	String email;

}
