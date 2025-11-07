/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;
/**
 *
 * @author admin
 */
@WebListener
public class ContextListener implements ServletContextListener{
    public void contextInitialized(ServletContextEvent sce) {
        Set<Integer> activeUserSet = Collections.synchronizedSet(new HashSet<>());
        ServletContext context = sce.getServletContext();
        context.setAttribute("activeUserSet", activeUserSet);
        System.out.println(">>> Active User Set has been initialized!");
    }
    public void contextDestroyed(ServletContextEvent sce) {
        ServletContext context = sce.getServletContext();
        context.removeAttribute("activeUserSet");
        System.out.println(">>> ContextListener: Active User Set has been destroyed.");
    }
}
