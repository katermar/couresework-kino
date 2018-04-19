package com.katermar.movierating.util;

import com.katermar.movierating.config.Parameter;
import com.katermar.movierating.config.Property;
import com.katermar.movierating.exception.ServiceException;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

/**
 * Created by katermar .
 * <p>
 * Class to validate parameters.
 */
public class ParametersValidator {
    /**
     * Validation of user parameters.
     * Uses special regexes to validate parameters
     *
     * @param requestParameters map of parameters, which have to be validated
     * @return result of validation
     * @throws ServiceException
     */
    public static boolean validateUserParameters(Map<String, String[]> requestParameters) throws ServiceException {
        boolean isValid = true;
        String[] arr = {Parameter.USERNAME, Parameter.EMAIL, Parameter.PASSWORD,
                Parameter.REALNAME, Parameter.BIRTHDAY, Parameter.PASSWORD};
        List<String> parameterList = Arrays.asList(arr);
        for (String parameter : parameterList) {
            if (requestParameters.containsKey(parameter)) {
                String requestParameter = requestParameters.get(parameter)[0];
                isValid = isValid && requestParameter != null && !requestParameter.trim().isEmpty();
                switch (parameter) {
                    case Parameter.USERNAME:
                        isValid = isValid && requestParameter.matches(Property.USERNAME_REGEX);
                        break;
                    case Parameter.EMAIL:
                        isValid = isValid && requestParameter.matches(Property.EMAIL_REGEX);
                        break;
                    case Parameter.PASSWORD:
                        isValid = isValid && requestParameter.matches(Property.PASSWORD_REGEX);
                        break;
                    default:
                        break;
                }
            }
        }
        return isValid;
    }

    /**
     * Validation of film parameters.
     * Uses special regexes to validate parameters
     *
     * @param requestParameters - map of parameters, which have to be validated
     * @return result of validation
     * @throws ServiceException
     */
    public static boolean validateFilmParameters(Map<String, String[]> requestParameters) throws ServiceException {
        boolean isValid = true;
        List<String> parameterList = List.of(Parameter.NAME, Parameter.DURATION, Parameter.YEAR,
                Parameter.DIRECTOR, Parameter.DESCRIPTION, Parameter.POSTER, Parameter.GENRE);
        for (String parameter : parameterList) {
            if (requestParameters.containsKey(parameter)) {
                String requestParameter = requestParameters.get(parameter)[0];
                isValid = isValid && requestParameter != null && !requestParameter.trim().isEmpty();
                switch (parameter) {
                    case Parameter.DURATION:
                        isValid = isValid && requestParameter.matches(Property.NUMBER_REGEX);
                        break;
                    case Parameter.NAME:
                        isValid = isValid && requestParameter.matches(Property.WORD_REGEX);
                        break;
                    case Parameter.DIRECTOR:
                        isValid = isValid && requestParameter.matches(Property.WORD_REGEX);
                        break;
                    case Parameter.YEAR:
                        isValid = isValid && requestParameter.matches(Property.NUMBER_REGEX);
                        break;
                    default:
                        break;
                }
            }
        }
        return isValid;
    }
}
