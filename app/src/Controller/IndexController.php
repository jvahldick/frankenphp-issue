<?php

declare(strict_types=1);

namespace App\Controller;

use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

final class IndexController
{
    #[Route('/', name: 'app_index')]
    public function index()
    {
        usleep(100000);

        return new Response('index');
    }
}
