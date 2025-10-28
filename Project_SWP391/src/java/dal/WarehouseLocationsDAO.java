package dal;

import dto.Response_LocationDTO;
import java.util.ArrayList;
import java.util.List;
import util.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author ASUS
 */
public class WarehouseLocationsDAO extends DBContext{
    public List<Response_LocationDTO> locations()
    {
        List<Response_LocationDTO> list = new ArrayList();
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT location_id, code FROM Warehouse_locations");
        
        try(PreparedStatement ps = connection.prepareStatement(sql.toString()))
        {
            try(ResultSet rs = ps.executeQuery())
            {
                while(rs.next())
                {
                    Response_LocationDTO line = new Response_LocationDTO(
                                rs.getInt("location_id"),
                                rs.getString("code"));
                    list.add(line);
                }
            }
        }
        catch(SQLException e)
        {
            e.printStackTrace();
        }
        return list;
    }
}
