package org.example.model;

public class AreaChecker {

    public static boolean check(double x, double y, double r) {
        boolean circle = x <= 0
                && y >= 0
                && x * x + y * y <= r * r;

        boolean square = x >= -r
                && x <= 0
                && y >= -r
                && y <= 0;

        boolean triangle = x >= 0
                && y >= 0
                && x + y <= r / 2;

        return circle || square || triangle;
    }
}