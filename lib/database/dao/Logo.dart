import 'package:car_wash_app/data/model/body/Logo.dart';
import 'package:floor/floor.dart';
import 'package:car_wash_app/data/model/response/login_response.dart';

@dao
abstract class LogoDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> inserLogoInfo(Logo logo);

  @Query('SELECT * FROM Logo')
  Future<List<Logo>> getLogoList();


  @Query('DELETE FROM Logo WHERE id = :id')
  Future<int?> deleteLogo(int id);

  @Query('SELECT * FROM Logo WHERE name = :name')
  Future<List<Logo>> getLogoBYSearch(String name);

  @Query('DELETE FROM Logo')
  Future<void> cleanServiceInfoTable();


  @update
  Future<int> updateServiceInfo(Logo logo);
}