import 'package:tuple/tuple.dart';

class HouseInfo {

  var houseAddr;
  var bankName;
  var bankAccount;
  var fundFirstDate;
  // amount may be a very long number
  // should use different unit 元/万元
  num fundAmount; var fundAmountTruple;
  num fundInteres;  var fundInteresTruple;
  num fundFreezedAmount;
  num fundFreezedInterest;

  var houseDealDate;
  num houseArea;
   // amount may be a very long number
  // should use different unit 元/万元
  num housePrice; var housePriceTuple;

  var ownerName;
  // this should use with no of id
  // like 护照号码: xxxx 或是 身份证号：xxxx
  var ownerIdType = '证件';
  var ownerId;
  // these two should not show, if null
  var ownerPhoneNo;
  var ownerEmail;

// it should have some injection function...
// well, it could be several map 
  gotSomeValues(Map jsonMap) {
    injectFundInfo(jsonMap);
  }

  injectFundInfo(Map jsonMap) {
    Map addr = jsonMap["addr"]; 
    if (addr != null) buildAddr(addr);

    bankName = jsonMap["bankName"]?.toString();
    bankAccount = jsonMap["bankAccount"]?.toString();
    fundFirstDate = jsonMap["fundFirstDate"]?.toString();
    bankName = jsonMap["bankName"]?.toString();

    var date = jsonMap['fundFistDate'];
    if (date != null) fundFirstDate = formatDate(date);
  }

  buildFundAmount(dynamic amount) {
    try {
      fundAmount = amount is num ? amount :num.parse(amount);

    } catch (e) {

    }
  }

  buildMoneyStr(num money) {
    var strMoney = money.toStringAsFixed(1);
    if (strMoney.length >= 8) {

    }
  }

  String formatDate(String date) {
    //todo some formatting
    
    return date;
  }

  void buildAddr(Map jsonMap) {
    var city = jsonMap['city']?.toString();
    var community = jsonMap['community'];
    var building = jsonMap['building'];
    var unit = jsonMap['unit'];
    var roomNo =jsonMap['roomNo'];

    String addr = city;
    addr += community == null ? "" : "·$community";
    addr += building == null ? "" : "·${building}号楼";
    addr += unit == null ? "" : "${unit}单元";
    addr += roomNo == null ? "" : "·${roomNo}室";

    houseAddr = addr;
  }

}




