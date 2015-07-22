package com.freelywx.mall.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/center")
public class CenterController {
	@RequestMapping("")
	public String init() { 
		return "center";
	}
}
