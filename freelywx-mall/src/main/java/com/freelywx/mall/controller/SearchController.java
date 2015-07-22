package com.freelywx.mall.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/search")
public class SearchController {
	@RequestMapping("")
	public String init() { 
		return "search";
	}
	
	
	@RequestMapping("getBuilding")
	public String getBuilding(@RequestParam("key") String key) { 
		return "search";
	}
	
	
}
