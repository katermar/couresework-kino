package com.katermar.movierating.service;

import com.katermar.movierating.entity.User;
import com.katermar.movierating.exception.ServiceException;

/**
 * Created by katermar .
 */
public interface RegisterService {
    void register(User user) throws ServiceException;

    void confirmEmail(User user) throws ServiceException;
}
