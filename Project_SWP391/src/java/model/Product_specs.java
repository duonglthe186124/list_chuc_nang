package model;

public class Product_specs {

    private int spec_id;
    private String cpu, memory, storage;
    private int battery_capacity;
    private String color;
    private float screen_size;
    private String screen_type;
    private int camera;

    public Product_specs() {
    }

    public Product_specs(int spec_id, String cpu, String memory, String storage, int battery_capacity, String color, float screen_size, String screen_type, int camera) {
        this.spec_id = spec_id;
        this.cpu = cpu;
        this.memory = memory;
        this.storage = storage;
        this.battery_capacity = battery_capacity;
        this.color = color;
        this.screen_size = screen_size;
        this.screen_type = screen_type;
        this.camera = camera;
    }

    public int getSpec_id() {
        return spec_id;
    }

    public void setSpec_id(int spec_id) {
        this.spec_id = spec_id;
    }

    public String getCpu() {
        return cpu;
    }

    public void setCpu(String cpu) {
        this.cpu = cpu;
    }

    public String getMemory() {
        return memory;
    }

    public void setMemory(String memory) {
        this.memory = memory;
    }

    public String getStorage() {
        return storage;
    }

    public void setStorage(String storage) {
        this.storage = storage;
    }

    public int getBattery_capacity() {
        return battery_capacity;
    }

    public void setBattery_capacity(int battery_capacity) {
        this.battery_capacity = battery_capacity;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public float getScreen_size() {
        return screen_size;
    }

    public void setScreen_size(float screen_size) {
        this.screen_size = screen_size;
    }

    public String getScreen_type() {
        return screen_type;
    }

    public void setScreen_type(String screen_type) {
        this.screen_type = screen_type;
    }

    public int getCamera() {
        return camera;
    }

    public void setCamera(int camera) {
        this.camera = camera;
    }

}
