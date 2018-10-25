package org.zerock.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

/**
 * 
 * @author HyoimKIM
 * ControllerAdvice Ŭ������ �޼ҵ�� �߻��� Exception ��ü�� Ÿ�Ը��� �Ķ���ͷ� ��밡��.
 * �Ϲ� Controller���� Model�� �Ķ���ͷ� ����ϴ� ���� �������� �ʾ� ModelAndViewŸ���� ����ϴ� ���·� ��������
 * views������ �־���°��� ����.
 */

@ControllerAdvice
public class CommonExceptionAdvice {
	
	private static final Logger logger = LoggerFactory.getLogger(CommonExceptionAdvice.class);
	
	@ExceptionHandler(Exception.class)
	public ModelAndView errorModelAndView(Exception ex) {
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/error_common");
		modelAndView.addObject("exception", ex);
		
		return modelAndView;
	}
	
//	public String common(Exception e) {
//		logger.info(e.toString());
//		
//		return "error_common";
//	}

}