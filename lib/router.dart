import 'package:easyweather_v2/presentation/details_screen.dart';
import 'package:easyweather_v2/presentation/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(routes: [
  GoRoute(
    path: '/',
    name: 'home-screen',
    pageBuilder: (context, state) {
      return const MaterialPage(child: HomeScreen());
    },
  ),
  GoRoute(
    path: '/details-screen',
    name: 'details-screen',
    pageBuilder: (context, state) {
      return const MaterialPage(child: DetailsScreen());
    },
  )
]);
