import 'package:epay/infrastructure/masked.dart';
import 'package:epay/presentation/app_widget.dart';
import 'package:epay/presentation/pages/edit/edit_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../application/local_store.dart';
import '../../application/main_cubit.dart';
import '../../application/main_state.dart';
import '../components/custom_card.dart';
import '../style/style.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final formatNumber = NumberFormat("#,##0.00", "en_US");
  bool isChangeTheme = true;
  @override
  void initState() {
    getInfo();
    super.initState();
  }
  Future getInfo() async{
    isChangeTheme = await LocalStore.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<MainCubit>(context)..getCard(),
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 40),
        child: BlocBuilder<MainCubit, MainState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Text(
                  "Your Card Information",
                  style: Theme.of(context).textTheme.displayMedium,
                )),
                24.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Available balance",
                      style: Style.textStyleThin(),
                    ),
                    IconButton(onPressed: (){
                      isChangeTheme = !isChangeTheme;
                      AppWidget.of(context)!.change();
                      LocalStore.setTheme(isChangeTheme);
                      setState(() {});
                    }, icon: Icon(Icons.dark_mode, color: isChangeTheme ? Style.blackColor : Style.whiteColor,), splashRadius: 20,)
                  ],
                ),
                Text(
                  "${state.totalBalance} UZS",
                  style: Style.textStyleBold(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                12.verticalSpace,
                Text(
                  "Your Cards",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                Expanded(
                    child: ListView.builder(
                        padding: const EdgeInsets.only(top: 0),
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.listOfCards?.length ?? 0,
                        itemBuilder: (con, index) {
                          return Column(
                            children: [
                              CustomCard(
                                expiration:
                                    state.listOfCards![index].expiration,
                                money: state.listOfCards![index].money,
                                number: state.listOfCards![index].number,
                                name: state.listOfCards![index].ownerName,
                                color: state.listOfCards![index].color,
                                image: state.listOfCards?[index].image ??
                                    "https://upload.wikimedia.org/wikipedia/commons/8/89/HD_transparent_picture.png",
                                cardType: state.listOfCards![index].cardType,
                              ),
                              Row(
                                children: [
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (con) {
                                            return AlertDialog(
                                              title: Column(
                                                children: [
                                                  Text(maskedCard(state
                                                      .listOfCards![index]
                                                      .number)),
                                                  12.verticalSpace,
                                                  const Text(
                                                      "Do you want to delete this card?"),
                                                  12.verticalSpace,
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Container(
                                                            color: Style
                                                                .primaryBlue,
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8),
                                                            child: const Text(
                                                                "Cancel")),
                                                      ),
                                                      8.horizontalSpace,
                                                      GestureDetector(
                                                        onTap: () {
                                                          context
                                                              .read<MainCubit>()
                                                              .deleteCard(
                                                                  index);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Container(
                                                            color: Style
                                                                .greyColor
                                                                .withOpacity(
                                                                    0.5),
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8),
                                                            child: const Text(
                                                                "Delete")),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            );
                                          });
                                    },
                                    icon: const Icon(Icons.delete,
                                        color: Style.primaryBlue),
                                    splashRadius: 20,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  BlocProvider.value(
                                                    value: BlocProvider.of<
                                                        MainCubit>(context),
                                                    child: EditPage(
                                                      index: index,
                                                    ),
                                                  )));
                                    },
                                    icon: const Icon(Icons.edit,
                                        color: Style.primaryBlue),
                                    splashRadius: 20,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      context
                                          .read<MainCubit>()
                                          ..makeFavorite(index)..findFavorite();
                                    },
                                    icon: Icon(
                                        state.listOfCards?[index].star ?? false
                                            ? Icons.star
                                            : Icons.star_border,
                                        color: Style.primaryBlue),
                                    splashRadius: 20,
                                  ),
                                  12.horizontalSpace
                                ],
                              )
                            ],
                          );
                        }))
              ],
            );
          },
        ),
      )),
    );
  }
}
