package com.kh.cm.mate.controller;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.cm.common.util.PageInfo;
import com.kh.cm.mate.model.service.MateService;
import com.kh.cm.mate.model.vo.Mate;
import com.kh.cm.mate.model.vo.MateReply;
import com.kh.cm.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/mate")
public class MateController {
	
	@Autowired
	private MateService service;
	
	@RequestMapping(value="/list", method = {RequestMethod.GET}) 
	public ModelAndView mateList(ModelAndView model,
				@RequestParam(value="page", required=false, defaultValue="1") int page,
				@RequestParam(value="listlimit", required=false, defaultValue="10") int listLimit) {
			
		List<Mate> mateList = null;
		int mateCount = service.getMateCount();
		
		PageInfo pageInfo = new PageInfo(page, 10, mateCount, listLimit);
				
		mateList= service.getMateList(pageInfo);
				
		model.addObject("mateList", mateList);
		model.addObject("pageInfo", pageInfo);
		model.setViewName("board/mate/mateList");
		
	 return model;
	}
	
	@RequestMapping(value="/list.do", method = {RequestMethod.POST}) 
	public ModelAndView mateSearchList(ModelAndView model,
			@RequestParam(value="page", required=false, defaultValue="1") int page,
			@RequestParam(value="listlimit", required=false, defaultValue="10") int listLimit,
			@RequestParam String search,@RequestParam String keyword) {
		
		List<Mate> mateList = null;
		int mateCount = service.getMateSearchCount(search, keyword);
		
		System.out.println(mateCount);
		
		PageInfo pageInfo = new PageInfo(page, 10, mateCount, listLimit);
		
		
		pageInfo.setSearch(search);
		pageInfo.setKeyword(keyword);
		
		mateList= service.getMateSearchList(pageInfo);
		
		System.out.println(mateList);
		System.out.println(search);
		System.out.println(keyword);
		
		model.addObject("mateList", mateList);
		model.addObject("pageInfo", pageInfo);
		model.setViewName("board/mate/mateList");
		
		return model;
	}
	
	@RequestMapping(value="/write", method = {RequestMethod.GET}) 
	public ModelAndView mateWrite(
			ModelAndView model,
    		@RequestParam(value = "id", defaultValue = "PF172344") String id,
    		@RequestParam(value = "title") String title
			) {
		model.addObject("mt20id", id);
		model.addObject("title", title);
		model.setViewName("board/mate/mateWrite");
		return model;
	}
	
	@RequestMapping(value="/write", method = {RequestMethod.POST}) 
	public ModelAndView mateWrite(ModelAndView model,
			@SessionAttribute(name="loginMember", required=false) Member loginMember,
			 Mate mate) {
		
		int result = 0;
				
		if(loginMember.getUserNick().equals(mate.getUserNick())) {
			mate.setMateWriteId(loginMember.getId());
						
		result = service.saveMate(mate);
		
		if(result > 0) {
			model.addObject("msg", "???????????? ????????? ??????????????????.");
			model.addObject("location", "/mate/list");
		} else {
			model.addObject("msg", "???????????? ????????? ??????????????????.");
			model.addObject("location", "/mate/list");
		}
	} else {
		model.addObject("msg", "????????? ???????????????.");
		model.addObject("location", "/");
		
	}	
		model.setViewName("/common/msg");
		
		return model;
}
	
	 @RequestMapping(value = "/view", method = {RequestMethod.GET})
	    public ModelAndView mateView(HttpServletRequest request, HttpServletResponse response, HttpSession session,
	            @RequestParam int mateId, ModelAndView model,@RequestParam(value="page", required=false, defaultValue="1") int page,
				@RequestParam(value="listlimit", required=false, defaultValue="3") int listLimit) {
		 
		 	Mate mate = service.findMateByMateId(mateId);

			int mateReplyCount = service.getMateReplyCount(mateId);
			
			PageInfo pageInfo = new PageInfo(page, 5, mateReplyCount, 3);
			List<MateReply> mateReplies = service.findMateReplyByMateId(mateId, pageInfo);
	        
	        Cookie[] cookies = request.getCookies();
	        
	        // ???????????? ?????? ????????? ??????
	        Cookie viewCookie = null;
	 
	        // ????????? ?????? ?????? 
	        if (cookies != null && cookies.length > 0) 
	        {
	            for (int i = 0; i < cookies.length; i++)
	            {
	                // Cookie??? name??? cookie + reviewNo??? ???????????? ????????? viewCookie??? ????????? 
	                if (cookies[i].getName().equals("cookie"+mateId))
	                { 
	                    System.out.println("?????? ????????? ????????? ??? ?????????.");
	                    viewCookie = cookies[i];
	                }
	            }
	        }
	        
	        if (mate != null) {
	            System.out.println("System - ?????? ?????? ???????????? ?????????");
	            
	            model.addObject("mate", mate);
	            model.addObject("mateReplies", mateReplies);
				model.addObject("pageInfo", pageInfo);
	 
	            // ?????? viewCookie??? null??? ?????? ????????? ???????????? ????????? ?????? ????????? ?????????.
	            if (viewCookie == null) {    
	                System.out.println("cookie ??????");
	                
	                // ?????? ??????(??????, ???)
	                Cookie newCookie = new Cookie("cookie" + mateId, "|" + mateId + "|");
	                                
	                // ?????? ??????
	                response.addCookie(newCookie);
	 
	                // ????????? ?????? ????????? ????????? ????????????
	//                int result = bService.viewUp(reviewNo);
	                
	                boolean updateMateCount = service.updateMateCount(mateId);
	                if(updateMateCount == true) {
	                    System.out.println("????????? ??????");
	                }else {
	                    System.out.println("????????? ?????? ??????");
	                }
	            }
	            // viewCookie??? null??? ???????????? ????????? ???????????? ????????? ?????? ????????? ???????????? ??????.
	            else {
	                System.out.println("cookie ??????");
	                
	                // ?????? ??? ?????????.
	                String value = viewCookie.getValue();
	                
	                System.out.println("cookie ??? : " + value);
	        
	            } 
	            model.setViewName("/board/mate/mateView");
	            return model;
	        } else {
	        	
	        }	        
	        model.setViewName("/board/mate/mateView");
	        return model;
	    }

	@RequestMapping(value="/update", method = {RequestMethod.GET}) 
	public ModelAndView mateUpdateView(ModelAndView model, @RequestParam("mateId") int mateId) {
		Mate mate = service.findMateByMateId(mateId);
		
		model.addObject("mate", mate);
		model.setViewName("/board/mate/mateUpdate");
		
		return model;
	}
	

	@RequestMapping(value="/update", method = {RequestMethod.POST}) 
	public ModelAndView shareUpdate(@SessionAttribute(name = "loginMember", required=false) Member loginMember, Mate mate, ModelAndView model) {
		
		int result = 0;
		if(loginMember.getUserNick().equals(loginMember.getUserNick())) {
			
			result = service.saveMate(mate);
			
			if(result > 0) {
				model.addObject("msg", "???????????? ??????????????? ?????????????????????.");
				model.addObject("location", "/mate/view?mateId=" + mate.getMateId());
			} else {
				model.addObject("msg", "????????? ????????? ?????????????????????.");
				model.addObject("location", "/mate/list");
			}
		} else {
			model.addObject("msg", "????????? ???????????????.");
			model.addObject("location", "/");
		}
		model.setViewName("common/msg");
				
		return model;
	}
	
	@RequestMapping(value ="/delete", method ={RequestMethod.GET})
	private ModelAndView delete(ModelAndView model, @RequestParam("mateId") int mateId ) {
		int result = 0;
		
		result = service.deleteMate(mateId);
		
		if(result > 0) {
			model.addObject("msg", "???????????? ?????????????????????.");
			model.addObject("location", "/mate/list");
		} else {
			model.addObject("msg", "????????? ????????? ??????????????????.");
			model.addObject("location", "/");
		}
		model.setViewName("common/msg");
		
		return model;
	}
	
	@RequestMapping(value = "/reply/write", method={RequestMethod.POST})
	public ModelAndView writeReply(@SessionAttribute(name = "loginMember", required=false) Member loginMember,
				@RequestParam(name ="mateId") int mateId,@RequestParam(name ="writer") String writer,
				@RequestParam(name ="content") String content, MateReply mateReply,
				ModelAndView model) {
		int result = 0;
		
		if(loginMember.getUserNick().equals(writer)) {
			mateReply.setMateId(mateId);
			mateReply.setMateReplyContent(content);
			mateReply.setMateReplyWriteId(loginMember.getId());
			
			result = service.saveMateReply(mateReply);

			if(result > 0) {
				model.addObject("msg", "?????? ????????? ??????????????????.");
				model.addObject("location", "/mate/view?mateId=" + mateReply.getMateId());
			} else {
				model.addObject("msg", "?????? ????????? ??????????????????.");
				model.addObject("location", "/mate/list");
				
			}
		} else {
			model.addObject("msg", "????????? ???????????????.");
			model.addObject("location", "/mate/list");
		}
		
		model.setViewName("common/msg");
		return model;
	}
	
	
	
	@RequestMapping(value="/reply/reWrite", method = {RequestMethod.GET}) 
	public ModelAndView reWriteReply(@RequestParam(name = "mateReplyId")int mateReplyId, ModelAndView model) {
		MateReply mateReply = service.findMateReplyByMateReplyId(mateReplyId);
		
		model.addObject("mateReply", mateReply);
		model.setViewName("/board/mate/mateReplyReWrite");
		return model;
	}
	
	@RequestMapping(value = "/reply/reWrite", method={RequestMethod.POST})
	@ResponseBody
	public String reWriteReply(@SessionAttribute(name = "loginMember", required=false) Member loginMember,
			@RequestParam(name ="mateReplyId") int mateReplyId,@RequestParam(name ="mateId") int mateId,
			@RequestParam(name ="writer") String writer,
			@RequestParam(name ="content") String content, MateReply mateReply) {
		
		int result = 0;
		String resultMsg = null;
		
		if(loginMember.getUserNick().equals(writer)) {
			mateReply.setMateId(mateId);
			mateReply.setMateReplyContent(content);
			mateReply.setMateReplyWriteId(loginMember.getId());
			mateReply.setMateReplyGroup(mateReplyId);
			
			System.out.println(mateReplyId);
			
			result = service.saveMateReReply(mateReply);
			
			if(result > 0) {
				resultMsg="<script>opener.parent.location.reload(); window.close();</script>";
			} else {
				resultMsg="<script>opener.parent.location.reload(); window.close();</script>";
				
			}
		}
			
		return resultMsg;
	}
	
	@RequestMapping(value ="/reply/delete", method ={RequestMethod.GET})
	public ModelAndView deleteReReply(ModelAndView model, @RequestParam(name="mateReplyId") int mateReplyId
			, @RequestParam(name="mateId") int mateId) {
		int result = 0;
		
		result = service.deleteMateReply(mateReplyId);
		
		if(result > 0) {
			
			model.addObject("msg", "????????? ?????????????????????.");
			model.addObject("location", "/mate/view?mateId=" + mateId);
		} else {
			model.addObject("msg", "?????? ????????? ??????????????????.");
			model.addObject("location", "/mate/list");
		}
		model.setViewName("common/msg");
		
		return model;
	}
	
}
