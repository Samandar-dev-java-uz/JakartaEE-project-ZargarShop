<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="uz">
<head>
    <meta charset="UTF-8">
    <title>Product List</title>

    <style>
        * { margin:0; padding:0; box-sizing:border-box; font-family:'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }

        body {
            background: linear-gradient(to bottom, #e0f7fa, #ffffff);
            padding: 40px;
        }

        nav {
            background-color: #00796b;
            padding: 15px 20px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            display: flex;
            gap: 20px;
            justify-content: center;
        }

        nav a {
            color: #ffffff;
            font-weight: bold;
            text-decoration: none;
            padding: 10px 15px;
            border-radius: 6px;
            transition: all 0.3s ease;
        }

        nav a:hover {
            background-color: #004d40;
            transform: scale(1.1);
        }

        h2 {
            margin-top: 30px;
            text-align: center;
            color: #00796b;
            text-shadow: 1px 1px 2px #b2dfdb;
        }

        /* Back Button */
        #backBtn {
            margin-top: 25px;
            display: block;
            background-color: #00796b;
            border:none;
            border-radius: 6px;
            padding: 10px 20px;
            color:white;
            cursor:pointer;
            font-weight:bold;
            transition:0.3s;
        }

        #backBtn:hover {
            background-color:#004d40;
        }

    </style>
</head>
<body>

<nav>
    <a href="/InformationUser">Category</a>
    <a href="/product-add">Add Product</a>
</nav>

<h2>Product Menu</h2>

<button id="backBtn">Ortga qaytish</button>

<script>
    document.getElementById("backBtn").addEventListener("click", function () {
        window.location.href = "/homeAdmin";
    });
</script>

</body>
</html>
