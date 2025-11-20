<!DOCTYPE html>
<html lang="uz">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login sahifa</title>
    <style>
        /* Basic reset */
        * { margin:0; padding:0; box-sizing:border-box; font-family:'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }

        body {
            background: linear-gradient(to bottom, #e0f7fa, #ffffff);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
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

        input[type="text"],
        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 10px 12px;
            margin-bottom: 20px;
            border-radius: 5px;
            border: 1px solid #b2dfdb;
            transition: all 0.3s ease;
        }

        input[type="text"]:focus,
        input[type="email"]:focus,
        input[type="password"]:focus {
            border-color: #00796b;
            box-shadow: 0 0 5px #00796b;
            outline: none;
        }

        button[type="submit"] {
            padding: 10px 25px;
            border: none;
            border-radius: 5px;
            font-weight: bold;
            cursor: pointer;
            background-color: #00796b;
            color: #fff;
            transition: all 0.3s ease;
        }

        button[type="submit"]:hover {
            background-color: #004d40;
        }
    </style>
</head>
<body>

<form id="loginForm" action="/userLogin" method="post">
    <h2>Login</h2>

    <label for="username">Username:</label>
    <input type="text" id="username" name="username" placeholder="Ismingizni kiriting" required>

    <label for="email">Email:</label>
    <input type="email" id="email" name="email" placeholder="Email kiriting" required>

    <label for="password">Parol:</label>
    <input type="password" id="password" name="password" placeholder="Parolni kiriting" required>

    <button type="submit">Kirish</button>
</form>

<script>
    // Form submit tekshiruvi
    const form = document.getElementById('loginForm');
    form.addEventListener('submit', function(e){
        const username = document.getElementById('username').value.trim();
        const email = document.getElementById('email').value.trim();
        const password = document.getElementById('password').value.trim();

        if(!username || !email || !password){
            alert('Iltimos, barcha maydonlarni to‘ldiring!');
            e.preventDefault();
        }
    });
</script>

</body>
</html>
