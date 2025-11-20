<!DOCTYPE html>
<html lang="uz">
<head>
    <meta charset="UTF-8">
    <title>Zargarlik Do'koni</title>
    <style>
        /* Reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        }

        body {
            background: linear-gradient(to bottom, #e0f7fa, #ffffff); /* Oq-ko‘k fon */
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
            font-size: 30px;
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

        /* Body sections */
        section {
            padding: 100px 40px;
            border-radius: 20px;
            margin: 30px 20px;
            background: rgba(255, 255, 255, 0.8);
            box-shadow: 0 8px 15px rgba(0,0,0,0.1);
            transition: transform 0.3s;
        }

        section:hover {
            transform: translateY(-5px);
        }

        section h2 {
            font-size: 26px;
            color: #00796b;
            margin-bottom: 15px;
        }

        section p {
            font-size: 18px;
            line-height: 1.6;
            color: #004d40;
        }
    </style>
</head>
<body>
<!-- Header -->
<header id="mainHeader">
    <h1>Zargarlik Do'koni</h1>
    <nav>
        <a href="#home">Bosh sahifa</a>
        <a href="#products">Mahsulotlar</a>
        <a href="#about">Biz haqimizda</a>
        <a href="/userLogin">Sign Up</a>
        <a href="/userLogUp">Sign In</a>
    </nav>
</header>

<!-- Body Sections -->
<section id="home">
    <h2>Bosh sahifa</h2>
    <p>Bizning yangi zargarlik kolleksiyamiz bilan tanishing. Har bir buyum sizning uslubingizni aks ettiradi.</p>
</section>

<section id="products">
    <h2>Mahsulotlar</h2>
    <p>Yuzlab noyob zargarlik buyumlarimiz mavjud. Har bir detal mukammal ishlangan va sifatli materiallardan tayyorlangan.</p>
</section>

<section id="about">
    <h2>Biz haqimizda</h2>
    <p>Zargarlik san'atini sevgan mutaxassislar jamoasi. Bizning maqsadimiz sizga eng sifatli va jozibali buyumlarni taqdim etish.</p>
</section>

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

    // Smooth scroll for nav links
    const links = document.querySelectorAll('nav a[href^="#"]');
    for(let link of links){
        link.addEventListener('click', function(e){
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            target.scrollIntoView({ behavior: 'smooth' });
        });
    }
</script>
</body>
</html>
