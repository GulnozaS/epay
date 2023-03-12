class CardModel {
  String ownerName;
  String color;
  String image;
  num money;
  String number;
  String expiration;
  String cardType;

  CardModel(
      {required this.number, required this.money, required this.image, required this.color, required this.expiration, required this.ownerName, required this.cardType});

  factory CardModel.fromJson(Map data){
    return CardModel(number: data['number'],
        money: data['money'],
        image: data['image'],
        color: data['color'],
        expiration: data['expiration'],
        ownerName: data['owner'], cardType: data['cardType']);
  }

  toJson() {
    return {
      "owner": ownerName,
      "image": image,
      "money": money,
      "color": color,
      "number": number,
      "expiration": expiration,
      "cardType" : cardType
    };
  }

}