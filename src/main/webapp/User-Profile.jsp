<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="uz">
<head>
    <meta charset="UTF-8">
    <title>Foydalanuvchi Profili</title>
    <style>
        /* Reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        }

        body {
            background: linear-gradient(to bottom, #e0f7fa, #ffffff);
            color: #333;
        }

        /* Header */
        header {
            background-color: rgba(255, 255, 255, 0.9);
            padding: 20px 40px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            position: sticky;
            top: 0;
            z-index: 1000;
            border-radius: 0 0 15px 15px;
            transition: background-color 0.3s ease, transform 0.3s ease;
        }

        header.sticky {
            background-color: #b2ebf2;
            transform: scale(1.02);
        }

        header h1 {
            font-size: 28px;
            color: #00796b;
            margin-bottom: 10px;
            text-shadow: 1px 1px 2px #b2dfdb;
        }

        nav a {
            text-decoration: none;
            color: #00796b;
            font-weight: bold;
            margin-right: 20px;
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
            width: 90%;
            max-width: 900px;
            margin: 30px auto;
            background: rgba(255,255,255,0.85);
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 8px 15px rgba(0,0,0,0.1);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 12px;
            text-align: center;
            border-bottom: 1px solid #e0e0e0;
        }

        th {
            background-color: #00796b;
            color: white;
        }

        tbody tr:nth-child(even) {
            background-color: #f1f8f8;
        }

        tbody tr:hover {
            background-color: #d0f0f0;
            transform: scale(1.02);
            transition: all 0.2s ease-in-out;
        }

        img {
            border-radius: 6px;
            cursor: pointer;
            transition: 0.3s;
        }

        img:hover {
            transform: scale(1.1);
        }

        button {
            padding: 8px 15px;
            border: none;
            border-radius: 6px;
            background: #00796b;
            color: white;
            cursor: pointer;
            transition: 0.3s;
        }

        button:hover {
            background: #004d40;
        }

        .backBtn {
            background: #6b7280;
            margin-top: 20px;
        }

        .backBtn a {
            color: white;
            text-decoration: none;
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
            overflow: auto;
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

        @media(max-width:768px){
            table, thead, tbody, th, td, tr { display:block; }
            thead tr { display:none; }
            tbody tr { margin-bottom:15px; border:1px solid #b2dfdb; border-radius:8px; padding:10px; }
            tbody td { text-align:right; padding-left:50%; position:relative; }
            tbody td::before { content: attr(data-label); position:absolute; left:15px; width:calc(50% - 20px); font-weight:bold; text-align:left; }
        }

    </style>
</head>
<body>

<header id="mainHeader">
    <h1>Foydalanuvchi Profili</h1>
    <nav>
        <a href="/product-cart">Savatcha</a>
        <a href="/orders-view">Buyurtmalar</a>
        <a href="${pageContext.request.contextPath}/">Chiqish</a>
    </nav>
</header>

<div class="container">
    <table>
        <thead>
        <tr>
            <th>Rasm</th>
            <th>Nomi</th>
            <th>Narxi</th>
            <th>Miqdori</th>
            <th>Take</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="product" items="${products}">
            <tr>
                <td data-label="Rasm">
                    <img src="/photoSee?productId=${product.id}" width="100" height="100" class="zoomable" alt="Rasm mavjud emas"/>
                </td>
                <td data-label="Nomi">${product.name}</td>
                <td data-label="Narxi">${product.price}</td>
                <td data-label="Miqdori">${product.quantity}</td>
                <td data-label="Take">
                    <form action="/product-take" method="get" style="margin:0;">
                        <input type="hidden" name="id" value="${product.id}" />
                        <button type="submit">Take</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <div style="text-align:center;">
        <button type="button" class="backBtn"><a href="/homeUser">Ortga qaytish</a></button>
    </div>
</div>

<!-- Modal rasm -->
<div id="imgModal" class="modal">
    <span class="modal-close">&times;</span>
    <img class="modal-content" id="modalImg">
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

    closeBtn.onclick = function() {
        modal.style.display = "none";
    }

    window.onclick = function(event) {
        if(event.target === modal) {
            modal.style.display = "none";
        }
    }
</script>

</body>
</html>
