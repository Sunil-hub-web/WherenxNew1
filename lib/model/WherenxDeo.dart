
import 'package:floor/floor.dart';

import 'WherenxEntity.dart';



@dao
abstract class WherenxDeo{

  @Query("SELECT * from WherenxModel")
  Future<List<WherenxModel>> findAllTodo();
  
  @Query("SELECT * from WherenxModel order by id desc limit 1")
  Future<WherenxModel?> getMaxId();

  @Query("SELECT * from WherenxModel order by id desc")
  Stream<List<WherenxModel>> streamedData();

  @insert
  Future<void> insertTodo(WherenxModel todo);

  @update
  Future<void> updateTodo(WherenxModel todo);
  
  @Query("delete from WherenxModel where id = :id")
  Future<void> deleteTodo(int id);

  @Query('SELECT * FROM WherenxModel WHERE mobileno = :mobileno')
  Future<List<WherenxModel>> findUserById(String mobileno);

  @delete
  Future<int> deleteAll(List<WherenxModel> list);

}