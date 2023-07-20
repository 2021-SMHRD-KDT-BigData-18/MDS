package kr.mds.controller;



import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ChartController {

    @RequestMapping("/chart.com")
    public String showChart() {
    
        return "chart";
    }
}