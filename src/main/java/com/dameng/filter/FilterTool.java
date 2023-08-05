package com.dameng.filter;

import com.dameng.model.UserModel;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Enumeration;

/**
 * 这是一个过滤器工具类，用于对请求进行过滤和权限验证
 */
@WebFilter("/*")
public class FilterTool implements Filter {
    /**
     * 初始化过滤器
     * @param filterConfig 过滤器配置对象
     * @throws ServletException 如果初始化过程中发生异常
     */
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }
    /**
     * 过滤请求
     * @param servletRequest 请求对象
     * @param servletResponse 响应对象
     * @param filterChain 过滤器链
     * @throws IOException 如果过滤过程中发生I/O异常
     * @throws ServletException 如果过滤过程中发生Servlet异常
     */
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest)servletRequest;
        HttpServletResponse response = (HttpServletResponse)servletResponse;
        // 判断访问的路径是否与登录和样式有关
        String[] uri = {"/login.jsp","/public/","/login","/api_dameng"};
        // 获取请求的路径
        String url = request.getRequestURL().toString();
        for(String u:uri){
            if(url.contains(u)){
                // 放行
                filterChain.doFilter(request,response);
                return;
            }
        }
        UserModel user = (UserModel) request.getSession().getAttribute("user");
//        System.out.println("----过滤-"+user.getRealname());
        if (user != null) {
            // 用户已登录或访问的是接口，放行
            filterChain.doFilter(request,response);
            return;
        } else {
            // 用户未登录，重定向到登录页面

            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
    }
    /**
     * 销毁过滤器
     */
    @Override
    public void destroy() {
    }
}
