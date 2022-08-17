<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Laravel</title>

    <!-- Fonts -->
    <link href="https://fonts.bunny.net/css2?family=Nunito:wght@400;600;700&display=swap" rel="stylesheet">

    @vite('resources/css/app.css')

</head>
<body class="antialiased">

<div class="md:container p-10">

    <h1 class="text-3xl font-bold underline bg-green-200">
        Hello world with Tailwind styling!
    </h1>

    <hr />

    <div class="mt-5" id="app"></div>

</div>


@vite('resources/js/app.js')
</body>
</html>

