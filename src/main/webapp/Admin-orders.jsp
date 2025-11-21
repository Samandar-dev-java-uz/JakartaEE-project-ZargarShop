<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="uz">
<head>
    <meta charset="UTF-8">
    <title>Admin Orders</title>
    <style>
        /* Reset va font */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        }

        body {
            background: linear-gradient(to bottom, #e0f7fa, #ffffff);
            color: #333;
            padding-bottom: 50px;
        }

        /* Header */
        header {
            background-color: rgba(255, 255, 255, 0.95);
            padding: 20px 40px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            position: sticky;
            top: 0;
            z-index: 1000;
            border-radius: 0 0 15px 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            transition: background-color 0.3s ease, transform 0.3s ease;
        }

        header.sticky {
            background-color: #b2ebf2;
            transform: scale(1.02);
        }

        header h1 {
            color: #00796b;
            font-size: 28px;
            text-shadow: 1px 1px 2px #b2dfdb;
        }

        nav a {
            text-decoration: none;
            color: #00796b;
            font-weight: bold;
            margin-left: 20px;
            position: relative;
            padding: 5px 0;
            transition: color 0.3s;
        }

        nav a::after {
            content: '';
            position: absolute;
            width: 0%;
            height: 2px;
            bottom: 0;
            left: 0;
            background-color: #00796b;
            transition: 0.3s;
        }

        nav a:hover::after {
            width: 100%;
        }

        nav a:hover {
            color: #004d40;
        }

        /* Container */
        .container {
            width: 95%;
            max-width: 1200px;
            margin: 40px auto;
            background: rgba(255,255,255,0.85);
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
            overflow-x: auto;
        }

        h2 {
            font-size: 28px;
            color: #00796b;
            margin-bottom: 20px;
            text-align: center;
        }

        /* Table */
        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 600px;
        }

        table thead {
            background: #b2ebf2;
        }

        table th, table td {
            padding: 12px 15px;
            text-align: center;
            border: 1px solid #ccc;
        }

        table tr:hover {
            background: #e0f2f1;
        }

        a.view-btn, a.return-btn {
            padding: 5px 10px;
            border-radius: 5px;
            background-color: #00796b;
            color: #fff;
            text-decoration: none;
            font-weight: bold;
            transition: background-color 0.3s;
        }

        a.view-btn:hover, a.return-btn:hover {
            background-color: #004d40;
        }

        /* Responsive for small screens */
        @media(max-width: 768px) {
            header {
                flex-direction: column;
                align-items: flex-start;
            }

            nav {
                margin-top: 10px;
            }

            table, thead, tbody, th, td, tr {
                display: block;
            }

            table thead tr {
                display: none;
            }

            table tr {
                margin-bottom: 15px;
                border-bottom: 2px solid #b2ebf2;
            }

            table td {
                text-align: right;
                padding-left: 50%;
                position: relative;
            }

            table td::before {
                content: attr(data-label);
                position: absolute;
                left: 15px;
                font-weight: bold;
                text-align: left;
            }
        }
    </style>
</head>
<body>


<div class="container">
    <h2>Orders List</h2>
    <table>
        <thead>
        <tr>
            <th>#</th>
            <th>User ID</th>
            <th>Total Price</th>
            <th>Date</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="order" items="${orders}" varStatus="s">
            <tr>
                <td data-label="#">${s.index + 1}</td>
                <td data-label="User ID">${order.userId}</td>
                <td data-label="Total Price">${order.total}</td>
                <td data-label="Date">${order.date}</td>
                <td data-label="Actions">
                    <a href="/Admin-order-view?id=${order.id}" class="view-btn">View</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

          <br>
        <a href="/homeAdmin" class="return-btn">Return</a>

</div>

<script>
    // Sticky header effect
    window.addEventListener('scroll', function() {
        const header = document.getElementById('mainHeader');
        if(window.scrollY > 50){
            header.classList.add('sticky');
        } else {
            header.classList.remove('sticky');
        }
    });

    // Smooth scroll for nav links
    const links = document.querySelectorAll('nav a[href^="#"]');
    for(let link of links){
        link.addEventListener('click', function(e){
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            target.scrollIntoView({ behavior: 'smooth' });
        });
    }
</script>

</body>
</html>
