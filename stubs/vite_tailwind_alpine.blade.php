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

    <hr />

    <div class="mt-5" x-data="{ show: false }">
        <button class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded" @click="show = !show">Click on me</button>
        <h1 x-show="show">Alpine Js is working !</h1>
    </div>

</div>


@vite('resources/js/app.js')
</body>
</html>

