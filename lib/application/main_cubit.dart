import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/model/card_model.dart';
import 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainState());

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  getCard() async {
    var res = await firestore.collection("card").get();
    List<CardModel> newList = [];
    List newListId = [];
    num balance = 0;
    for (var element in res.docs) {
      newList.add(CardModel.fromJson(element.data()));
      newListId.add(element.id);
      balance += CardModel.fromJson(element.data()).money;
    }
    emit(state.copyWith(list: newList, balance: balance, listOfCardId: newListId));
  }

  getNewCard({String? name, String? number, String? expire,String? cardType, num? money}){
    emit(state.copyWith(nExpire: expire, nNumber: number, nCardType: cardType, nMoney: money, nName:name ));
  }

  // getNewName(String name) {
  //   emit(state.copyWith(nName: name));
  // }
  //
  // getNewNumber(String number) {
  //   emit(state.copyWith(nNumber: number));
  // }
  //
  // getNewExpire(String expire) {
  //   emit(state.copyWith(nExpire: expire));
  // }
  //
  // getNewMoney(num money) {
  //   emit(state.copyWith(nMoney: money));
  // }

  getNewColor(String? color) {
    emit(state.copyWith(nColor: color));
  }

  getNewImage(String image) {
    emit(state.copyWith(nImage: image));
  }

  getNewCardType(String cardType) {
    emit(state.copyWith(nCardType: cardType));
  }

  getSelectedColorIndex(int colorIndex) {
    emit(state.copyWith(nSelectedColorIndex: colorIndex));
  }

  getSelectedImageIndex(int imageIndex) {
    emit(state.copyWith(nSelectedImageIndex: imageIndex));
  }

  getSelectedCardTypeIndex(int typeIndex){
    emit(state.copyWith(nSelectedCardTypeIndex: typeIndex));
  }

  addCard() async {
    await firestore.collection("card").add(CardModel(
            number: state.newNumber ?? "",
            money: state.newMoney ?? 0,
            image: state.newImage ?? "https://upload.wikimedia.org/wikipedia/commons/8/89/HD_transparent_picture.png",
            color: state.newColor ?? "",
            expiration: state.newExpire ?? "",
            ownerName: state.newName ?? "", cardType: state.newCardType ?? "visa_card")
        .toJson());
    getCard();
  }

  deleteCard(int index){
    firestore.collection("card").doc(state.listOfCardId?[index]).delete();
    print(state.totalBalance);
    print(state.listOfCards?[index].money ?? 0);
    state.totalBalance != 0 ?  state.totalBalance = state.totalBalance! - (state.listOfCards?[index].money ?? 0) : state.totalBalance = 0;
    state.listOfCards?.removeAt(index);
    state.listOfCardId?.removeAt(index);
    emit(state.copyWith(list: state.listOfCards, balance: state.totalBalance));
  }
}
