package model;

public class Feature_role {

    private int role_id, feature_id;

    public Feature_role() {
    }

    public Feature_role(int role_id, int feature_id) {
        this.role_id = role_id;
        this.feature_id = feature_id;
    }

    public int getRole_id() {
        return role_id;
    }

    public void setRole_id(int role_id) {
        this.role_id = role_id;
    }

    public int getFeature_id() {
        return feature_id;
    }

    public void setFeature_id(int feature_id) {
        this.feature_id = feature_id;
    }

}
