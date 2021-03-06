package com.katermar.movierating.filter;


import com.katermar.movierating.command.CommandType;
import com.katermar.movierating.command.factory.CommandFactory;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.EnumSet;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by katermar .
 * <p>
 * Filter to give access to some commands only to authenticated users.
 */
public class AuthenticationFilter implements Filter {
    private Set<String> grantCommands = new HashSet<>();

    /**
     * Adds granted commands as string names from the enum set.
     *
     * @param filterConfig
     * @throws ServletException
     */
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        EnumSet<CommandType> commandTypes = EnumSet.range(CommandType.MAIN_PAGE, CommandType.LOGIN);
        commandTypes.forEach(commandType -> grantCommands.add(commandType.name()));
    }

    /**
     * Filters request and response, if user is logged in
     * or if granted commands contain command from the request.
     *
     * @param servletRequest
     * @param servletResponse
     * @param filterChain
     * @throws IOException
     * @throws ServletException
     */
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        HttpSession currentSession = request.getSession(false);
        boolean loggedIn = currentSession != null && currentSession.getAttribute("user") != null;
        String command = CommandFactory.revertIntoConstantName(request.getParameter("command"));
        if (grantCommands.contains(command) || loggedIn) {
            filterChain.doFilter(servletRequest, servletResponse);
        } else {
            response.sendError(400, "Bad request parameters. You are not allowed to make these actions");
        }

    }

    @Override
    public void destroy() {
    }
}
