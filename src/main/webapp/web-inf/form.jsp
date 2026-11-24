<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Проверка попадания точки</title>

    <link
        rel="stylesheet"
        href="${pageContext.request.contextPath}/css/style.css"
    >

    <script
        src="${pageContext.request.contextPath}/js/app.js"
        defer
    ></script>
</head>

<body>

<%-- Радиус последней проверки. --%>
<c:set var="lastRadius" value="" />

<c:forEach
    var="item"
    items="${sessionScope.resultsBean.results}"
    varStatus="status"
>
    <c:if test="${status.last}">
        <c:set var="lastRadius" value="${item.r}" />
    </c:if>
</c:forEach>

<header class="header">
    <h1>Гунько Евгений Алексеевич</h1>
    <p>Группа: P3210</p>
    <p>Вариант: 7124123</p>
</header>

<main class="container">

    <section class="card">
        <h2>Ввод координат</h2>

        <form
            id="point-form"
            action="${pageContext.request.contextPath}/controller"
            method="post"
            target="areaCheckResult"
            novalidate
        >
            <div class="field">
                <label for="x">Координата X:</label>

                <select name="x" id="x">
                    <option value="-2">-2</option>
                    <option value="-1.5">-1.5</option>
                    <option value="-1">-1</option>
                    <option value="-0.5">-0.5</option>
                    <option value="0" selected>0</option>
                    <option value="0.5">0.5</option>
                    <option value="1">1</option>
                    <option value="1.5">1.5</option>
                    <option value="2">2</option>
                </select>
            </div>

            <div class="field">
                <label for="y">Координата Y (от -5 до 3):</label>

                <input
                    type="text"
                    name="y"
                    id="y"
                    placeholder="Например, 1.5"
                    autocomplete="off"
                >
            </div>

            <fieldset class="field">
                <legend>Радиус R:</legend>

                <div class="radio-group">
                    <c:forEach var="radius" begin="1" end="5">
                        <label>
                            <input
                                type="radio"
                                name="r"
                                value="${radius}"
                                <c:if test="${not empty lastRadius and lastRadius == radius}">
                                    checked
                                </c:if>
                            >
                            ${radius}
                        </label>
                    </c:forEach>
                </div>
            </fieldset>

            <p id="form-error" class="error" role="alert"></p>

            <button type="submit">Проверить</button>
        </form>
    </section>

    <section class="card">
        <h2>Область</h2>

        <canvas
            id="area-canvas"
            width="400"
            height="400"
            aria-label="График области попадания"
        >
            Ваш браузер не поддерживает canvas.
        </canvas>

        <p id="canvas-error" class="error" role="alert"></p>

        <form
            id="canvas-form"
            action="${pageContext.request.contextPath}/controller"
            method="post"
            target="areaCheckResult"
        >
            <input type="hidden" name="x" id="canvas-x">
            <input type="hidden" name="y" id="canvas-y">
            <input type="hidden" name="r" id="canvas-r">
        </form>
    </section>

    <section class="card history">
        <h2>История проверок</h2>

        <table>
            <thead>
            <tr>
                <th>X</th>
                <th>Y</th>
                <th>R</th>
                <th>Результат</th>
            </tr>
            </thead>

            <tbody>
            <c:forEach var="item" items="${sessionScope.resultsBean.results}">
                <tr
                    class="result-row"
                    data-x="<c:out value='${item.x}' />"
                    data-y="<c:out value='${item.y}' />"
                    data-r="<c:out value='${item.r}' />"
                    data-hit="<c:out value='${item.hit}' />"
                >
                    <td><c:out value="${item.x}" /></td>
                    <td><c:out value="${item.y}" /></td>
                    <td><c:out value="${item.r}" /></td>

                    <td>
                        <c:choose>
                            <c:when test="${item.hit}">
                                Попадание
                            </c:when>

                            <c:otherwise>
                                Промах
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <c:if test="${empty sessionScope.resultsBean.results}">
            <p>Проверок пока нет.</p>
        </c:if>
    </section>

</main>

</body>
</html>