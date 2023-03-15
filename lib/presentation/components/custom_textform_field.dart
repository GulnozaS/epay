import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../application/main_cubit.dart';
import '../style/style.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final ValueChanged<String> onChanged;
  final FormFieldValidator validator;
  final String hintText;
  bool? readOnly;
  bool? isDate;
  Widget? suffixIcon;

  CustomTextFormField(
      {Key? key,
      required this.controller,
      required this.keyboardType,
      required this.onChanged,
      required this.validator,
      required this.hintText,
      this.readOnly = false,
      this.isDate = false})
      : super(key: key);

  DateTime? pickedDate;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<MainCubit>(context),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        onChanged: onChanged,
        validator: validator,
        decoration: InputDecoration(
            hintText: hintText,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            border: Theme.of(context).inputDecorationTheme.border,
            hintStyle:
            Theme.of(context).inputDecorationTheme.hintStyle,
            suffixIcon: isDate ?? false
                ? InkWell(
                    child: const Icon(Icons.calendar_month),
                    onTap: () async {
                      pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2050));

                      if (pickedDate != null) {
                        controller.text =
                            DateFormat('MM/yyyy').format(pickedDate!);
                        // ignore: use_build_context_synchronously
                        context
                            .read<MainCubit>()
                            .getNewCard(expire: controller.text);
                      } else {}
                    },
                  )
                : const SizedBox.shrink()),
      ),
    );
  }
}
