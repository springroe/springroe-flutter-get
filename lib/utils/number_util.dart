class NumberUtil{
  static String priceFormat(int value){
    return (value / 100).toStringAsFixed(2);
  }
}