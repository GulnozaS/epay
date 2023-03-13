import 'package:epay/presentation/components/custom_card.dart';
import 'package:epay/presentation/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../application/main_cubit.dart';
import '../../application/main_state.dart';
import '../../infrastructure/masked.dart';

// ignore: must_be_immutable
class EditPage extends StatelessWidget {
  int index;
  EditPage({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<MainCubit>(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 40),
          child: BlocBuilder<MainCubit, MainState>(
            builder: (context, state) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back),
                        splashRadius: 20,
                      ),
                      Text("Add a new Card",
                          style: Style.textStyleRegular(size: 24)),
                      SizedBox(
                        width: 30,
                      )
                    ],
                  ),
                  Container(
                    height: 171,
                    margin: const EdgeInsets.only(bottom: 14),
                    decoration: BoxDecoration(
                        color: Color(int.parse(state.listOfCards?[index].color ?? "0xff8EDFEB")),
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: NetworkImage(state.listOfCards?[index].image ?? "https://upload.wikimedia.org/wikipedia/commons/8/89/HD_transparent_picture.png"),
                            fit: BoxFit.cover)),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.listOfCards?[index].ownerName ?? "Owner's name",
                                    style: Style.textStyleRegular(
                                        size: 12, textColor: Style.whiteColor),
                                  ),
                                  12.verticalSpace,
                                  Text(
                                      state.listOfCards?[index].number != null ? maskedCard(state.listOfCards![index].number) : "Card number",
                                    style: Style.textStyleBold(
                                        size: 24, textColor: Style.whiteColor),
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "A Credit Card",
                                    style: Style.textStyleRegular(
                                        size: 12, textColor: Style.whiteColor),
                                  ),
                                  12.verticalSpace,
                                  Text(
                                    state.listOfCards?[index].expiration ?? "Expiration date",
                                    style: Style.textStyleBold(
                                        size: 16, textColor: Style.whiteColor),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Your Balance",
                                    style: Style.textStyleRegular(
                                        size: 12,
                                        textColor: Style.whiteColor.withOpacity(0.7)),
                                  ),
                                  Text(
                                    state.listOfCards?[index].money != null ? state.listOfCards![index].money.toString() : "0",
                                    style: Style.textStyleBold(
                                        size: 22, textColor: Style.whiteColor),
                                  )
                                ],
                              ),
                              Container(
                                height: 50,
                                width: 80,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/${state.listOfCards?[index].cardType ?? "visa_card"}.png"),
                                        fit: BoxFit.cover)),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
