package org.example.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/controller")
public class ControllerService extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        showForm(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String x = request.getParameter("x");
        String y = request.getParameter("y");
        String r = request.getParameter("r");

        boolean noParameters = x == null && y == null && r == null;
        boolean allParametersPresent = x != null && y != null && r != null;

        if (noParameters) {
            showForm(request, response);
            return;
        }

        if (!allParametersPresent) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Необходимо передать x y r");
            return;
        }

        request.getRequestDispatcher("/area-check").forward(request, response);
    }

    private void showForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/web-inf/form.jsp").forward(request, response);
    }
}
