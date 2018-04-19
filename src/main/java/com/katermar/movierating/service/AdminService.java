package com.katermar.movierating.service;

import com.katermar.movierating.exception.ServiceException;

/**
 * Created by katermar .
 */
public interface AdminService {
    void updateBan(String login) throws ServiceException;
}
