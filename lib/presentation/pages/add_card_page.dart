import 'package:epay/application/main_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../application/main_state.dart';
import '../../infrastructure/masked.dart';
import '../style/style.dart';

class AddCardPage extends StatefulWidget {
  const AddCardPage({Key? key}) : super(key: key);

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  DateTime? pickedDate;
  late TextEditingController nameController;
  late TextEditingController dateController;
  late TextEditingController moneyControler;
  late MaskedTextController numberController;
  List<Color> listOfColor = [
    Color(0xff8EDFEB),
    Color(0xff878787),
    Color(0xff5366BE),
    Color(0xffF59D31),
    Color(0xFFEF9A9A),
    Color(0xFFB71C1C),
    Color(0xFFEF5350),
  ];
  List listOfImage = [
    'https://cdn.pixabay.com/photo/2015/10/30/20/13/sunrise-1014712__340.jpg',
    'https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg',
    'https://cdn.pixabay.com/photo/2018/08/14/13/23/ocean-3605547__340.jpg',
    'https://static.vecteezy.com/system/resources/thumbnails/007/718/412/small/colorful-gradient-reflection-on-wave-background-free-vector.jpg',
    'https://virtuoart.com/public/uploads/preview/0b528dd5a822d5e16d143138534514aa-62021588164438plqnqqtuwg.jpg',
    'https://img4.goodfon.com/wallpaper/nbig/e/4b/volny-abstraktsiia-abstract-waves-colorful-waves.jpg',
    'https://www.stockvault.net/data/2021/01/29/282725/preview16.jpg',
    'https://media.istockphoto.com/id/1208305480/photo/beautiful-abstract-wave-technology-digital-network-background-with-blue-light-digital-effect.jpg?s=170667a&w=0&k=20&c=TjeuVJKpov4pJjSl0KP6plrILS9SW93pZng4IZ_5dZE=',
    ''
  ];

  @override
  void initState() {
    nameController = TextEditingController();
    numberController = MaskedTextController(mask: '0000 0000 0000 0000');
    dateController = TextEditingController();
    moneyControler = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    numberController.dispose();
    dateController.dispose();
    moneyControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<MainCubit>(context),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 40),
          child: BlocBuilder<MainCubit, MainState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Text("Add a new Card",
                          style: Style.textStyleRegular(size: 24))),
                  34.verticalSpace,
                  Container(
                    height: 171,
                    margin: EdgeInsets.only(bottom: 14),
                    decoration: BoxDecoration(
                        color: Style.lightBlueColor,
                        borderRadius: BorderRadius.circular(20)),
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
                                        size: 12,
                                        textColor: Style.whiteColor),
                                  ),
                                  12.verticalSpace,
                                  Text(
                                    state.newNumber != null ? cardMask(
                                        state.newNumber!) : "Card Number",
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
                                    state.newExpire ?? "Expire Date",
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
                                    state.newMoney != null ? state.newMoney
                                        .toString() : "0",
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
                                            "assets/visa_card.png"),
                                        fit: BoxFit.cover)),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  8.verticalSpace,
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Choose Color",
                            style: Style.textStyleThin(),
                          ),
                          8.verticalSpace,
                          SizedBox(
                            height: 50,
                            child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: listOfColor.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: (){
                                      context.read<MainCubit>()..getSelectedColor(index);
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      margin: EdgeInsets.only(right: 12),
                                      decoration: BoxDecoration(
                                          color: listOfColor[index],
                                          border: Border.all(color: state.selectedColorIndex == index ? Style.blackColor : Style.transparentColor),
                                          shape: BoxShape.circle),
                                    ),
                                  );
                                }),
                          ),
                          8.verticalSpace,
                          Text(
                            "Choose Image",
                            style: Style.textStyleThin(),
                          ),
                          8.verticalSpace,
                          SizedBox(
                            height: 50,
                            child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: listOfImage.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    height: 50,
                                    width: 50,
                                    margin: EdgeInsets.only(right: 12),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                listOfImage[index]),
                                            fit: BoxFit.cover),
                                        shape: BoxShape.circle),
                                  );
                                }),
                          ),
                          8.verticalSpace,
                          Text(
                            "Choose Card Type",
                            style: Style.textStyleThin(),
                          ),
                          8.verticalSpace,
                          SizedBox(
                            height: 50,
                            child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: 3,
                                itemBuilder: (context, index) {
                                  return Container(
                                    height: 50,
                                    width: 50,
                                    margin: EdgeInsets.only(right: 12),
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color:
                                            Style.greyColor.withOpacity(0.5))),
                                    child: Image.asset(
                                        index == 0
                                            ? "assets/visa_card.png"
                                            : index == 1
                                            ? "assets/master_card.png"
                                            : "assets/unionpay_card.png",
                                        fit: BoxFit.cover),
                                  );
                                }),
                          ),
                          24.verticalSpace,
                          TextFormField(
                            controller: nameController,
                            keyboardType: TextInputType.text,
                            onChanged: (s) {
                              context.read<MainCubit>().getNewName(s);
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 8),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                hintText: "Owner name",
                                hintStyle: Style.textStyleThin(
                                    size: 14, textColor: Style.greyColor)),
                          ),
                          12.verticalSpace,
                          TextFormField(
                            controller: numberController,
                            keyboardType: TextInputType.number,
                            onChanged: (s) {
                              context.read<MainCubit>().getNewNumber(s);
                            },
                            decoration: InputDecoration(
                              contentPadding:
                              EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              hintText: "Card number",
                              hintStyle: Style.textStyleThin(
                                  size: 14, textColor: Style.greyColor),
                            ),
                          ),
                          12.verticalSpace,
                          TextFormField(
                              controller: dateController,
                              readOnly: true,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 8),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  hintText: "Expiration Date",
                                  hintStyle: Style.textStyleThin(
                                      size: 14, textColor: Style.greyColor),
                                  suffixIcon: InkWell(
                                    child: Icon(Icons.calendar_month),
                                    onTap: () async {
                                      pickedDate = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          //DateTime.now() - not to allow to choose before today.
                                          lastDate: DateTime(2050));

                                      if (pickedDate != null) {
                                        dateController.text =
                                            DateFormat('MM/yyyy')
                                                .format(pickedDate!);
                                        context.read<MainCubit>().getNewExpire(
                                            dateController.text);
                                      } else {}
                                    },
                                  ))),
                          12.verticalSpace,
                          TextFormField(
                            controller: moneyControler,
                            keyboardType: TextInputType.number,
                            onChanged: (s) {
                              context.read<MainCubit>().getNewMoney(
                                  int.parse(s));
                            },
                            decoration: InputDecoration(
                              contentPadding:
                              EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              hintText: "Amount of Money",
                              hintStyle: Style.textStyleThin(
                                  size: 14, textColor: Style.greyColor),
                            ),
                          ),
                          32.verticalSpace,
                          Container(
                            padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                                color: Style.primaryBlue.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                                child: Text(
                                  "Add Card",
                                  style: Style.textStyleRegular(
                                      textColor: Style.whiteColor),
                                )),
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
