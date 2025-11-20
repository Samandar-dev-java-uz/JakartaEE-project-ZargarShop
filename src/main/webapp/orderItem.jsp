<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="uz">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Items</title>
    <style>
        /* Basic Reset */
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
        tbody tr:hover { background-color: #b2ebf2; transform: scale(1.02); transition: all 0.2s ease-in-out; }

        img {
            border-radius: 5px;
            max-width: 80px;
            cursor: pointer;
            transition: transform 0.2s;
        }
        img:hover {
            transform: scale(1.1);
        }

        button {
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #00796b;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            transition: all 0.3s ease;
        }

        button:hover { background-color: #004d40; }

        button a {
            text-decoration: none;
            color: #fff;
        }

        /* Responsive */
        @media(max-width:768px){
            table, thead, tbody, th, td, tr { display:block; }
            thead tr { display:none; }
            tbody tr { margin-bottom:15px; border:1px solid #b2dfdb; border-radius:8px; padding:10px; }
            tbody td { text-align:right; padding-left:50%; position:relative; }
            tbody td::before { content: attr(data-label); position:absolute; left:15px; width:calc(50% - 20px); font-weight:bold; text-align:left; }
            img { max-width: 60px; }
        }
    </style>
</head>
<body>

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
                <img src="/photoSee?productId=${item.product.id}" alt="${item.product.name}" onclick="openModal(this.src)">
            </td>
            <td data-label="Product Name">${item.product.name}</td>
            <td data-label="Price">${item.product.price*item.quantity}</td>
            <td data-label="Quantity">${item.quantity}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<button id="backBtn">
    <a href="/orders-view">Ortga qaytish</a>
</button>

<!-- Modal Structure for Image -->
<div id="imgModal" style="display:none; position:fixed; z-index:1000; left:0; top:0; width:100%; height:100%; background-color: rgba(0,0,0,0.8);">
    <span style="position:absolute; top:20px; right:35px; color:#fff; font-size:40px; font-weight:bold; cursor:pointer;" onclick="closeModal()">&times;</span>
    <img id="modalImage" style="display:block; margin:5% auto; max-width:80%; max-height:80%; border-radius:10px;">
</div>

<script>
    // Ortga qaytish tugmasi
    const backBtn = document.getElementById('backBtn');
    backBtn.addEventListener('click', function(e){
        e.preventDefault();
        window.location.href = '/orders-view';
    });

    // Modal funksiyasi
    function openModal(src){
        const modal = document.getElementById('imgModal');
        const modalImg = document.getElementById('modalImage');
        modal.style.display = "block";
        modalImg.src = src;
    }

    function closeModal(){
        document.getElementById('imgModal').style.display = "none";
    }

    window.onclick = function(event){
        const modal = document.getElementById('imgModal');
        if(event.target === modal){
            modal.style.display = "none";
        }
    }
</script>

</body>
</html>
