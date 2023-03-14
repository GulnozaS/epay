import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../application/main_cubit.dart';
import '../../application/main_state.dart';
import '../style/style.dart';

// ignore: must_be_immutable
class CustomChooseColor extends StatefulWidget {
  bool? isEdit;
   CustomChooseColor({Key? key, this.isEdit = false}) : super(key: key);

  @override
  State<CustomChooseColor> createState() => _CustomChooseColorState();
}

class _CustomChooseColorState extends State<CustomChooseColor> {
  List<int> listOfColor = [
    0xff8EDFEB,
    0xff878787,
    0xff5366BE,
    0xffF59D31,
    0xFFEF9A9A,
    0xFFB71C1C,
    0xFFEF5350,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<MainCubit>(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Choose Color", style: Style.textStyleThin()),
          8.verticalSpace,
          BlocBuilder<MainCubit, MainState>(
            builder: (context, state) {
              return SizedBox(
                height: 50,
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: listOfColor.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          widget.isEdit ?? false ? context.read<MainCubit>().editCard(colorIndex: index, color: listOfColor[index].toString()) : context.read<MainCubit>()
                            .getNewCard(colorIndex: index, color: listOfColor[index].toString());
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          margin: const EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                              color: Color(listOfColor[index]),
                              border: Border.all(
                                  color: state.selectedColorIndex == index
                                      ? Style.blackColor
                                      : Style.transparentColor),
                              shape: BoxShape.circle),
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
