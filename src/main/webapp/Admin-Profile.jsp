<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="uz">
<head>
    <meta charset="UTF-8">
    <title>Admin Profile</title>
    <style>
        /* --- Basic Reset --- */
        * { margin:0; padding:0; box-sizing:border-box; font-family:'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }

        /* Body with oq-ko‘k gradient */
        body {
            background: linear-gradient(to bottom, #e0f7fa, #ffffff);
            color:#2f3640;
            line-height:1.6;
            padding:20px;
        }

        header { display:flex; flex-direction:column; align-items:flex-start; margin-bottom:20px; }
        header h1 { color:#00796b; margin-bottom:10px; text-shadow:1px 1px 2px #b2dfdb; }

        nav { margin-bottom:20px; }
        nav select { padding:6px 10px; margin-right:10px; border-radius:5px; border:1px solid #b2dfdb; cursor:pointer; background:#ffffff; color:#00796b; font-weight:bold; }
        nav a { margin-right:15px; text-decoration:none; color:#00796b; font-weight:bold; transition:color 0.3s; }
        nav a:hover { color:#004d40; }

        h2 { margin-bottom:10px; color:#004d40; }

        table { width:100%; border-collapse:collapse; background:rgba(255,255,255,0.9); border-radius:10px; overflow:hidden; box-shadow:0 5px 15px rgba(0,0,0,0.1); }
        thead { background-color:#00796b; color:#fff; }
        th, td { padding:12px 15px; text-align:center; }
        tbody tr:nth-child(even) { background-color:rgba(255,255,255,0.7); }
        tbody tr:hover { background-color:#b2ebf2; transform:scale(1.02); transition:all 0.2s ease-in-out; }
        img { border-radius:5px; cursor:pointer; }

        button { padding:6px 12px; border:none; border-radius:5px; cursor:pointer; font-weight:bold; transition:all 0.3s ease; }
        button.update-btn { background-color:#44bd32; color:#fff; }
        button.update-btn:hover { background-color:#4cd137; }
        button.delete-btn { background-color:#e84118; color:#fff; }
        button.delete-btn:hover { background-color:#c23616; }

        /* Modal CSS */
        .modal {
            display:none;
            position:fixed;
            z-index:1000;
            left:0;
            top:0;
            width:100%;
            height:100%;
            overflow:auto;
            background-color: rgba(0,0,0,0.8);
        }
        .modal-content {
            margin: 5% auto;
            display:block;
            max-width:80%;
            max-height:80%;
            border-radius:10px;
        }
        .modal-close {
            position:absolute;
            top:20px;
            right:35px;
            color:#fff;
            font-size:40px;
            font-weight:bold;
            cursor:pointer;
        }

        /* Responsive for mobile */
        @media(max-width:768px){
            table, thead, tbody, th, td, tr { display:block; }
            thead tr { display:none; }
            tbody tr { margin-bottom:15px; border:1px solid #b2dfdb; border-radius:8px; padding:10px; }
            tbody td { text-align:right; padding-left:50%; position:relative; }
            tbody td::before { content: attr(data-label); position:absolute; left:15px; width:calc(50% - 20px); font-weight:bold; text-align:left; }
            img { width:80px; height:80px; }
        }
    </style>
</head>
<body>

<header>
    <h1>Admin Profile</h1>
    <nav>
        <select id="productSelect" onchange="goToPage(this.value)">
            <option value="">Mahsulotlar</option>
            <option value="/category">Category create</option>
            <option value="/product-add">Product add</option>
        </select>
        <a href="/information-user">Users Information</a>
        <a href="/admin-orders-see">Orders</a>
        <a href="/admin-orders-cancel-see">Cancel the Orders</a>
        <a href="/">Out</a>
    </nav>
</header>

<h2>Mahsulotlar ro‘yxati</h2>

<table>
    <thead>
    <tr>
        <th>Rasm</th>
        <th>Nomi</th>
        <th>Narxi</th>
        <th>Miqdori</th>
        <th>Update</th>
        <th>Delete</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="product" items="${products}">
        <tr>
            <td data-label="Rasm">
                <img src="/photoSee?productId=${product.id}" alt="Rasm mavjud emas" width="100" height="100"
                     onclick="openModal(this.src)">
            </td>
            <td data-label="Nomi">${product.name}</td>
            <td data-label="Narxi">${product.price}</td>
            <td data-label="Miqdori">${product.quantity}</td>

            <td data-label="Update">
                <form action="/product-edit" method="get" style="margin:0;">
                    <input type="hidden" name="id" value="${product.id}" />
                    <button type="submit" class="update-btn">Update</button>
                </form>
            </td>

            <td data-label="Delete">
                <form action="/product-delete" method="get" style="margin:0;"
                      onsubmit="return confirm('Are you sure you want to delete this product?');">
                    <input type="hidden" name="id" value="${product.id}" />
                    <button type="submit" class="delete-btn">Delete</button>
                </form>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<!-- Modal Structure -->
<div id="imgModal" class="modal">
    <span class="modal-close" onclick="closeModal()">&times;</span>
    <img class="modal-content" id="modalImage">
</div>

<script>
    function goToPage(url){
        if(url){
            window.location.href = url;
        }
    }

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

    // Modalni fon bosilganda yopish
    window.onclick = function(event){
        const modal = document.getElementById('imgModal');
        if(event.target === modal){
            modal.style.display = "none";
        }
    }
</script>

</body>
</html>
