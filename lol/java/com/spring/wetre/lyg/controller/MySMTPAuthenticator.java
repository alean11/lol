package com.spring.wetre.lyg.controller;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class MySMTPAuthenticator extends Authenticator {

	@Override
	public PasswordAuthentication getPasswordAuthentication() {
		
		// Gmail 인 경우 @gmail.com 을 제외한 아이디만 입력한다.
		return new PasswordAuthentication("aleanlol101","dldudwls!5");
	}
	
}
