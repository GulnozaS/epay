import 'package:auto_route/auto_route.dart';

import 'pages/add_card_page.dart';
import 'pages/home_page.dart';
import 'pages/main_page.dart';
import 'pages/payment_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    MaterialRoute(
      path: '/',
      page: MainPage,
      children: [
        MaterialRoute(path: 'home', page: HomePage, initial: true),
        MaterialRoute(
          path: 'add-card',
          page: AddCardPage,
        ),
        MaterialRoute(
          path: 'user',
          page: PaymentPage,
        ),
      ],
    ),
    // MaterialRoute(
    //   path: 'see-all',
    //   page: SeeAllPage,
    // ),
  ],
)
class $AppRouter {}