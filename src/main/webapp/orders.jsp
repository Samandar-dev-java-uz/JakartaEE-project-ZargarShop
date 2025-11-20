<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="uz">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Orders List</title>

    <style>
        * { margin:0; padding:0; box-sizing:border-box; font-family:'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }

        body {
            background: linear-gradient(to bottom, #e0f7fa, #ffffff);
            color: #2f3640;
            padding: 30px;
        }

        h2 {
            margin-bottom: 20px;
            color: #00796b;
            text-shadow: 1px 1px 2px #b2dfdb;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: rgba(255,255,255,0.9);
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        thead {
            background-color: #00796b;
            color: #fff;
        }

        th, td {
            padding: 12px 15px;
            text-align: center;
        }

        tbody tr:nth-child(even) { background-color: rgba(255,255,255,0.7); }
        tbody tr:hover {
            background-color: #b2ebf2;
            transform: scale(1.02);
            transition: all 0.2s ease-in-out;
        }

        button {
            padding: 8px 15px;
            background-color: #00796b;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            transition: all 0.3s ease;
            margin: 2px;
        }

        button:hover { background-color: #004d40; }

        a {
            color: #fff;
            text-decoration: none;
        }

        /* Responsive dizayn */
        @media(max-width:768px){
            table, thead, tbody, th, td, tr { display:block; }
            thead tr { display:none; }
            tbody tr {
                margin-bottom:15px;
                border:1px solid #b2dfdb;
                border-radius:8px;
                padding:10px;
            }
            tbody td {
                text-align:right;
                padding-left:50%;
                position:relative;
            }
            tbody td::before {
                content: attr(data-label);
                position:absolute;
                left:15px;
                font-weight:bold;
            }
        }
    </style>
</head>

<body>

<h2>Orders List</h2>

<table>
    <thead>
    <tr>
        <th>#</th>
        <th>Total Price</th>
        <th>Date</th>
        <th>Actions</th>
    </tr>
    </thead>

    <tbody>
    <c:forEach var="order" items="${orders}" varStatus="s">
        <tr>
            <td data-label="#">${s.index + 1}</td>
            <td data-label="Total Price">${order.total}</td>
            <td data-label="Date">${order.date}</td>

            <td data-label="Actions">
                <button onclick="viewOrder(${order.id})">View</button>
                <button onclick="returnOrder(${order.id})">Return</button>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<div>
    <button id="backBtn">
        <a href="/homeUser">Ortga qaytish</a>
    </button>
</div>

<script>
    function viewOrder(id){
        window.location.href = "/order-product-view?orderId=" + id;
    }

    function returnOrder(id){
        const form = document.createElement("form");
        form.method = "post";
        form.action = "/order-product-view";

        const hidden = document.createElement("input");
        hidden.type = "hidden";
        hidden.name = "orderId";
        hidden.value = id;

        form.appendChild(hidden);
        document.body.appendChild(form);
        form.submit();
    }

    // Ortga qaytish tugmasi
    const backBtn = document.getElementById('backBtn');
    backBtn.addEventListener("click", function(e){
        e.preventDefault();
        window.location.href = "/homeUser";
    });
</script>

</body>
</html>
