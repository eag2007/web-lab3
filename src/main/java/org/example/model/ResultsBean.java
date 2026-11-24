package org.example.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class ResultsBean implements Serializable {

    private final List<CheckResult> results = new ArrayList<>();

    public ResultsBean() {
    }

    public synchronized void addResult(CheckResult result) {
        results.add(result);
    }

    public synchronized List<CheckResult> getResults() {
        return new ArrayList<>(results);
    }
}