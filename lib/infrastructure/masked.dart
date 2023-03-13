String maskedCard(String cardNumber){
  StringBuffer result = StringBuffer();
  for(int i =0; i<cardNumber.length;i++){
    if(i<4 || i>13){
      result.write(cardNumber[i]);
    }else if(i>3 && i<14 && cardNumber[i]!=" "){
      result.write("*");
    }else{
      result.write(" ");
    }
  }
  return result.toString();
}