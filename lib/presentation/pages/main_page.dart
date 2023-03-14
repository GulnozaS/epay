import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/main_cubit.dart';
import '../route.gr.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit(),
      child: AutoTabsRouter(
        routes: const [
          HomeRoute(),
          AddCardRoute(),
          PaymentRoute(),
        ],
        builder: (context, child, animation) {
          final tabsRouter = AutoTabsRouter.of(context);
          return Scaffold(
              resizeToAvoidBottomInset: false,
              body: FadeTransition(
                opacity: animation,
                child: child,
              ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: tabsRouter.activeIndex,
                onTap: (index) {
                  tabsRouter.setActiveIndex(index);
                },
                items: const [
                  BottomNavigationBarItem(
                      label: 'Home', icon: Icon(Icons.home)),
                  BottomNavigationBarItem(
                      label: 'Add', icon: Icon(Icons.add_circle_outline)),
                  BottomNavigationBarItem(
                      label: 'Pay', icon: Icon(Icons.payment)),
                ],
              ));
        },
      ),
    );
  }
}
