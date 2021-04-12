package org.judy.notice.dto;

import static org.hamcrest.CoreMatchers.notNullValue;

import java.sql.Date;
import java.util.ArrayList;

import org.judy.common.util.NoticeFileDTO;
import org.junit.validator.ValidateWith;
import org.springframework.validation.annotation.Validated;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class NoticeDTO {
	
	private Integer nno;
	private String title;
	private String content;
	private String writer;
	private Boolean show;
	private String category;
	private boolean img;
	private boolean file;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd")
	private Date regdate, updatedate;
	private ArrayList<NoticeFileDTO> list;

}
