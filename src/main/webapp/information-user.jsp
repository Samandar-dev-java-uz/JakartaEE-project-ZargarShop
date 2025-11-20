<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="uz">
<head>
    <meta charset="UTF-8">
    <title>Foydalanuvchilar ro‘yxati</title>
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

        input#search {
            margin-bottom: 15px;
            padding: 8px 12px;
            width: 300px;
            border-radius: 5px;
            border: 1px solid #b2dfdb;
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
        }
    </style>
</head>
<body>

<h2>Foydalanuvchilar ro‘yxati</h2>

<!-- Qidiruv input -->
<input type="text" id="search" placeholder="Foydalanuvchi ism yoki email bo‘yicha qidirish...">

<table id="usersTable">
    <thead>
    <tr>
        <th>ID</th>
        <th>Ism</th>
        <th>Email</th>
        <th>Parol</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="user" items="${users}">
        <tr>
            <td data-label="ID">${user.id}</td>
            <td data-label="Ism">${user.name}</td>
            <td data-label="Email">${user.email}</td>
            <td data-label="Parol">********</td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<button id="backBtn">
    <a href="/homeAdmin">Ortga qaytish</a>
</button>

<script>
    // Qidiruv funksiyasi
    const searchInput = document.getElementById('search');
    const table = document.getElementById('usersTable');
    const rows = table.getElementsByTagName('tbody')[0].getElementsByTagName('tr');

    searchInput.addEventListener('keyup', function(){
        const filter = searchInput.value.toLowerCase();
        for(let row of rows){
            const name = row.cells[1].textContent.toLowerCase();
            const email = row.cells[2].textContent.toLowerCase();
            if(name.includes(filter) || email.includes(filter)){
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        }
    });

    // Ortga qaytish tugmasini interaktiv qilish
    const backBtn = document.getElementById('backBtn');
    backBtn.addEventListener('click', function(e){
        e.preventDefault();
        window.location.href = '/homeAdmin';
    });
</script>

</body>
</html>
