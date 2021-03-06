package com.kh.cm.common.error;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ErrorController {

    @RequestMapping(value = "errors", method = RequestMethod.GET)
    public ModelAndView renderErrorPage(HttpServletRequest httpRequest) {
        
        ModelAndView errorPage = new ModelAndView("errorPage");
        String errorMsg = "";
        int httpErrorCode = getErrorCode(httpRequest);

        switch (httpErrorCode) {
            case 401: {
                errorMsg = "Error:401";
                break;
            }
            case 403: {
            	errorMsg = "Error:403";
            	break;
            }
            case 404: {
                errorMsg = "Error:404";
                break;
            }
            case 500: {
                errorMsg = "Error:500";
                break;
            }
            default: {
            	errorMsg = "Error";
            }
        }
        
        errorPage.addObject("errorMsg", errorMsg);
        errorPage.setViewName("common/error");
        
        return errorPage;
    }
    
    private int getErrorCode(HttpServletRequest httpRequest) {
        return (Integer) httpRequest
          .getAttribute("javax.servlet.error.status_code");
    }
}