<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="uz">
<head>
    <meta charset="UTF-8">
    <title>Kategoriya qo‘shish</title>
    <style>
        /* Basic reset */
        * { margin:0; padding:0; box-sizing:border-box; font-family:'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }

        body {
            background: linear-gradient(to bottom, #e0f7fa, #ffffff);
            padding: 50px;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        form {
            background: rgba(255,255,255,0.9);
            padding: 30px 40px;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 400px;
            text-align: center;
        }

        h2 {
            margin-bottom: 25px;
            color: #00796b;
            text-shadow: 1px 1px 2px #b2dfdb;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #004d40;
            text-align: left;
        }

        input[type="text"] {
            width: 100%;
            padding: 10px 12px;
            margin-bottom: 15px;
            border-radius: 5px;
            border: 1px solid #b2dfdb;
        }

        #preview {
            display: none;
            margin-bottom: 15px;
            max-width: 100%;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }

        div {
            display: flex;
            justify-content: space-between;
        }

        button {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        button[type="submit"] {
            background-color: #00796b;
            color: #fff;
        }

        button[type="submit"]:hover {
            background-color: #004d40;
        }

        button[type="button"] {
            background-color: #e0e0e0;
        }

        button[type="button"]:hover {
            background-color: #b2dfdb;
        }

        button a {
            text-decoration: none;
            color: inherit;
        }
    </style>
</head>
<body>

<form id="categoryForm" action="/category" method="post">
    <h2>Kategoriya qo‘shish</h2>

    <label for="filename">Fayl nomi:</label>
    <input type="text" id="filename" name="name" placeholder="example.jpg" required>

    <!-- Preview rasm -->
    <img id="preview" alt="Preview">

    <div>
        <button type="submit">Saqlash</button>
        <button type="button">
            <a href="/homeAdmin">Ortga qaytish</a>
        </button>
    </div>
</form>

<script>
    // Form submit oldidan input tekshiruvi
    const form = document.getElementById('categoryForm');
    const filenameInput = document.getElementById('filename');
    const previewImg = document.getElementById('preview');

    form.addEventListener('submit', function(e){
        if(filenameInput.value.trim() === ''){
            alert('Iltimos, fayl nomini kiriting!');
            e.preventDefault();
        }
    });

    // Preview rasm funksiyasi
    filenameInput.addEventListener('input', function(){
        const value = filenameInput.value.trim();
        if(value.match(/\.(jpeg|jpg|png)$/i)){
            previewImg.src = '/uploads/' + value; // serverda saqlangan joyni moslang
            previewImg.style.display = 'block';
        } else {
            previewImg.style.display = 'none';
        }
    });
</script>

</body>
</html>
