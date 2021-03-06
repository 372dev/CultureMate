package com.kh.cm.qna.model.service;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.cm.common.util.PageInfo;
import com.kh.cm.cs.model.vo.CsBoard;
import com.kh.cm.qna.model.dao.QnaBoardDao;
import com.kh.cm.qna.model.vo.QnaBoard;
import com.kh.cm.qna.model.vo.QnaReply;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class QnaBoardServiceImpl implements QnaBoardService {

	@Autowired
	private QnaBoardDao qnaboardDao;

	@Override
	@Transactional
	public int saveqnaBoard(QnaBoard qnaboard) {
		int result =0;
	
		if(qnaboard.getQnaId() != 0) {
			result = qnaboardDao.updateqnaBoard(qnaboard);
		}else {
			result = qnaboardDao.insertqnaBoard(qnaboard);
		}
		return result;
	}

	@Override
	public int getqnaBoardCount() {
		
		return qnaboardDao.selectCount();
	}

	@Override
	public List<QnaBoard> getqnaBoardList(PageInfo pageInfo) {
		int offset = (pageInfo.getCurrentPage() - 1) * pageInfo.getListLimit();
		RowBounds rowBounds = new RowBounds(offset, pageInfo.getListLimit());
		
		return qnaboardDao.selectqnaBoardList(rowBounds);
	}

	@Override
	public QnaBoard findqnaBoardById(int qnaId) {

		return qnaboardDao.selectqnaBoardDetail(qnaId);
	}

	@Override
	public int addreply(QnaReply qnareply) {
		
		return qnaboardDao.insertqnaReply(qnareply);
	}

	@Override
	public int deleteQna(int qnaId) {
		return qnaboardDao.deleteQna(qnaId);
	}

	@Override
	public int saveQnaReply(QnaReply qnareply) {
   
	    return qnaboardDao.insertQnaReply(qnareply);
		} 
			

	@Override
	public List<QnaReply> getqnaReplyList(int qnaId) {
		
		return qnaboardDao.selectqnaReplyList(qnaId);
	}

	@Override
	public int delReply(int qnaReId) {
		
		return qnaboardDao.delReply(qnaReId);
	}

	@Override
	public List<QnaReply> findReplyWriter(int no) {
		
		return qnaboardDao.findUserId(no);
	}

	@Override
	public int countReview(int replyWriterNo) {

		return qnaboardDao.countReply(replyWriterNo);
	}




	
	




	

	

	

	

	
	
}
