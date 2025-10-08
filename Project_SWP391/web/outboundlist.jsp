<%-- 
    Document   : Out_bound_list
    Created on : Oct 5, 2025, 2:17:39 PM
    Author     : tuan
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="model.*" %>
<%@page import="dal.*" %>
<%@page import="java.util.List" %>
<%@page import="java.util.ArrayList" %>
<%
    if (request.getAttribute("list") == null) {
        OutboundDAO.outbound obdao = new OutboundDAO.outbound();
        List<Outbound_inventory> list = obdao.getAllOutBoundIn();
        request.setAttribute("list", list);
        request.setAttribute("endP", 1);
        request.setAttribute("tag", 1);

    }
%>
<!DOCTYPE html>
<html>
    <head>
        <title>JSP Page</title>
        <style>
            body {
                background: #f8f9fa;
                font-family: 'Segoe UI', Arial, sans-serif;
            }
            .container {
                margin-top: 40px;
                background: #fff;
                border-radius: 8px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.07);
                padding: 32px 24px;
            }
            .card-header {
                border-bottom: 1px solid #e3e3e3;
                margin-bottom: 24px;
                padding-bottom: 12px;
            }
            .card-header h5 {
                margin: 0;
                color: #343a40;
                font-weight: 600;
            }
            .nav-link {
                color: #dc3545;
                font-weight: 500;
                text-decoration: none;
                transition: color 0.2s;
            }
            .nav-link:hover {
                color: #a71d2a;
                text-decoration: underline;
            }
            table.table {
                margin-top: 24px;
                border-radius: 6px;
                overflow: hidden;
                box-shadow: 0 1px 3px rgba(0,0,0,0.04);
            }
            table th, table td {
                text-align: center;
                vertical-align: middle !important;
            }
            table thead th {
                background: #343a40;
                color: #fff;
                border: none;
            }
            table tbody tr:nth-child(even) {
                background: #f2f2f2;
            }
            table tbody tr:hover {
                background: #e9ecef;
            }
            .hint-text {
                margin: 16px 0 8px 0;
                color: #6c757d;
                font-size: 15px;
            }
            .pagination {
                margin: 0;
                padding: 0;
                list-style: none;
            }
            .pagination .page-item {
                margin: 0 3px;
            }
            .pagination .page-link {
                color: #007bff;
                border: 1px solid #dee2e6;
                border-radius: 4px;
                padding: 6px 14px;
                background: #fff;
                text-decoration: none;
                transition: background 0.2s, color 0.2s;
            }
            .pagination .page-link:hover {
                background: #e2e6ea;
                color: #0056b3;
            }
            .pagination .active .page-link {
                background: #007bff;
                color: #fff;
                border-color: #007bff;
                pointer-events: none;
            }
            @media (max-width: 768px) {
                .container {
                    padding: 12px 4px;
                }
                table th, table td {
                    font-size: 13px;
                    padding: 6px 2px;
                }
            }
        </style>
    </head>
    <body>
        <div class="container container-fluid">
            <div class="card-header my-3 d-flex align-items-center justify-content-between">
                <a href="#"><h5>Dashboard</h5></a>
                <a class="nav-link" href="logout">Log out</a>
            </div>
            <div class="row">


                <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
                    <table class="table table-light">
                        <thead>
                            <tr>
                                <th scope="col">Outbound ID</th>
                                <th scope="col">Outbound Code</th>
                                <th scope="col">User</th>
                                <th scope="col">Creator</th>
                                <th scope="col">Date</th>
                                <th scope="col">Note</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="o" items="${list}">
                                <tr>
                                    <td>${o.outbound_id}</td>
                                    <td>${o.oubound_code}</td>
                                    <td>${o.user_id}</td>
                                    <td>${o.created_by}</td>
                                    <td>${o.created_at}</td>
                                    <td>${o.note}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <div style="text-align: center;" class="clearfix">
                        <div class="hint-text">Showing <b>${requestScope.tag}</b> out of <b>${requestScope.endP}</b> entries</div>
                        <ul class="pagination" style="display: flex; align-items: center; justify-content: center;">
                            <c:if test="${requestScope.tag>1}">
                                <li class="page-item">
                                    <a href="show-obinventory?index=${requestScope.tag-1}" class="page-link" aria-label="Go to previous page">Previous</a>
                                </li>
                            </c:if>
                            <c:forEach begin="1" end="${requestScope.endP}" var="i">
                                <li class="page-item ${requestScope.tag == i?'active':''}">
                                    <a href="show-obinventory?index=${i}" class="page-link">${i}</a>
                                </li> 
                            </c:forEach>
                            <c:if test="${requestScope.tag < requestScope.endP}">
                                <li class="page-item">
                                    <a href="show-obinventory?index=${requestScope.tag+1}" class="page-link" aria-label="Go to next page">Next</a>
                                </li>
                            </c:if>
                        </ul>
                    </div>
                </main>
            </div>
        </div>


                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
    </body>
</html>
