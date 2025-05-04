<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Cari Magang is a platform to find internships easily." />
    <meta name="keywords" content="internship, job, career, find internship" />
    <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/9366/9366528.png" type="image/x-icon" />
    <script src="https://cdn.tailwindcss.com"></script>
    <title>{{ $title ?? 'Page Title' }} | Cari Magang</title>
    <style>
        @keyframes pulse {

            0%,
            100% {
                opacity: 0.2;
            }

            50% {
                opacity: 0.5;
            }
        }


        ::selection {
            background-color: #F66527;
            color: #fff;
        }
    </style>
</head>

<body>
    {{ $slot }}
</body>

</html>
