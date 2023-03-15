import 'dart:convert';

import 'package:epay/presentation/components/custom_add_button.dart';
import 'package:epay/presentation/components/custom_card.dart';
import 'package:epay/presentation/components/custom_textform_field.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

import '../../application/main_cubit.dart';
import '../../application/main_state.dart';
import '../../infrastructure/unfocused_tap.dart';
import '../style/style.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late MaskedTextController cardController;
  late TextEditingController moneyController;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? fcmToken = "";

  @override
  void initState() {
    getToken();
    cardController = MaskedTextController(mask: '0000 0000 0000 0000');
    moneyController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MainCubit>().findFavorite();
      print(context.read<MainCubit>().state.favIndex);
    });
    super.initState();
  }

  @override
  void dispose() {
    cardController.dispose();
    moneyController.dispose();
    super.dispose();
  }

  Future<void> getToken() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      sound: true,
    );
    fcmToken = await FirebaseMessaging.instance.getToken();
    print(fcmToken);
    FirebaseMessaging.onMessage.listen((event) {
      print(event.data);

      MotionToast.success(
        position: MotionToastPosition.top,
        title: Text(event.data["body"] ?? "body"),
        description: Text(event.data["title"] ?? "title"),
      ).show(context);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print("onMessageOpenedApp : $event");
    });
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
                return Form(
                  key: formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                            child: Text("Make a payment",
                                style: Style.textStyleRegular(size: 24))),
                        24.verticalSpace,
                        CustomTextFormField(
                            controller: cardController,
                            keyboardType: TextInputType.number,
                            onChanged: (s) {},
                            validator: (s) {
                              if (s?.isEmpty ?? true) {
                                return "*Enter the card number";
                              }
                              return null;
                            },
                            hintText: "Card number"),
                        12.verticalSpace,
                        CustomTextFormField(
                            controller: moneyController,
                            keyboardType: TextInputType.number,
                            onChanged: (s) {},
                            validator: (s) {
                              if (s?.isEmpty ?? true) {
                                return "*Enter the amount of money";
                              }
                              return null;
                            },
                            hintText: "Amount of money"),
                        12.verticalSpace,
                        (state.listOfCards?.isNotEmpty ?? false) ||
                                state.favIndex != null
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("You are paying from"),
                                  8.verticalSpace,
                                  CustomCard(
                                    expiration: state
                                        .listOfCards![state.favIndex ?? 0]
                                        .expiration,
                                    money: state
                                        .listOfCards![state.favIndex ?? 0]
                                        .money,
                                    number: state
                                        .listOfCards![state.favIndex ?? 0]
                                        .number,
                                    name: state
                                        .listOfCards![state.favIndex ?? 0]
                                        .ownerName,
                                    color: state
                                        .listOfCards![state.favIndex ?? 0]
                                        .color,
                                    image: state
                                            .listOfCards?[state.favIndex ?? 0]
                                            .image ??
                                        "https://upload.wikimedia.org/wikipedia/commons/8/89/HD_transparent_picture.png",
                                    cardType: state
                                        .listOfCards![state.favIndex ?? 0]
                                        .cardType,
                                  ),
                                ],
                              )
                            : const Text("You don't have fav"),
                        24.verticalSpace,
                        CustomAddButton(
                          onTap: () {
                            if (formKey.currentState?.validate() ?? false) {
                              http.post(
                                Uri.parse(
                                    "https://fcm.googleapis.com/fcm/send"),
                                headers: {
                                  "Content-Type": "application/json",
                                  'Authorization':
                                      'key=AAAA_SksxgQ:APA91bGcAHUd-Gss3xP1MVoS4NijuB--DE0w2HWwtfCie1dRmw5lHI3ULxW8DPpXuUmgD7kgkrUGfANCEX9MB8gL_LJIkY4XmC6Vnih773rhrMaQgA5hr-h8B-tUetrYIrJuFUwoSY3u'
                                },
                                body: jsonEncode(
                                  {
                                    "to": fcmToken,
                                    "data": {
                                      "body": "You have successfully paid!",
                                      "title": "Thank you for working with us"
                                    }
                                  },
                                ),
                              );
                              cardController.clear();
                              moneyController.clear();
                            }
                          },
                          title: "Pay",
                          isValid: formKey.currentState?.validate() ?? false,
                        )
                      ]),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
