package filter;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class CommonAuthFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws SecurityException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest,
                         ServletResponse servletResponse,
                         FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;

        String uri = request.getRequestURI();

        String[] excludeUris = {
                "/index.jsp",
                "/signin.member",
                "/verifyEmailCode.member",
                "/mailCheck.member",
                "/dupliNicknameCheck.member",
                "/dupliIdCheck.member",
                "/isLoginOk.member",
                "/cancelFindPw.member",
                "/IdEmailCode.member",
                "/changePw.member",
                "/findIdByNameEmail.member",
                "/isNameEmailExist.member",
                "/toFindIdPage.member",
                "/toFindPwPage.member",
                "/toSigninPage.member",
                "/toLoginPage.member",
                "/"
        };

        if (uri.endsWith(".js") ||
                uri.endsWith(".css") ||
                uri.endsWith(".svg") ||
                uri.endsWith(".png") ||
                uri.endsWith(".jpg") ||
                uri.endsWith(".jsp")) {
            filterChain.doFilter(servletRequest, servletResponse);
            return;
        }

        for (String excludeUri : excludeUris) {
            if (uri.equals(excludeUri)) {
                filterChain.doFilter(servletRequest, servletResponse);
                return;
            }
        }

        if (request.getSession().getAttribute("loginId") == null) {
            response.sendRedirect("/");
            return;
        }
        filterChain.doFilter(servletRequest, servletResponse);
    }

    @Override
    public void destroy() {
        Filter.super.destroy();
    }
}
