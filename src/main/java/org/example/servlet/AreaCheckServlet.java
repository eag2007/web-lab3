package org.example.servlet;

import jakarta.servlet.DispatcherType;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.model.AreaChecker;
import org.example.model.CheckResult;
import org.example.model.ResultsBean;

import java.io.IOException;
import java.rmi.ServerException;

@WebServlet("/area-check")
public class AreaCheckServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        if (request.getDispatcherType() != DispatcherType.FORWARD) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        double x;
        double y;
        double r;

        try {
            x = Double.parseDouble(request.getParameter("x"));
            y = Double.parseDouble(request.getParameter("y"));
            r = Double.parseDouble(request.getParameter("r"));
        } catch (NumberFormatException | NullPointerException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Координаты и радиус должны быть числами");
            return;
        }

        if (!Double.isFinite(x) || !Double.isFinite(y) || !Double.isFinite(r)) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Значения должны быть конечным числами");
            return;
        }

        if (r != 1 && r != 2 && r != 3 & r != 4 && r != 5) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Радиус должен быть одним из значений: 1, 2, 3, 4, 5");
            return;
        }

        boolean hit = AreaChecker.check(x, y, r);

        CheckResult result = new CheckResult(x, y, r, hit);

        HttpSession session = request.getSession();
        ResultsBean bean;

        synchronized (session) {
            bean = (ResultsBean) session.getAttribute("resultsBean");

            if (bean == null) {
                bean = new ResultsBean();
                session.setAttribute("resultsBean", bean);
            }
        }

        bean.addResult(result);
        request.setAttribute("result", result);

        request.getRequestDispatcher("/web-inf/result.jsp").forward(request, response);

    }
}
