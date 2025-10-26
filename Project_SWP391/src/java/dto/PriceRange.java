/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;
import java.math.BigDecimal;

/**
 *
 * @author hoang
 */
public class PriceRange {
    private BigDecimal max;
    private BigDecimal min;
    private String label;

    public PriceRange() {
    }

    public PriceRange(BigDecimal min, BigDecimal max, String label) {
        this.min = min;
        this.max = max;
        this.label = label;
    }

    public BigDecimal getMax() {
        return max;
    }

    public BigDecimal getMin() {
        return min;
    }

    public String getLabel() {
        return label;
    }
    
     public boolean isOpenEnded() { 
         return max == null; 
     }
}
