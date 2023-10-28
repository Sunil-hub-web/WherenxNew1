
import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'WherenxDeo.dart';
import 'WherenxEntity.dart';

part 'app_database.g.dart';

@Database(version: 1,entities: [WherenxModel])
abstract class AppDatabase extends FloorDatabase{
  WherenxDeo get wherenxdeo;
}

