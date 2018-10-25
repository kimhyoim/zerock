package org.zerock.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

/**
 * 
 * @author HyoimKIM
 * ControllerAdvice 클래스의 메소드는 발생한 Exception 객체의 타입만을 파라미터로 사용가능.
 * 일반 Controller같이 Model을 파라미터로 사용하는 것을 지원하지 않아 ModelAndView타입을 사용하는 형태로 만들어야함
 * views폴더에 넣어놓는것이 좋다.
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
