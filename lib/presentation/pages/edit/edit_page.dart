import 'package:epay/infrastructure/unfocused_tap.dart';
import 'package:epay/presentation/components/custom_add_button.dart';
import 'package:epay/presentation/components/custom_choose_color.dart';
import 'package:epay/presentation/components/custom_choose_image.dart';
import 'package:epay/presentation/components/custom_choose_type.dart';
import 'package:epay/presentation/components/custom_textform_field.dart';
import 'package:epay/presentation/pages/edit/widgets/custom_edit_card.dart';
import 'package:epay/presentation/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../application/main_cubit.dart';
import '../../../application/main_state.dart';

// ignore: must_be_immutable
class EditPage extends StatefulWidget {
  int index;

  EditPage({Key? key, required this.index}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late TextEditingController nameController;
  late TextEditingController dateController;
  late TextEditingController moneyController;
  late MaskedTextController numberController;

  @override
  void initState() {
    nameController = TextEditingController();
    numberController = MaskedTextController(mask: '0000 0000 0000 0000');
    dateController = TextEditingController();
    moneyController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      nameController.text = context
              .read<MainCubit>()
              .state
              .listOfCards?[widget.index]
              .ownerName ??
          "";
      numberController.text =
          context.read<MainCubit>().state.listOfCards?[widget.index].number ??
              "";
      dateController.text = context
              .read<MainCubit>()
              .state
              .listOfCards?[widget.index]
              .expiration ??
          "";
      moneyController.text =
          (context.read<MainCubit>().state.listOfCards?[widget.index].money ??
                  0)
              .toString();
      context.read<MainCubit>().initializeNewFields(widget.index);
    });
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    numberController.dispose();
    dateController.dispose();
    moneyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<MainCubit>(),
      child: OnUnFocusTap(
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
                            context.read<MainCubit>().cleanNewFields();
                          },
                          icon: const Icon(Icons.arrow_back, color: Style.primaryBlue,),
                          splashRadius: 20,
                        ),
                        Text("Edit your card",
                            style: Theme.of(context).textTheme.displayMedium),
                        const SizedBox(
                          width: 30,
                        )
                      ],
                    ),
                    16.verticalSpace,
                    CustomEditCard(index: widget.index),
                    8.verticalSpace,
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            CustomChooseColor(isEdit: true),
                            8.verticalSpace,
                            CustomChooseImage(isEdit: true),
                            8.verticalSpace,
                            CustomChooseType(isEdit: true),
                            12.verticalSpace,
                            CustomTextFormField(
                                controller: nameController,
                                keyboardType: TextInputType.text,
                                onChanged: (s) {
                                  context.read<MainCubit>().editCard(name: s);
                                },
                                validator: (s) {
                                  return null;
                                },
                                hintText: "Owner name"),
                            12.verticalSpace,
                            CustomTextFormField(
                                controller: numberController,
                                keyboardType: TextInputType.number,
                                onChanged: (s) {
                                  context.read<MainCubit>().editCard(number: s);
                                },
                                validator: (s) {
                                  return null;
                                },
                                hintText: "Card number"),
                            12.verticalSpace,
                            CustomTextFormField(
                                controller: dateController,
                                keyboardType: TextInputType.text,
                                readOnly: true,
                                onChanged: (s) {
                                  context.read<MainCubit>().editCard(expire: s);
                                },
                                validator: (s) {
                                  return null;
                                },
                                isDate: true,
                                hintText: "Expiration date"),
                            12.verticalSpace,
                            CustomTextFormField(
                                controller: moneyController,
                                keyboardType: TextInputType.number,
                                onChanged: (s) {
                                  context
                                      .read<MainCubit>()
                                      .editCard(money: int.parse(s));
                                },
                                validator: (s) {
                                  return null;
                                },
                                hintText: "Amount of money"),
                            24.verticalSpace,
                            CustomAddButton(
                              onTap: () {
                                context
                                    .read<MainCubit>()
                                    ..finalizeEdit(widget.index)..cleanNewFields();
                                Navigator.pop(context);
                              },
                              title: 'Save',
                              isValid: true,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
