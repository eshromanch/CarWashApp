import 'package:floor/floor.dart';
import 'package:car_wash_app/data/model/response/login_response.dart';

@dao
abstract class ServiceDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> inserServiceInfo(Service service);

  @Query('SELECT * FROM Service')
  Future<List<Service>> getServiceInfoList();

  @Query('DELETE FROM Service WHERE id = :id')
  Future<int?> deleteServiceInfo(int id);

  @Query('SELECT * FROM Service WHERE id = :id')
  Future<Service?> getServiceInfoById(int id);

  @Query('DELETE FROM Service')
  Future<void> cleanServiceInfoTable();


  @update
  Future<int> updateServiceInfo(Service service);
}