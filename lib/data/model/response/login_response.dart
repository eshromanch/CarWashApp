import 'package:floor/floor.dart';



@entity
class UserInfo {
  @PrimaryKey()
  int? id;
  String? password;
  String? email;


  UserInfo(
      {
        this.password,
        this.email,
        });


}


@entity
class Service {
  @PrimaryKey()
  int? id;
  String? business_name;
  String? address_line1;
  String? address_line2;
  String? mobile;
  String? email;
  String? website;
  double? vat;
  String? footer_note;
  String? logo_path;
  String? createdAt;
  String? updatedAt;

  Service({
      this.id,
      this.business_name,
      this.address_line1,
      this.address_line2,
      this.mobile,
      this.email,
      this.website,
      this.vat,
      this.footer_note,
      this.logo_path,
      this.createdAt,
      this.updatedAt});
}