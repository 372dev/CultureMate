package com.kh.cm.member.model.service;


import java.util.List;

import javax.mail.MessagingException;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.cm.common.util.PageInfo;
import com.kh.cm.member.model.dao.MemberDao;
import com.kh.cm.member.model.vo.MailHandler;
import com.kh.cm.member.model.vo.Member;
import com.kh.cm.member.model.vo.TempKey;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private JavaMailSender mailSender;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;	
	
	
	// 로그인
	@Override
	public Member login(String userId, String password) {
		Member loginMember = memberDao.selectMember(userId);
		
		System.out.println("Impl loginMember : " + loginMember);
		
		return loginMember != null && passwordEncoder.matches(password, loginMember.getPassword()) ? loginMember : null;
	}

	@Override
	public Member findMemberByUserId(String userId) {
		return memberDao.selectMember(userId);
	}

	// 회원가입	
	@Override
	@Transactional
	public int saveMember(Member member) {
		int result = 0;
		
		member.setPassword(passwordEncoder.encode(member.getPassword()));
		
		result = memberDao.insertMember(member);
		
		try {
			sendMail(member);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}
	
	// 이메일 보내기
	@Override
	public void sendMail(Member member) throws Exception{
		String key = new TempKey().getKey(); // 인증키 생성
		member.setAuthkey(key);
		
		log.info("key : " + key);
		
		memberDao.updateAuthkey(member);
		
		MailHandler sendMail = new MailHandler(mailSender);
        sendMail.setSubject("[컬쳐메이트] 회원가입 이메일 인증");
        sendMail.setText(new StringBuffer().append("<h2>컬쳐메이트를 이용해주셔서 감사합니다!</h2>")
        		.append("<h3>회원가입을 아래 링크를 눌러 마무리 해주세요~!</h3>")
                .append("<a href='http://localhost:8088/cm/emailConfirm?userId=")
                .append(member.getUserId())
                .append("&authkey=")
                .append(key)
                .append("' target='_blank'>컬쳐메이트 이메일 인증하러 가기~!</a>")
                .toString());
        
        sendMail.setFrom("CultureMate", "컬쳐메이트");
        sendMail.setTo(member.getEmail());
        sendMail.send();
	}
	

	@Override
	public Member userAuth(String userId, String authkey) {
		Member member = memberDao.selectMember(userId);
		member = memberDao.checkAuth(authkey); // 이메일 인증 코드 확인
		log.info(member.getUserId());
		
		if(userId != null) {
			try {
				memberDao.successAuthkey(member); // 인증 후 계정 활성화
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return member;
	}

	// 회원탈퇴
	@Override
	public int deleteMember(String userId) {
		return memberDao.deleteMember(userId);
	}

	// 아이디 찾기
	@Override
	public String findId(String userName, String email, String phone) {
		String result = memberDao.findId(userName, email, phone);

		return result;
	}

	// 비밀번호 찾기 - 이메일로 임시 비밀번호 발급
	@Override
	public void findPwd(String userId, String email, String phone) throws Exception {
		Member member = memberDao.selectMember(userId);
		String tempPwd = new TempKey().getKey();
		
		member.setPassword(passwordEncoder.encode(tempPwd));
		memberDao.updateTempPwd(userId, email, phone, member.getPassword());
		
		log.info("비밀번호 찾기: " + userId + ", " + email + ", " + phone);
		
		
		MailHandler sendMail = new MailHandler(mailSender);
        sendMail.setSubject("[컬쳐메이트] 임시 비밀번호가 발급되었습니다.");
        
		sendMail.setText(new StringBuffer().append("<h2>안녕하세요 ")
				.append(member.getUserName())
				.append(" 님, 컬쳐메이트를 이용해주셔서 감사합니다!</h2><br><br>")
				.append("<h4>회원님의 임시 비밀번호는'")
		        .append(tempPwd)
		        .append("'이며 로그인 후 보안을 위해 꼭 비밀번호를 변경해주세요~<br>")
		        .append("<a href='http://localhost:8088/cm/'>컬쳐메이트 접속</a></h4>")
		        .toString());
			
		sendMail.setFrom("CultureMate", "컬쳐메이트");
		sendMail.setTo(member.getEmail());
		sendMail.send();
	}


	// 비밀번호 변경
	@Override
	public int changePwd(String userId, String password) {
		int result = 0;
		log.info(password);
		password = passwordEncoder.encode(password);
		
		result = memberDao.updatePassword(userId, password);
		
		return result;
	}

	// 아이디 중복 체크
	@Override
	public int validate(String userId) {
		return memberDao.validate(userId);
	}

	// 회원정보 수정
	@Override
	public int updateMember(Member member, String password) {
		return passwordEncoder.matches(password, member.getPassword()) ? memberDao.updateMember(member) : 0;
	}

	//모든 멤버 수 조회
	@Override
	public int memberAllCount() {
	
		return memberDao.selectMemberCount();
	}

	//모든멤버 리스트 조회
	@Override
	public List<Member> getMemberList(PageInfo pageInfo) {
		
		return memberDao.selectMemberList(pageInfo);
	}

	// 멤버 모든멤버정보 상세조회
	@Override
	public Member findMember(String userId) {
		
		return memberDao.allfindMemberDetail(userId);
	}

	// 관리자가 멤버 정보수정
	@Override
	public int adminupdateMember(Member member) {
          int result = 0;
		
		passwordEncoder.encode(member.getPassword());
		
		result = memberDao.allfindMemberUpdate(member);
		
		return result;
	}

	// 관리자가 멤버삭제
	@Override
	public int admindeleteMember(String userId) {
		
		return memberDao.admindeleteMember(userId);
	}

	//관리자페이지에서 검색
	@Override
	public int memberSearchCount(String search, String keyword) {
		
		return memberDao.selectmemSearchCount(search, keyword);
	}

	// 관리자페이에서 검색 후 리스트
	@Override
	public List<Member> memberSearchList(PageInfo pageInfo) {
		int offset = (pageInfo.getCurrentPage() - 1) * pageInfo.getListLimit();
		RowBounds rowBounds = new RowBounds(offset, pageInfo.getListLimit());
		
		return memberDao.selectmemSearchList(rowBounds, pageInfo);
	}
//
//	@Override
//	public List<Member> getrankList() {
//
//		return memberDao.selectRankLsit();
//	}

	@Override
	public List<Member> getrankList() {
	
		return memberDao.selectRankLsit();
	}




	

	





}
