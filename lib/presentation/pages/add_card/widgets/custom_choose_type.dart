import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../application/main_cubit.dart';
import '../../../../application/main_state.dart';
import '../../../style/style.dart';

class CustomChooseType extends StatefulWidget {
  const CustomChooseType({Key? key}) : super(key: key);

  @override
  State<CustomChooseType> createState() => _CustomChooseTypeState();
}

class _CustomChooseTypeState extends State<CustomChooseType> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<MainCubit>(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Choose Card Type",
            style: Style.textStyleThin(),
          ),
          8.verticalSpace,
          BlocBuilder<MainCubit, MainState>(
            builder: (context, state) {
              return SizedBox(
                height: 50,
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          context.read<MainCubit>()
                            ..getSelectedCardTypeIndex(index)
                            ..getNewCardType(index == 0
                                ? "visa_card"
                                : index == 1
                                    ? "master_card"
                                    : "unionpay_card");
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          margin: const EdgeInsets.only(right: 12),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: state.selectedCardTypeIndex == index
                                      ? Style.blackColor
                                      : Style.greyColor.withOpacity(0.5))),
                          child: Image.asset(
                              index == 0
                                  ? "assets/visa_card.png"
                                  : index == 1
                                      ? "assets/master_card.png"
                                      : "assets/unionpay_card.png",
                              fit: BoxFit.cover),
                        ),
                      );
                    }),
              );
            },
          ),
        ],
      ),
    );
  }
}
