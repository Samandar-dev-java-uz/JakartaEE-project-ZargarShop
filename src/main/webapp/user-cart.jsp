<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="uz">
<head>
    <meta charset="UTF-8">
    <title>Savat</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background: linear-gradient(120deg, #e0f7fa, #ffffff);
        }

        h2 {
            text-align: center;
            color: #00796b;
            margin-top: 30px;
        }

        .container {
            width: 90%;
            max-width: 900px;
            margin: 30px auto;
            background: #ffffff;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        table {
            width: 100%;
            border-collapse: collapse;
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
            background-color: #b2ebf2;
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
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            background: #2563eb;
            color: white;
            cursor: pointer;
            transition: 0.3s;
        }

        button:hover {
            background: #1e3a8a;
        }

        .deleteBtn {
            background: #ef4444;
        }

        .deleteBtn:hover {
            background: #b91c1c;
        }

        .backBtn {
            background: #6b7280;
            margin-top: 20px;
            width: auto;
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

        /* Responsive */
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

<div class="container">

    <h2>Savat</h2>

    <c:choose>
        <c:when test="${empty cart or empty cart.cartItems}">
            <p style="text-align:center; font-size:16px; color:#555;">Savat bo'sh.</p>
        </c:when>

        <c:otherwise>

            <c:set var="total" value="0" />

            <table>
                <thead>
                <tr>
                    <th>Rasm</th>
                    <th>Nomi</th>
                    <th>Miqdor</th>
                    <th>Jami</th>
                    <th>Amallar</th>
                </tr>
                </thead>

                <tbody>
                <c:forEach var="item" items="${cart.cartItems}">
                    <tr>
                        <td data-label="Rasm">
                            <c:choose>
                                <c:when test="${not empty item.product.image}">
                                    <img src="/photoSee?productId=${item.product.id}" alt="${item.product.name}" width="70" height="70" class="zoomable">
                                </c:when>
                                <c:otherwise>
                                    N/A
                                </c:otherwise>
                            </c:choose>
                        </td>

                        <td data-label="Nomi">${item.product.name}</td>
                        <td data-label="Miqdor">${item.quantity}</td>

                        <td data-label="Jami">
                            <c:set var="lineTotal" value="${item.product.price * item.quantity}" />
                                ${lineTotal}
                        </td>

                        <td data-label="Amallar">
                            <form action="/product-cart" method="post">
                                <input type="hidden" name="cartItemId" value="${item.id}">
                                <input type="hidden" name="quantity" value="${item.quantity}">
                                <input type="hidden" name="productId" value="${item.product.id}">
                                <button type="submit" class="deleteBtn">O'chirish</button>
                            </form>
                        </td>
                    </tr>

                    <c:set var="total" value="${total + lineTotal}" />
                </c:forEach>
                </tbody>

                <tfoot>
                <tr>
                    <td colspan="3" style="text-align:right;"><b>Umumiy:</b></td>
                    <td><b>${total}</b></td>
                    <td></td>
                </tr>
                </tfoot>
            </table>

            <br>

            <form action="/click-cart" method="post" style="text-align:center;">
                <input type="hidden" name="total_price" value="${total}">
                <button type="submit">To'lovga o'tish</button>
            </form>

        </c:otherwise>
    </c:choose>

    <div style="text-align:center;">
        <button type="button" class="backBtn">
            <a href="/homeUser">Ortga qaytish</a>
        </button>
    </div>

</div>

<!-- Modal HTML -->
<div id="imgModal" class="modal">
    <span class="modal-close">&times;</span>
    <img class="modal-content" id="modalImg">
</div>

<script>
    // Modal uchun JS
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
        if(event.target == modal) {
            modal.style.display = "none";
        }
    }
</script>

</body>
</html>
