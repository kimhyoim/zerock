package org.zerock.controller;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.BoardVO;
import org.zerock.service.BoardService;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class BoardServiceTest {
	
	@Inject
	private BoardService bs;
	
	private Logger logger = LoggerFactory.getLogger(BoardServiceTest.class);

	
//	public void testRegist() throws Exception {
//		BoardVO board = new BoardVO();
//		board.setTitle("service test");
//		board.setContent("service is working");
//		board.setWriter("kim");
//		
//		bs.regist(board);
//	}
	
	@Test
	public void testRead() throws Exception {
		
		BoardVO board = bs.read(2);
		
		
	}

}
