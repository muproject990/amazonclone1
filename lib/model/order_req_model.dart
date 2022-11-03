class OrderRequestModel {
  final String orderName;
  final String buyerAddress;
 

  OrderRequestModel( {required this.buyerAddress, required this.orderName});

  Map<String, dynamic> getJson() => {
        'orderName': orderName,
        'buyerAddress': buyerAddress,
      };

  factory OrderRequestModel.getModelFromJson(
      {required Map<String, dynamic> json}) {
    return OrderRequestModel(
      buyerAddress: json['buyerAddress'],
      orderName: json['orderName'],
    );
  }
}
