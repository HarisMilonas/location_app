import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_app/1_domain/entitites/unique_id.dart';
import 'package:test_app/2_application/core/go_router_observer.dart';
import 'package:test_app/2_application/pages/create_todo_collection/create_todo_collection_page.dart';
import 'package:test_app/2_application/pages/create_todo_entry/create_todo_entry_page.dart';
import 'package:test_app/2_application/pages/dashboard/dashboard_page.dart';
import 'package:test_app/2_application/pages/details/todo_detail_page.dart';
import 'package:test_app/2_application/pages/home/cubit/navigation_todo_cubit.dart';

import 'package:test_app/2_application/pages/home/home_page.dart';
import 'package:test_app/2_application/pages/overview/overview_page.dart';
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
    GoRoute(
      name: CreateTodoCollectionPage.pageConfig.name,
      path: '$_basePath/overview/${CreateTodoCollectionPage.pageConfig.name}',
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: const Text('create collection'),
          leading: BackButton(
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.goNamed(
                  HomePage.pageConfig.name,
                  pathParameters: {'tab': OverviewPage.pageConfig.name},
                );
              }
            },
          ),
        ),
        body: SafeArea(child: CreateTodoCollectionPage.pageConfig.child),
      ),
    ),
     GoRoute(
      name: CreateTodoEntryPage.pageConfig.name,
      path: '$_basePath/overview/${CreateTodoEntryPage.pageConfig.name}',
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: const Text('create todo entry'),
          leading: BackButton(
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.goNamed(
                  HomePage.pageConfig.name,
                  pathParameters: {'tab': OverviewPage.pageConfig.name},
                );
              }
            },
          ),
        ),
        body: SafeArea(child: CreateTodoEntryPageProvider(collectionId:
        // the difference betweeen extra and params is that params can be only a string where exra is an object 
         state.extra as CollectionId,)),
      ),
    ),

    GoRoute(
      name: TodoDetailPage.pageConfig.name,
      path: '$_basePath/overview/:collectionId',
      builder: (context, state) {
        return BlocListener<NavigationTodoCubit, NavigationTodoState>(
          listenWhen: (previous, current) =>
              previous.isSecondbodyDisplayed != current.isSecondbodyDisplayed,
          listener: (context, state) {
            debugPrint('Window Size Changed!');
            if (context.canPop() && (state.isSecondbodyDisplayed ?? false)) {
              context.pop();
            }
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text('details'),
              leading: BackButton(
                onPressed: () {
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    context.goNamed(
                      HomePage.pageConfig.name,
                      pathParameters: {'tab': OverviewPage.pageConfig.name},
                    );
                  }
                },
              ),
            ),
            body: ToDoDetailPageProvider(
              collectionId: CollectionId.fromUniqueString(
                state.pathParameters['collectionId'] ?? '',
              ),
            ),
          ),
        );
      },
    ),
  ],
);
