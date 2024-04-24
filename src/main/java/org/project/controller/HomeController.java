package org.project.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.project.domain.Criteria;
import org.project.service.Album.AlbumService;
import org.project.service.Board.BoardService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class HomeController {
	@Setter(onMethod_=@Autowired)
	private BoardService bservice;
	
	@Setter(onMethod_=@Autowired)
	private AlbumService alservice;
	
    private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

    /* ����Ÿ��_String*/    
    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String home(Locale locale, Criteria cri, Model model) {
        logger.info("Welcome YH Project! The client locale is {}.", locale);        
        String formDate = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale).format(new Date());        
        model.addAttribute("serverTime", formDate);
    	
        Criteria criteria = new Criteria(1,5);
        log.info("[HomeController]---------------------------------"+criteria);
        model.addAttribute("boardList", bservice.getList(criteria)); 
        model.addAttribute("albumList", alservice.getList(criteria));
        
        return "main/home";
    }     
}