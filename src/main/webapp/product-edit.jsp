<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html lang="uz">
<head>
    <meta charset="UTF-8">
    <title>Mahsulot yuklash</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(120deg, #eaf6ff, #ffffff);
            margin: 0;
            padding: 0;
        }

        form {
            width: 400px;
            margin: 40px auto;
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
        }

        h3 {
            text-align: center;
            color: #008CFF;
            margin-bottom: 25px;
        }

        label {
            font-weight: bold;
            color: #333;
        }

        input, select {
            width: 100%;
            padding: 10px;
            margin-top: 6px;
            margin-bottom: 18px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 14px;
            transition: 0.3s;
        }

        input:focus, select:focus {
            border-color: #008CFF;
            box-shadow: 0 0 6px rgba(0, 140, 255, 0.5);
        }

        button {
            width: 100%;
            background: #008CFF;
            border: none;
            padding: 12px;
            color: white;
            font-size: 16px;
            font-weight: bold;
            border-radius: 8px;
            cursor: pointer;
            transition: 0.3s;
            margin-bottom: 10px;
        }

        button:hover {
            background: #006fd6;
            transform: translateY(-2px);
        }

        /* ortga qaytish tugmasi */
        button a {
            color: white;
            text-decoration: none;
            display: block;
        }

        /* Mobil uchun responsive */
        @media (max-width: 480px) {
            form {
                width: 90%;
                margin-top: 20px;
            }
        }
    </style>
</head>

<body>

<form action="/product-edit" method="post" enctype="multipart/form-data">
    <h3>Mahsulotni o'zgartirish</h3>

    <label for="fileInput">Rasm faylini tanlang:</label>
    <input type="file" id="fileInput" name="file" accept="image/*">

    <label for="price">Narx:</label>
    <input type="number" id="price" name="price" value="${product.price}" required>

    <label for="quantity">Miqdor:</label>
    <input type="number" id="quantity" name="quantity" value="${product.quantity}" required>

    <label for="filename">Fayl nomi:</label>
    <input type="text" id="filename" name="name" value="${product.name}" required>

    <label for="category">Kategoriya tanlang:</label>
    <select id="category" name="categoryId" required>
        <option value="">-- Tanlang --</option>
        <c:forEach var="category" items="${categories}">
            <option value="${category.id}">${category.name}</option>
        </c:forEach>
    </select>

    <input type="hidden" name="id" value="${product.id}">

    <button type="submit">O'zgartirish</button>

    <button type="button">
        <a href="/homeAdmin">Ortga qaytish</a>
    </button>
</form>

</body>
</html>
