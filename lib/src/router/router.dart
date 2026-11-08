part of 'router.import.dart';

final GlobalKey<NavigatorState> navigatorKey =
    GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: AppRoute.getStarted.path,
  routes: [
    ...authRoutes,
    ...mainRoutes,
  ],
);
