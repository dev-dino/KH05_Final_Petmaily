package com.petmily.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.petmily.dto.QuizDTO;
import com.petmily.service.QuizService;

@Controller
public class QuizController {
	
	@Autowired QuizService service;
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());

	@RequestMapping(value = "quizMain", method = RequestMethod.GET)
	public String board () {
		logger.info("퀴즈 등록(관리) 페이지 접근");
		return "quizMain";
	}
	
	@RequestMapping(value = "getAnimalList")
	//AJAX를 사용할 경우 @ResponseBody가 없으면 값을 view로 반환하지 못한다.
	//Why? @ResponseBody는 반환 값을 response형태로 보낼 수 있게하는 어노테이션 *mvc때 ajax사용 방법이랑 비교하면 금방 알 수 있음
	public @ResponseBody ArrayList<String> getAnimalList () {
		logger.info("동물 리스트 출력");
		return service.AnimalList();
	}
	
	@RequestMapping(value = "quizSearch")
	public @ResponseBody ArrayList<String> quizSearch (@RequestParam HashMap<String, String> params) {
		logger.info("동물 리스트 검색 요청 및 출력");
		return service.quizSearch(params);
	}
	
	
	@RequestMapping(value = "registQuiz")
	public @ResponseBody int registQuiz (@RequestParam HashMap<String,String> params) {
		logger.info("문제 등록");
		return service.registQuiz(params);
	}
	
	@RequestMapping(value = "getQuizList")
	public @ResponseBody ArrayList<QuizDTO> registQuiz () {
		logger.info("문제 리스트 호출");
		return service.getQuizList();
	}
	
	@RequestMapping(value = "quizDetailPage")
	public ModelAndView quizDetail(@RequestParam ("idx") String idx) {
		logger.info("문제 상세보기 요청: {}번글",idx);
		return service.quizDetail(idx);
	}
	
	@RequestMapping(value = "quizUpdatePage")
	public ModelAndView quizUpdateView(@RequestParam ("idx") String idx) {
		logger.info("문제 수정 페이지 요청: {}번글",idx);
		return service.quizUpdateView(idx);
	}
	
	@RequestMapping(value = "quizUpdate")
	public ModelAndView quizUpdate(@RequestParam HashMap<String, String> params) {
		logger.info("문제 수정  요청");
		return service.quizUpdate(params);
	}
	
	@RequestMapping(value = "quizDelete")
	public ModelAndView quizDelete(@RequestParam ("idx") int idx) {
		logger.info("문제 삭제  요청");
		return service.quizDelete(idx);
	}
	
	
	
	
}