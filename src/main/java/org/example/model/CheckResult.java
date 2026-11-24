package org.example.model;

import java.io.Serializable;

public class CheckResult implements Serializable {

    private final double x;
    private final double y;
    private final double r;
    private final boolean hit;

    public CheckResult(double x, double y, double r, boolean hit) {
        this.x = x;
        this.y = y;
        this.r = r;
        this.hit = hit;
    }

    public double getX() {
        return x;
    }

    public double getY() {
        return y;
    }

    public double getR() {
        return r;
    }

    public boolean isHit() {
        return hit;
    }
}