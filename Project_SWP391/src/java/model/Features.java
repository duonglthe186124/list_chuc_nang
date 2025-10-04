package model;

public class Features {

    private int feature_id;
    private String feature_name, description;

    public Features() {
    }

    public Features(int feature_id, String feature_name, String description) {
        this.feature_id = feature_id;
        this.feature_name = feature_name;
        this.description = description;
    }

    public int getFeature_id() {
        return feature_id;
    }

    public void setFeature_id(int feature_id) {
        this.feature_id = feature_id;
    }

    public String getFeature_name() {
        return feature_name;
    }

    public void setFeature_name(String feature_name) {
        this.feature_name = feature_name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
