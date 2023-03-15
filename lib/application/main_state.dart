import '../domain/model/card_model.dart';

class MainState {
  // lists
  List<CardModel>? listOfCards;
  List? listOfCardId = [];
  num? totalBalance;

  // adding a new card
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
  int? favIndex;

  MainState(
      {this.listOfCards,
      this.listOfCardId,
      this.totalBalance,
      this.newName,
      this.newExpire,
      this.newNumber,
      this.newMoney,
      this.newColor = "0xff8EDFEB",
      this.newCardType = "visa_card",
      this.newImage =
          "https://upload.wikimedia.org/wikipedia/commons/8/89/HD_transparent_picture.png",
      this.selectedColorIndex = 0,
      this.selectedImageIndex = -1,
      this.selectedCardTypeIndex = 0,
        this.favIndex
      });

  MainState copyWith(
      {List<CardModel>? list,
      List? listOfCardId,
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
      int? nSelectedCardTypeIndex,
        int? fav
      }) {
    return MainState(
        listOfCards: list ?? listOfCards,
        listOfCardId: listOfCardId ?? this.listOfCardId,
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
        selectedCardTypeIndex: nSelectedCardTypeIndex ?? selectedCardTypeIndex,
      favIndex: fav
    );
  }
}
