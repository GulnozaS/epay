import 'package:epay/presentation/style/style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../infrastructure/masked.dart';

class CustomCard extends StatelessWidget {
  String name;
  String number;
  int money;
  String expiration;
  int color;

  CustomCard({Key? key, required this.expiration, required this.money, required this.number, required this.name, required this.color}) : super(key: key);
  final formatNumber = new NumberFormat("#,##0.00", "en_US");
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 171,
      margin: EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
          color: Color(color),
          borderRadius: BorderRadius.circular(20)
      ),
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
                    Text(name, style: Style.textStyleRegular(size: 12, textColor: Style.whiteColor),),
                    SizedBox(height: 12),
                    Text(cardMask(number), style: Style.textStyleBold(size: 24, textColor: Style.whiteColor),)
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("A Credit Card", style: Style.textStyleRegular(size: 12, textColor: Style.whiteColor),),
                    SizedBox(height: 12),
                    Text(expiration, style: Style.textStyleBold(size: 16, textColor: Style.whiteColor),),
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
                    Text("Your Balance", style: Style.textStyleRegular(size: 12, textColor: Style.whiteColor.withOpacity(0.7)),),
                    Container(width: 200,child: Text("${formatNumber.format(money)} UZS", style: Style.textStyleBold(size: 22, textColor: Style.whiteColor),overflow: TextOverflow.ellipsis, maxLines: 1,))
                  ],
                ),
                Container(
                  height: 50,
                  width: 80,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage("assets/visa_card.png"), fit: BoxFit.cover)
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
