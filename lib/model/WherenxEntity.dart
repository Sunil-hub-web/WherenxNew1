import 'package:floor/floor.dart';

@entity
class WherenxModel {

  @PrimaryKey(autoGenerate: false)
  int id;
  String name;
  String mobileno;
  String choose1;
  String choose2;

  @ignore
  bool isSelect = true;

  WherenxModel(this.id,this.name,this.mobileno,this.choose1,this.choose2);

 }