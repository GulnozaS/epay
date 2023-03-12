// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;

import 'pages/add_card_page.dart' as _i3;
import 'pages/home_page.dart' as _i2;
import 'pages/main_page.dart' as _i1;
import 'pages/payment_page.dart' as _i4;

class AppRouter extends _i5.RootStackRouter {
  AppRouter([_i6.GlobalKey<_i6.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    MainRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i1.MainPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.HomePage(),
      );
    },
    AddCardRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.AddCardPage(),
      );
    },
    PaymentRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.PaymentPage(),
      );
    },
  };

  @override
  List<_i5.RouteConfig> get routes => [
        _i5.RouteConfig(
          MainRoute.name,
          path: '/',
          children: [
            _i5.RouteConfig(
              '#redirect',
              path: '',
              parent: MainRoute.name,
              redirectTo: 'home',
              fullMatch: true,
            ),
            _i5.RouteConfig(
              HomeRoute.name,
              path: 'home',
              parent: MainRoute.name,
            ),
            _i5.RouteConfig(
              AddCardRoute.name,
              path: 'add-card',
              parent: MainRoute.name,
            ),
            _i5.RouteConfig(
              PaymentRoute.name,
              path: 'user',
              parent: MainRoute.name,
            ),
          ],
        )
      ];
}

/// generated route for
/// [_i1.MainPage]
class MainRoute extends _i5.PageRouteInfo<void> {
  const MainRoute({List<_i5.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'MainRoute';
}

/// generated route for
/// [_i2.HomePage]
class HomeRoute extends _i5.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: 'home',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i3.AddCardPage]
class AddCardRoute extends _i5.PageRouteInfo<void> {
  const AddCardRoute()
      : super(
          AddCardRoute.name,
          path: 'add-card',
        );

  static const String name = 'AddCardRoute';
}

/// generated route for
/// [_i4.PaymentPage]
class PaymentRoute extends _i5.PageRouteInfo<void> {
  const PaymentRoute()
      : super(
          PaymentRoute.name,
          path: 'user',
        );

  static const String name = 'PaymentRoute';
}
