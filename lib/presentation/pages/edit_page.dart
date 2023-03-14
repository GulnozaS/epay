import 'package:epay/presentation/components/custom_add_button.dart';
import 'package:epay/presentation/components/custom_choose_color.dart';
import 'package:epay/presentation/components/custom_choose_image.dart';
import 'package:epay/presentation/components/custom_choose_type.dart';
import 'package:epay/presentation/components/custom_textform_field.dart';
import 'package:epay/presentation/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../application/main_cubit.dart';
import '../../application/main_state.dart';
import '../../infrastructure/masked.dart';

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

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
                        icon: const Icon(Icons.arrow_back),
                        splashRadius: 20,
                      ),
                      Text("Edit your card",
                          style: Style.textStyleRegular(size: 24)),
                      const SizedBox(
                        width: 30,
                      )
                    ],
                  ),
                  Container(
                    height: 171,
                    margin: const EdgeInsets.only(bottom: 14),
                    decoration: BoxDecoration(
                        color: Color(int.parse(
                            state.listOfCards?[widget.index].color ??
                                "0xff8EDFEB")),
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: NetworkImage(state.newImage ??
                                "https://upload.wikimedia.org/wikipedia/commons/8/89/HD_transparent_picture.png"),
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
                                    state.newName ?? "Owner's name",
                                    style: Style.textStyleRegular(
                                        size: 12, textColor: Style.whiteColor),
                                  ),
                                  12.verticalSpace,
                                  Text(
                                    state.listOfCards?[widget.index].number !=
                                            null
                                        ? maskedCard(state.newNumber.toString())
                                        : "Card number",
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
                                    state.newExpire ?? "Expiration date",
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
                                        textColor:
                                            Style.whiteColor.withOpacity(0.7)),
                                  ),
                                  Text(
                                    state.newMoney.toString(),
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
                                            "assets/${state.newCardType ?? "visa_card"}.png"),
                                        fit: BoxFit.cover)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          CustomChooseColor(isEdit: true),
                          CustomChooseImage(isEdit: true),
                          CustomChooseType(isEdit: true),
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
                          CustomAddButton(
                            onTap: () {
                              context
                                  .read<MainCubit>()
                                  .finalizeEdit(widget.index);
                            },
                            title: 'Save',
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
    );
  }
}
