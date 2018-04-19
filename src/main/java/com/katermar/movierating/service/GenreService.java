package com.katermar.movierating.service;

import com.katermar.movierating.entity.Genre;
import com.katermar.movierating.exception.ServiceException;

import java.util.List;

/**
 * Created by katermar .
 */
public interface GenreService {
    void addGenresForFilm(List<String> genres, int filmId) throws ServiceException;

    List<Genre> getByFilm(long id) throws ServiceException;

    List<Genre> getAll() throws ServiceException;

    Genre getByName(String genreName) throws ServiceException;

    void addGenre(Genre genre) throws ServiceException;

    void deleteByIdFilm(String idFilm) throws ServiceException;
}
