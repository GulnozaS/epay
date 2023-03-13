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
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;

import 'pages/add_card/add_card_page.dart' as _i4;
import 'pages/edit_page.dart' as _i2;
import 'pages/home_page.dart' as _i3;
import 'pages/main_page.dart' as _i1;
import 'pages/payment_page.dart' as _i5;

class AppRouter extends _i6.RootStackRouter {
  AppRouter([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    MainRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.MainPage(),
      );
    },
    EditRoute.name: (routeData) {
      final args = routeData.argsAs<EditRouteArgs>();
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i2.EditPage(
          key: args.key,
          index: args.index,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.HomePage(),
      );
    },
    AddCardRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.AddCardPage(),
      );
    },
    PaymentRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.PaymentPage(),
      );
    },
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(
          MainRoute.name,
          path: '/',
          children: [
            _i6.RouteConfig(
              '#redirect',
              path: '',
              parent: MainRoute.name,
              redirectTo: 'home',
              fullMatch: true,
            ),
            _i6.RouteConfig(
              HomeRoute.name,
              path: 'home',
              parent: MainRoute.name,
            ),
            _i6.RouteConfig(
              AddCardRoute.name,
              path: 'add-card',
              parent: MainRoute.name,
            ),
            _i6.RouteConfig(
              PaymentRoute.name,
              path: 'user',
              parent: MainRoute.name,
            ),
          ],
        ),
        _i6.RouteConfig(
          EditRoute.name,
          path: 'edit',
        ),
      ];
}

/// generated route for
/// [_i1.MainPage]
class MainRoute extends _i6.PageRouteInfo<void> {
  const MainRoute({List<_i6.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'MainRoute';
}

/// generated route for
/// [_i2.EditPage]
class EditRoute extends _i6.PageRouteInfo<EditRouteArgs> {
  EditRoute({
    _i7.Key? key,
    required int index,
  }) : super(
          EditRoute.name,
          path: 'edit',
          args: EditRouteArgs(
            key: key,
            index: index,
          ),
        );

  static const String name = 'EditRoute';
}

class EditRouteArgs {
  const EditRouteArgs({
    this.key,
    required this.index,
  });

  final _i7.Key? key;

  final int index;

  @override
  String toString() {
    return 'EditRouteArgs{key: $key, index: $index}';
  }
}

/// generated route for
/// [_i3.HomePage]
class HomeRoute extends _i6.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: 'home',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i4.AddCardPage]
class AddCardRoute extends _i6.PageRouteInfo<void> {
  const AddCardRoute()
      : super(
          AddCardRoute.name,
          path: 'add-card',
        );

  static const String name = 'AddCardRoute';
}

/// generated route for
/// [_i5.PaymentPage]
class PaymentRoute extends _i6.PageRouteInfo<void> {
  const PaymentRoute()
      : super(
          PaymentRoute.name,
          path: 'user',
        );

  static const String name = 'PaymentRoute';
}
