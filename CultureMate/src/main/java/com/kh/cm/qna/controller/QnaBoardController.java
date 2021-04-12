package com.kh.cm.qna.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.ModelAndView;

import com.kh.cm.cs.model.vo.CsBoard;
import com.kh.cm.member.model.vo.Member;
import com.kh.cm.qna.model.service.QnaBoardService;
import com.kh.cm.qna.model.vo.QnaBoard;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/help")
public class QnaBoardController {
	@Autowired
	private QnaBoardService service;
	
	
	@RequestMapping(value = "/qnalist", method = {RequestMethod.GET})
	public ModelAndView qnalist(
			ModelAndView model,
			@SessionAttribute(name = "loginMember", required = false) Member loginMember) {
		
		List<QnaBoard> list = null;
		int boardCount = service.getqnaBoardCount();
		
		System.out.println(boardCount);
	
		list = service.getqnaBoardList();
		
		model.addObject("qnalist", list);
		model.setViewName("help/qnalist");
		
		return model;
}
	@RequestMapping(value = "/qnacontent", method = {RequestMethod.GET})
	public void qnacontentView() {
		
	}
	@RequestMapping(value = "/qnacontent", method = {RequestMethod.POST})
	public ModelAndView qnacontent (
			@SessionAttribute(name = "loginMember", required = false) Member loginMember, QnaBoard qnaboard,
			HttpServletRequest request,
			ModelAndView model) {

		int result =0;
		
		if(loginMember.getUserId().equals(qnaboard.getUserId())) {
			qnaboard.setQnaWriterNo(loginMember.getId());
			
			System.out.println(qnaboard);
		}
		
		result = service.saveqnaBoard(qnaboard);
		
		 if (result>0) { // 리절트가 만족하면 게시글이 정상적으로 등록되었습니다.
			  model.addObject("msg", "게시글이 정상적으로 등록되었습니다.");
			  model.addObject("loaction", "/help/qnalist");
		}else {
			model.addObject("msg", "게시글 등록을 실패하였습니다.");
			model.addObject("loaction", "/help/qnalist");
		}
		
	
	   model.setViewName("common/msg");
		
		return model;
	}
	@RequestMapping(value = "qnaview", method = {RequestMethod.GET})
	public ModelAndView qnaview(@RequestParam("qnaId") int qnaId, ModelAndView model) {
		QnaBoard qnaboard = service.findqnaBoardById(qnaId);
		
		model.addObject("qnaboard", qnaboard);
		model.setViewName("help/qnaview");
		
		return model;
	}
}