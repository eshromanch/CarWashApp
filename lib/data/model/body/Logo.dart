import 'package:floor/floor.dart';
@entity
class Logo {
  @PrimaryKey()
  int? id;
  String? name;
  String? url;

  Logo({this.id, required this.name,required this.url});
}