<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/modal.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
    <link rel="icon" href="${pageContext.request.contextPath}/img/icon.png"/>
    <link href='http://fonts.googleapis.com/css?family=Cookie' rel='stylesheet' type='text/css'/>
    <script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.2.1.min.js"></script>
</head>

<!-- internationalization -->
<c:choose>
    <c:when test="${not empty sessionScope.locale}">
        <fmt:setLocale value="${sessionScope.locale}"/>
    </c:when>
    <c:otherwise>
        <fmt:setLocale value="en_US"/>
    </c:otherwise>
</c:choose>
<fmt:setBundle basename="Locale"/>

<%--modal--%>
<div class="modal fade" id="modalFilm${films.id}" tabindex="-1" role="dialog"
     aria-labelledby="exampleModalLongTitle"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <form action="/controller" method="post">
            <input type="hidden" name="command" value="add-film">
            <div class="modal-content">
                <div class="modal-header">
                    <div class="container-fluid">
                        <div class="row">
                            <button type="button col-md-1 pull-right" class="close"
                                    data-dismiss="modal"
                                    aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h3 class="modal-title col-md-11 text-center modalFilmTitle">
                                <fmt:message
                                        key="header.edit"/> <fmt:message
                                    key="add.film"/></h3>
                        </div>
                    </div>
                </div>
                <div class="modal-body">
                    <div class="container-fluid">
                        <div class="form-group">
                            <label for="filmName${films.id}"><fmt:message key="add.film.name"/></label>
                            <input class="form-control" type="text" placeholder="<fmt:message key="add.film.name"/>"
                                   id="filmName${films.id}" name="name"
                                   value="${films.name}"
                                   required>
                        </div>
                        <div class="form-group">
                            <label for="year${films.id}"><fmt:message key="add.film.releaseYear"/></label>
                            <input class="form-control" type="number"
                                   placeholder="<fmt:message key="add.film.releaseYear"/>" id="year${films.id}"
                                   name="year"
                                   max="2018" min="1900" value="${films.releaseYear}"
                                   required>
                        </div>
                        <div class="form-group">
                            <label for="duration${films.id}"><fmt:message key="add.film.duration"/></label>
                            <input class="form-control" type="number"
                                   placeholder="<fmt:message key="add.film.duration"/>"
                                   id="duration${films.id}"
                                   name="duration"
                                   min="1" value="${films.duration}"
                                   required>
                        </div>
                        <div class="form-group">
                            <label for="poster${films.id}"><fmt:message key="add.film.poster"/></label>
                            <input class="form-control" type="url" name="poster"
                                   id="poster${films.id}"
                                   placeholder="<fmt:message key="add.film.poster"/>" value="${films.poster}"
                                   pattern="^(https|http).+(jpg|svg|gif|png)$">
                        </div>
                        <%--@elvariable id="genres" type="java.util.List"--%>
                        <%--@elvariable id="genreModal" type="com.katermar.movierating.entity.Genre"--%>
                        <div class="form-group">
                            <label><fmt:message key="add.genre"/></label>
                            <div class="btn-group btn-group-toggle col-md-12 col-sm-12 col-xs-12 text-center"
                                 data-toggle="buttons">
                                <c:if test="${genresModal ne null}">
                                    <c:forEach items="${genresModal}" var="genreModal">
                                        <span class="button-checkbox" style="margin: 10px 5px 10px 10px">
                                            <c:if test="${films.genres.contains(genreModal)}">
                                                <button type="button" class="btn"
                                                        data-color="danger"
                                                        style="margin-bottom: 10px">#${genreModal.name}</button>
                                                <input type="checkbox" class="hidden"
                                                       name="genre"
                                                       value="${genreModal.name}" checked/>
                                            </c:if>
                                            <c:if test="${!films.genres.contains(genreModal)}">
                                                <button type="button" class="btn"
                                                        data-color="danger"
                                                        style="margin-bottom: 10px">#${genreModal.name}</button>
                                                <input type="checkbox" class="hidden"
                                                       name="genre"
                                                       value="${genreModal.name}"/>
                                            </c:if>
                                        </span>
                                    </c:forEach>
                                </c:if>
                                <hr/>
                            </div>
                        </div>
                        <%--@elvariable id="directors" type="java.util.List"--%>
                        <%--@elvariable id="directorModal" type="com.katermar.movierating.entity.Director"--%>
                        <div class="form-group">
                            <label for="directorsSelect${films.id}"><fmt:message
                                    key="add.director"/></label>
                            <c:if test="${directorsModal ne null}">
                                <select class="form-control selectpicker show-tick"
                                        id="directorsSelect${films.id}" name="director"
                                        data-style="btn-info">
                                    <c:forEach items="${directorsModal}"
                                               var="directorModal">
                                        <c:if test="${films.director.id eq directorModal.id}">
                                            <option selected>${directorModal.name}</option>
                                        </c:if>
                                        <c:if test="${films.director.id ne directorModal.id}">
                                            <option>${directorModal.name}</option>
                                        </c:if>
                                    </c:forEach>
                                </select>
                            </c:if>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <label for="desc${films.id}"><fmt:message
                                        key="add.film.desc"/></label>
                                <textarea class="form-control" id="desc${films.id}"
                                          name="desc"
                                          rows="3" required>${films.description}</textarea>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">
                        <fmt:message key="add.common.close"/>
                    </button>
                    <input type="hidden" name="mode" value="edit">
                    <input type="hidden" name="id" value="${films.id}">
                    <button type="submit" class="btn btn-primary">
                        <fmt:message key="header.add"/>
                    </button>
                </div>
            </div>
        </form>
    </div>
</div>
<%--modal--%>