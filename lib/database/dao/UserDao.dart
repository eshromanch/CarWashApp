import 'package:floor/floor.dart';
import 'package:car_wash_app/data/model/response/login_response.dart';

@dao
abstract class UserDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> inserUser(UserInfo user);

  @Query('SELECT * FROM UserInfo')
  Future<List<UserInfo>> getUsers();

 /* @Query('SELECT * FROM UserInfo WHERE email LIKE email%')
  Future<UserInfo?> getUsers1(String email);*/

  @Query('DELETE FROM UserInfo WHERE id = :id')
  Future<UserInfo?> deleteUser(int id);

  @Query('SELECT * FROM UserInfo WHERE email = :email')
  Future<UserInfo?> login(String email);

  @Query('DELETE FROM UserInfo')
  Future<void> cleanUserTable();
}
