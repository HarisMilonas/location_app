import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_app/2_application/core/page_config.dart';
import 'package:test_app/2_application/pages/create_todo_collection/create_todo_collection_page.dart';
import 'package:test_app/2_application/pages/dashboard/dashboard_page.dart';
import 'package:test_app/2_application/pages/details/todo_detail_page.dart';
import 'package:test_app/2_application/pages/home/cubit/navigation_todo_cubit.dart';
import 'package:test_app/2_application/pages/overview/overview_page.dart';
import 'package:test_app/2_application/pages/settings/settings_page.dart';
import 'package:test_app/2_application/pages/task/task_page.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key, required String tab})
      : index = tabs.indexWhere((element) => element.name == tab);

  static const PageConfig pageConfig =
      PageConfig(icon: Icons.home_rounded, name: 'home');

  final int index;

  static const tabs = [
    DashboardPage.pageConfig,
    OverviewPage.pageConfig,
    TaskPage.pageConfig
  ];

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final destinations = HomePage.tabs
      .map((page) =>
          NavigationDestination(icon: Icon(page.icon), label: page.name))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: AdaptiveLayout(
        primaryNavigation: SlotLayout(config: {
          Breakpoints.mediumAndUp: SlotLayout.from(
            key: const Key('primary-navigation-medium'),
            builder: (context) => AdaptiveScaffold.standardNavigationRail(
              leading: IconButton(
                onPressed: () {
                  context.pushNamed(CreateTodoCollectionPage.pageConfig.name);
                },
                icon: Icon(CreateTodoCollectionPage.pageConfig.icon),
                tooltip: 'Add Collection',
              ),
              trailing: IconButton(
                  onPressed: () =>
                      context.goNamed(SettingsPage.pageConfig.name),
                  icon: Icon(SettingsPage.pageConfig.icon)),
              selectedIndex: widget.index,
              selectedLabelTextStyle:
                  TextStyle(color: Theme.of(context).colorScheme.secondary),
              selectedIconTheme:
                  IconThemeData(color: Theme.of(context).colorScheme.secondary),
              unselectedIconTheme: IconThemeData(
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.5)),
              destinations: destinations
                  .map((element) => AdaptiveScaffold.toRailDestination(element))
                  .toList(),
              onDestinationSelected: (p0) =>
                  _tapOnNavigationDestination(context, p0),
            ),
          ),
        }),
        bottomNavigation: SlotLayout(config: {
          // because medium an up are using the other configuration
          Breakpoints.small: SlotLayout.from(
            key: const Key('bottom-navigation-small'),
            builder: (context) => AdaptiveScaffold.standardBottomNavigationBar(
              currentIndex: widget.index,
              destinations: destinations,
              onDestinationSelected: (value) =>
                  _tapOnNavigationDestination(context, value),
            ),
          )
        }),
        body: SlotLayout(config: {
          Breakpoints.smallAndUp: SlotLayout.from(
              key: const Key('primary-body'),
              builder: (_) => HomePage.tabs[widget.index].child)
        }),
        secondaryBody: SlotLayout(config: {
          Breakpoints.mediumAndUp: SlotLayout.from(
            key: const Key('secondary-body'),
            builder: widget.index != 1
                ? null
                : (_) => BlocBuilder<NavigationTodoCubit, NavigationTodoState>(
                      builder: (context, state) {
                        final selectedId = state.selectedCollectionId;
                        //check also if we are on small screen
                        final isSecondBodyDisplayed =
                            Breakpoints.mediumAndUp.isActive(context);

                        //and update it
                        context
                            .read<NavigationTodoCubit>()
                            .secondBodyHasChanged(
                                isSecondBodyDisplayed: isSecondBodyDisplayed);
                        if (selectedId == null) {
                          return const Placeholder();
                        }
                        return ToDoDetailPageProvider(
                            //! We need to add key here because otherwise flutter won't rebuild the second page
                            //! because it does not uderstand any difference! But if we change the key it will!
                            key: Key(selectedId.value),
                            collectionId: selectedId);
                      },
                    ),
          )
        }),
      )),
    );
  }

  void _tapOnNavigationDestination(BuildContext context, int index) =>
      context.goNamed(HomePage.pageConfig.name,
          pathParameters: {'tab': HomePage.tabs[index].name});
}
