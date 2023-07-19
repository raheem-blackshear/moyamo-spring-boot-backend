package net.infobank.moyamo.models;


public class ElasticsearchConfig {

    private ElasticsearchConfig() throws IllegalAccessException {
        throw new IllegalAccessException("ElasticsearchConfig is util");
    }

    public static final String INDEX_NAME = "moyamo_3";
}
