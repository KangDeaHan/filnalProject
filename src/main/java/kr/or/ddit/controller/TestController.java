package kr.or.ddit.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/minwoo")
@Controller
public class TestController {

	@GetMapping("/test")
	public String test() {
		return "test/test";
	}
	
	@GetMapping("/chart")
	public String chart() {
		return "chart-apexcharts";
	}
	
	@GetMapping("/chart2")
	public String chart2() {
		return "chart-chartjs";
	}
	
	@GetMapping("/login")
	public String login() {
		return "auth-login";
	}
}
