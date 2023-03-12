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
  int? selectedCardTypeIndex;

  MainState(
      {this.listOfCards,
      this.totalBalance,
      this.newName,
      this.newExpire,
      this.newNumber,
      this.newMoney,
      this.newColor = "0xff8EDFEB",
      this.newCardType = "visa_card",
      this.newImage = "https://upload.wikimedia.org/wikipedia/commons/8/89/HD_transparent_picture.png",
      this.selectedColorIndex = 0,
        this.selectedImageIndex = -1,
        this.selectedCardTypeIndex = 0
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
      int? nSelectedImageIndex,
      int? nSelectedCardTypeIndex}) {
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
      selectedImageIndex: nSelectedImageIndex ?? selectedImageIndex,
      selectedCardTypeIndex: nSelectedCardTypeIndex ?? selectedCardTypeIndex
    );
  }
}
