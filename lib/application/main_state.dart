import '../domain/model/card_model.dart';

class MainState {
  List<CardModel>? listOfCards;
  num? totalBalance;
  String? newName;
  String? newNumber;
  String? newExpire;
  num? newMoney;
  String? newColor;
  String? newImage;
  String? newCardType;
  int? selectedColorIndex;
  int? selectedImageIndex;

  MainState(
      {this.listOfCards,
      this.totalBalance,
      this.newName,
      this.newExpire,
      this.newNumber,
      this.newMoney,
      this.newColor,
      this.newCardType,
      this.newImage,
      this.selectedColorIndex = 0,
        this.selectedImageIndex = -1
      });

  MainState copyWith(
      {List<CardModel>? list,
      num? balance,
      String? nName,
      String? nNumber,
      String? nExpire,
      num? nMoney,
      String? nColor,
      String? nCardType,
      String? nImage,
      int? nSelectedColorIndex,
      int? nSelectedImageIndex}) {
    return MainState(
        listOfCards: list ?? listOfCards,
        totalBalance: balance ?? totalBalance,
        newName: nName ?? newName,
        newExpire: nExpire ?? newExpire,
        newNumber: nNumber ?? newNumber,
        newMoney: nMoney ?? newMoney,
        newCardType: nCardType ?? newCardType,
        newImage: nImage ?? newImage,
        newColor: nColor ?? newColor,
      selectedColorIndex: nSelectedColorIndex ?? selectedColorIndex,
      selectedImageIndex: nSelectedImageIndex ?? selectedImageIndex
    );
  }
}
