<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="uz">
<head>
    <meta charset="UTF-8">
    <title>Mahsulotni olish</title>
    <style>
        /* Reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            background: linear-gradient(120deg, #eaf6ff, #ffffff);
            padding: 20px;
            color: #333;
        }

        h2 {
            text-align: center;
            color: #00796b;
            margin-bottom: 25px;
            text-shadow: 1px 1px 2px #b2dfdb;
        }

        table {
            width: 80%;
            margin: auto;
            border-collapse: collapse;
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0,0,0,0.15);
        }

        th {
            background: #00796b;
            color: white;
            padding: 12px;
            font-size: 16px;
        }

        td {
            padding: 15px;
            text-align: center;
            font-size: 15px;
        }

        img {
            border-radius: 8px;
            cursor: pointer;
            transition: 0.3s;
        }

        img:hover {
            transform: scale(1.1);
        }

        /* Quantity input */
        .qty-box {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
        }

        .qty-btn {
            width: 28px;
            height: 28px;
            border: none;
            background: #00796b;
            color: white;
            border-radius: 6px;
            font-size: 18px;
            cursor: pointer;
            transition: 0.25s;
        }

        .qty-btn:hover {
            background: #004d40;
        }

        .qty-input {
            width: 60px;
            height: 28px;
            text-align: center;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }

        /* Submit button */
        button[type="submit"] {
            background: #28a745;
            border: none;
            padding: 10px 18px;
            color: white;
            font-size: 15px;
            border-radius: 6px;
            cursor: pointer;
            transition: 0.25s;
        }

        button[type="submit"]:hover {
            background: #1e7e34;
        }

        /* Back button */
        .backBtn {
            display: inline-block;
            margin: 25px auto;
            text-decoration: none;
            background: #6b7280;
            color: white;
            padding: 10px 20px;
            border-radius: 6px;
            transition: 0.25s;
        }

        .backBtn:hover {
            background: #565e64;
        }

        /* Modal rasm */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            padding-top: 60px;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.8);
        }

        .modal-content {
            margin: auto;
            display: block;
            max-width: 80%;
            max-height: 80%;
            border-radius: 12px;
        }

        .modal-close {
            position: absolute;
            top: 30px;
            right: 50px;
            color: white;
            font-size: 40px;
            font-weight: bold;
            cursor: pointer;
        }

        @media(max-width: 600px) {
            table { width: 100%; }
        }

    </style>
</head>
<body>

<h2>Mahsulotni olish</h2>

<table>
    <tr>
        <th>Rasm</th>
        <th>Nomi</th>
        <th>Narxi</th>
        <th>Necha olasiz</th>
    </tr>

    <tr>
        <td>
            <img src="/photoSee?productId=${product.id}" alt="Rasm mavjud emas"
                 width="120" height="120" class="zoomable">
        </td>

        <td>${product.name}</td>
        <td>${product.price} so'm</td>

        <td>
            <form action="/product-take" method="post">
                <input type="hidden" name="id" value="${product.id}">
                <div class="qty-box">
                    <button type="button" class="qty-btn" onclick="minus()">-</button>
                    <input type="number" id="qty" class="qty-input" name="quantity"
                           min="1" value="1" max="${product.quantity}" required>
                    <button type="button" class="qty-btn" onclick="plus()">+</button>
                </div>
                <br>
                <button type="submit">Olish</button>
            </form>
        </td>
    </tr>

</table>

<div style="text-align:center;">
    <a href="/homeUser" class="backBtn">Ortga qaytish</a>
</div>

<!-- Modal rasm -->
<div id="imgModal" class="modal">
    <span class="modal-close">&times;</span>
    <img class="modal-content" id="modalImg">
</div>

<script>
    function minus() {
        const input = document.getElementById("qty");
        if (parseInt(input.value) > 1) input.value = parseInt(input.value) - 1;
    }

    function plus() {
        const input = document.getElementById("qty");
        const max = parseInt(input.max);
        if (parseInt(input.value) < max) input.value = parseInt(input.value) + 1;
    }

    // Modal rasm kattalashtirish
    const modal = document.getElementById("imgModal");
    const modalImg = document.getElementById("modalImg");
    const closeBtn = document.getElementsByClassName("modal-close")[0];

    document.querySelectorAll(".zoomable").forEach(img => {
        img.addEventListener("click", function() {
            modal.style.display = "block";
            modalImg.src = this.src;
        });
    });

    closeBtn.onclick = function() { modal.style.display = "none"; }
    window.onclick = function(event) {
        if(event.target === modal) modal.style.display = "none";
    }
</script>

</body>
</html>
