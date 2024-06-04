import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_app/2_application/core/go_router_observer.dart';
import 'package:test_app/2_application/pages/dashboard/dashboard_page.dart';
import 'package:test_app/2_application/pages/home/home_page.dart';
import 'package:test_app/2_application/pages/settings/settings_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

const String _basePath = '/home';

final routes = GoRouter(
  navigatorKey: _rootNavigatorKey,
  observers: [GoRouterObserver()],
  initialLocation: "$_basePath/${DashboardPage.pageConfig.name}",
  routes: [
    GoRoute(
        name: SettingsPage.pageConfig.name,
        path: '$_basePath/${SettingsPage.pageConfig.name}',
        builder: (context, state) => const SettingsPage()),
    // GoRoute(path: '/home', builder: (context, state) => const HomePage()),
    ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => child,
        routes: [
          GoRoute(
              name: HomePage.pageConfig.name,
              path: '$_basePath/:tab',
              builder: (context, state) => HomePage(
                    key: state.pageKey,
                    tab: state.pathParameters['tab'] ?? 'dashboard',
                  )),
        ]),
  ],
);
