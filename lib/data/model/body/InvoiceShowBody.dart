class InvoiceShowBody {
  List<String>? amount;
  List<String>? litter;
  List<String>? name;
  List<String>? price;
  List<String>? purchasePrice;
  List<String>? vatPrice;
  List<String>? vat;
  List<String>? invoiceNo;
  List<String>? oilInfoId;
  List<String>? adminId;
  List<String>? userId;
  List<String>? createdAt;
  List<String>? updatedAt;

  InvoiceShowBody(
      {this.amount,
        this.litter,
        this.name,
        this.price,
        this.purchasePrice,
        this.vatPrice,
        this.vat,
        this.invoiceNo,
        this.oilInfoId,
        this.adminId,
        this.userId,
        this.createdAt,
        this.updatedAt});

  InvoiceShowBody.fromJson(Map<String, dynamic> json) {
    amount = json['amount'].cast<String>();
    litter = json['litter'].cast<String>();
    name = json['name'].cast<String>();
    price = json['price'].cast<String>();
    purchasePrice = json['purchasePrice'].cast<String>();
    vatPrice = json['vatPrice'].cast<String>();
    vat = json['vat'].cast<String>();
    invoiceNo = json['invoice_No'].cast<String>();
    oilInfoId = json['OilInfo_id'].cast<String>();
    adminId = json['admin_id'].cast<String>();
    userId = json['user_id'].cast<String>();
    createdAt = json['created_at'].cast<String>();
    updatedAt = json['updated_at'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['litter'] = this.litter;
    data['name'] = this.name;
    data['price'] = this.price;
    data['purchasePrice'] = this.purchasePrice;
    data['vatPrice'] = this.vatPrice;
    data['vat'] = this.vat;
    data['invoice_No'] = this.invoiceNo;
    data['OilInfo_id'] = this.oilInfoId;
    data['admin_id'] = this.adminId;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

  @override
  String toString() {
    return 'InvoiceShowBody{amount: $amount, litter: $litter, name: $name, price: $price, purchasePrice: $purchasePrice, vatPrice: $vatPrice, vat: $vat, invoiceNo: $invoiceNo, oilInfoId: $oilInfoId, adminId: $adminId, userId: $userId, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}