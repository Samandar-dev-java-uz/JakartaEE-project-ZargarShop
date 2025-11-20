<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="uz">
<head>
    <meta charset="UTF-8">
    <title>Mahsulot yuklash</title>

    <style>
        * { margin:0; padding:0; box-sizing:border-box; font-family:'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }

        body {
            background: linear-gradient(to bottom, #e0f7fa, #ffffff);
            padding: 40px;
            display:flex;
            justify-content:center;
        }

        form {
            background:white;
            padding:25px;
            width:450px;
            border-radius:12px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.15);
        }

        h3 {
            text-align:center;
            margin-bottom:25px;
            color:#00796b;
            text-shadow: 1px 1px 2px #b2dfdb;
        }

        label {
            font-weight:bold;
            color:#004d40;
        }

        input, select {
            width:100%;
            padding:10px;
            margin-top:5px;
            margin-bottom:20px;
            border:1px solid #b2dfdb;
            border-radius:6px;
            outline:none;
            transition:0.3s;
        }

        input:focus, select:focus {
            border-color:#00796b;
            box-shadow:0 0 5px rgba(0,150,136,0.5);
        }

        /* Preview image */
        #preview {
            width:100%;
            max-height:250px;
            object-fit:cover;
            border-radius:8px;
            display:none;
            margin-bottom:15px;
            box-shadow:0 4px 12px rgba(0,0,0,0.2);
        }

        button {
            padding:10px 20px;
            border:none;
            border-radius:6px;
            font-weight:bold;
            cursor:pointer;
            transition:0.3s;
        }

        button[type="submit"] {
            background:#00796b;
            color:white;
            width:100%;
        }

        button[type="submit"]:hover { background:#004d40; }

        a {
            text-decoration:none;
            color:white;
        }

        .back-btn {
            margin-top:10px;
            background:#e67e22;
            width:100%;
            color:white;
        }

        .back-btn:hover { background:#d35400; }
    </style>
</head>

<body>

<form action="/product-add" method="post" enctype="multipart/form-data">

    <h3>Mahsulot Yuklash</h3>

    <!-- Rasm ko‘rsatish -->
    <img id="preview" alt="Rasm yo‘q">

    <!-- Fayl tanlash -->
    <label for="fileInput">Rasm faylini tanlang:</label>
    <input type="file" id="fileInput" name="file" accept="image/*" required>

    <!-- Narx -->
    <label for="price">Narx:</label>
    <input type="number" id="price" name="price" required>

    <!-- Miqdor -->
    <label for="quantity">Miqdor:</label>
    <input type="number" id="quantity" name="quantity" required>

    <!-- Fayl nomi -->
    <label for="filename">Fayl nomi:</label>
    <input type="text" id="filename" name="name" placeholder="example.jpg" required>

    <!-- Kategoriya -->
    <label for="category">Kategoriya tanlang:</label>
    <select id="category" name="categoryId" required>
        <option value="">-- Tanlang --</option>
        <c:forEach var="category" items="${categories}">
            <option value="${category.id}">${category.name}</option>
        </c:forEach>
    </select>

    <!-- Yuborish -->
    <button type="submit">Yuklash</button>

    <!-- Ortga qaytish -->
    <button type="button" class="back-btn" onclick="window.location.href='/homeAdmin'">
        Ortga qaytish
    </button>

</form>

<script>
    // Live Image Preview
    const fileInput = document.getElementById("fileInput");
    const preview = document.getElementById("preview");

    fileInput.addEventListener("change", function () {
        const file = this.files[0];
        if (file) {
            preview.style.display = "block";
            preview.src = URL.createObjectURL(file);
        }
    });
</script>

</body>
</html>
