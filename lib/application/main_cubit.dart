import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/model/card_model.dart';
import 'main_state.dart';

class MainCubit extends Cubit<MainState>{
  MainCubit() : super(MainState());

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  getCard() async {
    var res = await firestore.collection("card").get();
    List<CardModel> newList = [];
    num balance = 0;
    for (var element in res.docs){
      newList.add(CardModel.fromJson(element.data()));
      balance += CardModel.fromJson(element.data()).money;
    }
    emit(state.copyWith(list: newList, balance: balance));
    //print(state.listOfCards!.forEach((element) {print(element.ownerName);}));
  }

  getNewName(String name){
    emit(state.copyWith(nName: name));
  }

  getNewNumber(String number){
    emit(state.copyWith(nNumber: number));
  }

  getNewExpire(String expire){
    emit(state.copyWith(nExpire: expire));
  }
  getNewMoney(num money){
    emit(state.copyWith(nMoney: money));
  }

  getNewColor(String? color){
    emit(state.copyWith(nColor: color));
  }

  getNewImage(String image){
    emit(state.copyWith(nImage: image));
  }

  getNewCardType(String cardType){
    emit(state.copyWith(nCardType: cardType));
  }

  getSelectedColor(int colorIndex){
    emit(state.copyWith(nSelectedColorIndex: colorIndex));
  }
}