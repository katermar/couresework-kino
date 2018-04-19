package com.katermar.movierating.service;

import com.katermar.movierating.exception.ServiceException;

/**
 * Created by katermar .
 */
public interface EmailSenderService {
    void sendConfirmationMail(String username, String userEmail) throws ServiceException;

    void sendNewPasswordMail(String username, String userEmail) throws ServiceException;
}
