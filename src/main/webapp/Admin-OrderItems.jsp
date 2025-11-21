<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="uz">
<head>
    <meta charset="UTF-8">
    <title>Order Items</title>

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

        a.view-btn, a.back-btn {
            padding: 5px 10px;
            border-radius: 5px;
            background-color: #00796b;
            color: #fff;
            text-decoration: none;
            font-weight: bold;
            transition: background-color 0.3s;
        }

        a.view-btn:hover, a.back-btn:hover {
            background-color: #004d40;
        }

        img {
            cursor: pointer;
            border-radius: 5px;
            transition: transform 0.3s;
        }

        img:hover {
            transform: scale(1.05);
        }

        /* Modal */
        .modal {
            display: none;
            position: fixed;
            z-index: 10000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.8);
        }

        .modal-content {
            margin: 10% auto;
            display: block;
            max-width: 80%;
        }

        .modal-close {
            position: absolute;
            top: 20px;
            right: 35px;
            color: #fff;
            font-size: 40px;
            font-weight: bold;
            cursor: pointer;
        }

        /* Responsive */
        @media(max-width: 768px) {
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
    <h2>Order Items</h2>

    <table>
        <thead>
        <tr>
            <th>#</th>
            <th>Product Image</th>
            <th>Product Name</th>
            <th>Price</th>
            <th>Quantity</th>
        </tr>
        </thead>

        <tbody>
        <c:forEach var="item" items="${orderItems}" varStatus="status">
            <tr>
                <td data-label="#">${status.index + 1}</td>
                <td data-label="Product Image">
                    <img src="/photoSee?productId=${item.product.id}"
                         alt="${item.product.name}"
                         width="80"
                         onclick="openModal(this.src)">
                </td>
                <td data-label="Product Name">${item.product.name}</td>
                <td data-label="Price">${item.product.price * item.quantity}</td>
                <td data-label="Quantity">${item.quantity}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <br>
    <a href="/homeAdmin" class="back-btn">Ortga qaytish</a>
</div>

<!-- Modal -->
<div id="imgModal" class="modal">
    <span class="modal-close" onclick="closeModal()">&times;</span>
    <img class="modal-content" id="modalImage">
</div>

<script>
    // Modal functions
    function openModal(src) {
        document.getElementById('imgModal').style.display = "block";
        document.getElementById('modalImage').src = src;
    }

    function closeModal() {
        document.getElementById('imgModal').style.display = "none";
    }

    // Close modal on click outside image
    window.onclick = function(event) {
        const modal = document.getElementById('imgModal');
        if(event.target === modal) {
            closeModal();
        }
    }
</script>

</body>
</html>
