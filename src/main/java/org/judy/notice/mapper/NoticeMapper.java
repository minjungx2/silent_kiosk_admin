package org.judy.notice.mapper;

import java.util.List;

import org.judy.common.util.NoticeFileDTO;
import org.judy.common.util.PageDTO;
import org.judy.notice.domain.Notice;

public interface NoticeMapper {
	
	List<Notice> getList(PageDTO pageDTO);
	
	List<Notice> topList();
	
	Notice getOne(Integer nno);
	
	void insert(Notice vo);
	
	int getTotal(PageDTO pageDTO);
	
	void delete(Integer nno);
	
	int insertSelectKey(Notice vo);
	
	void update(Notice vo);

	NoticeFileDTO getThumb(Integer nno);

}
