void main() {
  String city;

  var test =city?.toString();
  var jsonMap = {'num':0};
  printUnseenValue(jsonMap['num']);
}

void printUnseenValue(dynamic amount) {
    num invalid = 21.0;
  try {
    invalid = amount is num ? amount :num.parse(amount);;
    print("invalid double: $invalid" );
  } catch (e) {
    print(e.toString());
    print("invalid double: $invalid" );
  }
  
}