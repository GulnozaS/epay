import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/main_cubit.dart';
import '../style/style.dart';

// ignore: must_be_immutable
class CustomAddButton extends StatelessWidget {
  GestureTapCallback onTap;
  bool? isValid;
  String title;

  CustomAddButton(
      {Key? key, required this.onTap, this.isValid, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<MainCubit>(context),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
              color: (isValid ?? false)
                  ? Style.primaryBlue
                  : Style.primaryBlue.withOpacity(0.5),
              borderRadius: BorderRadius.circular(20)),
          child: Center(
              child: Text(
            title,
            style: Style.textStyleRegular(textColor: Style.whiteColor),
          )),
        ),
      ),
    );
  }
}
