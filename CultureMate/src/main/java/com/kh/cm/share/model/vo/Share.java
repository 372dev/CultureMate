package com.kh.cm.share.model.vo;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Share {
	private int shareId;
	
	private int shareWriteId;
	
	private int id;
	
	private String userNick;
	
	private String shareTitle;
	
	private String shareShow;
	
	private String shareContent;
	
	private String shareOpen;
	
	private String shareOriginalFileName;
	
	private String shareRenamedFileName;
	
	private Date shareCreateDate;
	
	private Date shareModifyDate;
	
	private List<ShareReply> shareReplies;
	
	private String shareStatus;
	
	private int shareCount;
	
}
