import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../application/main_cubit.dart';
import '../../application/main_state.dart';
import '../components/custom_card.dart';
import '../style/style.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final formatNumber = new NumberFormat("#,##0.00", "en_US");
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit()..getCard(),
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Text(
              "Your Card Information",
              style: Style.textStyleRegular(size: 24),
            )),
            SizedBox(height: 34),
            Text(
              "Available balance",
              style: Style.textStyleThin(),
            ),
            SizedBox(height: 8),
            BlocBuilder<MainCubit, MainState>(
              builder: (context, state) {
                return Text(
                  "${state.totalBalance} UZS",
                  style: Style.textStyleBold(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                );
              },
            ),
            SizedBox(height: 8),
            Text(
              "Your Cards",
              style: Style.textStyleRegular(),
            ),
            SizedBox(height: 8),
            Expanded(child: BlocBuilder<MainCubit, MainState>(
              builder: (context, state) {
                return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: state.listOfCards?.length ?? 0,
                    itemBuilder: (context, index) {
                      return CustomCard(
                        expiration: state.listOfCards![index].expiration,
                        money: state.listOfCards![index].money,
                        number: state.listOfCards![index].number,
                        name: state.listOfCards![index].ownerName, color: state.listOfCards![index].color,
                      );
                    });
              },
            ))
          ],
        ),
      )),
    );
  }
}
