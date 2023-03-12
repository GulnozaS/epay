import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final formatNumber = NumberFormat("#,##0.00", "en_US");

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<MainCubit>(context)..getCard(),
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 40),
        child: BlocBuilder<MainCubit, MainState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Text(
                  "Your Card Information",
                  style: Style.textStyleRegular(size: 24),
                )),
                const SizedBox(height: 34),
                Text(
                  "Available balance",
                  style: Style.textStyleThin(),
                ),
                const SizedBox(height: 8),
                Text(
                  "${state.totalBalance} UZS",
                  style: Style.textStyleBold(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(height: 8),
                Text(
                  "Your Cards",
                  style: Style.textStyleRegular(),
                ),
                const SizedBox(height: 8),
                Expanded(
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.listOfCards?.length ?? 0,
                        itemBuilder: (context, index) {
                          return CustomCard(
                            expiration: state.listOfCards![index].expiration,
                            money: state.listOfCards![index].money,
                            number: state.listOfCards![index].number,
                            name: state.listOfCards![index].ownerName,
                            color: state.listOfCards![index].color,
                            image: state.listOfCards?[index].image ??
                                "https://upload.wikimedia.org/wikipedia/commons/8/89/HD_transparent_picture.png",
                            cardType: state.listOfCards![index].cardType,
                          );
                        }))
              ],
            );
          },
        ),
      )),
    );
  }
}
