part of 'router.import.dart';

final List<RouteBase> mainRoutes = [
  GoRoute(
    path: AppRoute.home.path,
    builder: (context, state) => const HomeScreen(),
  ),
];
