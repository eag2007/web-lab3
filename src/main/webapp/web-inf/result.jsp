<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">

    <meta
        name="viewport"
        content="width=device-width, initial-scale=1.0"
    >

    <title>Результат проверки</title>

    <link
        rel="stylesheet"
        href="${pageContext.request.contextPath}/css/style.css"
    >

    <script
        src="${pageContext.request.contextPath}/js/result-jokes.js"
        defer
    ></script>

    <style>
        .result-meme {
            display: block;
            width: 100%;
            height: auto;
            margin: 24px auto 16px;
            border-radius: 16px;
        }

        .result-joke {
            white-space: pre-line;
            padding: 16px;
            border: 1px solid rgba(220, 230, 255, 0.18);
            border-radius: 14px;
            background: rgba(255, 255, 255, 0.06);
            line-height: 1.5;
        }
    </style>
</head>

<body>

<main class="result-page">
    <section class="card">

        <h1>Результат проверки</h1>

        <table>
            <thead>
            <tr>
                <th>X</th>
                <th>Y</th>
                <th>R</th>
            </tr>
            </thead>

            <tbody>
            <tr>
                <td><c:out value="${result.x}" /></td>
                <td><c:out value="${result.y}" /></td>
                <td><c:out value="${result.r}" /></td>
            </tr>
            </tbody>
        </table>

        <c:choose>
            <c:when test="${result.hit}">
                <p class="result-hit">
                    Точка попала в область
                </p>
            </c:when>

            <c:otherwise>
                <p class="result-miss">
                    Точка не попала в область
                </p>
            </c:otherwise>
        </c:choose>

        <img
            class="result-meme"
            src="${pageContext.request.contextPath}/images/result-meme.png"
            alt="Я вам запрещаю пользоваться чатом GPT"
        >

        <p id="result-joke" class="result-joke">
            Анекдот появится после загрузки страницы.
        </p>

        <a
            class="button-link"
            href="${pageContext.request.contextPath}/controller"
        >
            Вернуться к форме
        </a>

    </section>
</main>

</body>
</html>