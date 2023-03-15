import 'package:epay/application/main_cubit.dart';
import 'package:epay/infrastructure/unfocused_tap.dart';
import 'package:epay/presentation/components/custom_add_button.dart';
import 'package:epay/presentation/components/custom_choose_color.dart';
import 'package:epay/presentation/components/custom_choose_type.dart';
import 'package:epay/presentation/pages/add_card/widgets/custom_new_card.dart';
import 'package:epay/presentation/components/custom_textform_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../application/main_state.dart';
import '../../style/style.dart';
import '../../components/custom_choose_image.dart';

class AddCardPage extends StatefulWidget {
  const AddCardPage({Key? key}) : super(key: key);

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  late TextEditingController nameController;
  late TextEditingController dateController;
  late TextEditingController moneyController;
  late MaskedTextController numberController;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    nameController = TextEditingController();
    numberController = MaskedTextController(mask: '0000 0000 0000 0000');
    dateController = TextEditingController();
    moneyController = TextEditingController();
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
    return OnUnFocusTap(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 40),
          child: BlocBuilder<MainCubit, MainState>(
            builder: (context, state) {
              return Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: Text("Add a new Card",
                            style: Style.textStyleRegular(size: 24))),
                    24.verticalSpace,
                    const CustomNewCard(),
                    8.verticalSpace,
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomChooseColor(),
                            8.verticalSpace,
                            CustomChooseImage(),
                            8.verticalSpace,
                            CustomChooseType(),
                            12.verticalSpace,
                            CustomTextFormField(
                              controller: nameController,
                              keyboardType: TextInputType.text,
                              onChanged: (s) {
                                context.read<MainCubit>().getNewCard(name: s);
                              },
                              validator: (s) {
                                if (s?.isEmpty ?? true) {
                                  return "*Enter the owner's name";
                                }
                                return null;
                              },
                              hintText: "Owner name",
                            ),
                            12.verticalSpace,
                            CustomTextFormField(
                                controller: numberController,
                                keyboardType: TextInputType.number,
                                onChanged: (s) {
                                  context.read<MainCubit>().getNewCard(number: s);
                                },
                                validator: (s) {
                                  if (s?.isEmpty ?? true) {
                                    return "*Enter the card number";
                                  }
                                  return null;
                                },
                                hintText: "Card number"),
                            12.verticalSpace,
                            CustomTextFormField(
                              controller: dateController,
                              keyboardType: TextInputType.datetime,
                              onChanged: (s) {},
                              validator: (s) {
                                if (s?.isEmpty ?? true) {
                                  return "*Enter the expiration date";
                                }
                                return null;
                              },
                              hintText: "Expiration Date",
                              readOnly: true,
                              isDate: true,
                            ),
                            12.verticalSpace,
                            CustomTextFormField(
                                controller: moneyController,
                                keyboardType: TextInputType.number,
                                onChanged: (s) {
                                  context
                                      .read<MainCubit>()
                                      .getNewCard(money: int.parse(s));
                                },
                                validator: (s) {
                                  if (s?.isEmpty ?? true) {
                                    return "*Enter the amount of money";
                                  }
                                  return null;
                                },
                                hintText: "Amount of Money"),
                            32.verticalSpace,
                            CustomAddButton(
                              onTap: () {
                                if (formKey.currentState?.validate() ?? false) {
                                  context.read<MainCubit>().addCard();
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Column(
                                            children: [
                                              Container(
                                                height: 50,
                                                width: 50,
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Style.primaryBlue),
                                                child: const Center(
                                                    child: Icon(
                                                  Icons.done,
                                                  color: Style.whiteColor,
                                                )),
                                              ),
                                              8.verticalSpace,
                                              Text(
                                                "A new card added!",
                                                style: Style.textStyleRegular(),
                                              )
                                            ],
                                          ),
                                        );
                                      });
                                  context.read<MainCubit>().cleanNewFields();
                                  nameController.clear();
                                  numberController.clear();
                                  dateController.clear();
                                  moneyController.clear();
                                }
                              },
                              isValid: formKey.currentState?.validate() ?? false,
                              title: 'Add',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
