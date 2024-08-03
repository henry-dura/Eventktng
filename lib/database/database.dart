import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';

class User {
  ObjectId? id;
  String name;
  String regId;
  String entryTime;
  String exitTime;
  String isCheckedIn;
  String isCheckedOut;

  static const Map<String, String> defMap = {
    'name': 'ResponseError',
    'regId': 'ResponseError',
    'entryTime': 'ResponseError',
    'exitTime': 'ResponseError',
    'isCheckedIn': 'ResponseError',
    'isCheckedOut': 'ResponseError',
  };

  User({
    this.id,
    required this.name,
    required this.regId,
    required this.entryTime,
    required this.exitTime,
    required this.isCheckedIn,
    required this.isCheckedOut,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'regId': regId,
      'entryTime': entryTime,
      'exitTime': exitTime,
      'isCheckedIn': isCheckedIn,
      'isCheckedOut': isCheckedOut,
    };
  }

  User.fromMap(Map<String, dynamic>? map)
      :  id = map?['_id'] ?? ObjectId(),
        name = (map ?? defMap)['name'] ?? 'NullFieldError',
        regId = (map ?? defMap)['regId'] ?? 'NullFieldError',
        entryTime = (map ?? defMap)['entryTime'] ?? 'NullFieldError',
        exitTime = (map ?? defMap)['exitTime'] ?? 'NullFieldError',
        isCheckedIn = (map ?? defMap)['isCheckedIn'] ?? 'NullFieldError',
        isCheckedOut = (map ?? defMap)['isCheckedOut'] ?? 'NullFieldError';

  void displayData() => debugPrint(
      'debug: $name $regId $entryTime $exitTime $isCheckedIn $isCheckedOut');
}

class MongoDatabase {
  // static String dbStr = s_db;
  // static late Future<Db> db;
  static late DbCollection userCollection;
  late Db db;


  Future<void> connect() async {
    try {
      db = await Db.create('mongodb+srv://henryikemefuna:vHCgwiDZ0UyPciI0@cluster0.b8ms6d8.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0');
      await db.open();
      log('created and logged in');
      userCollection = db.collection('user');
      log('Collection selected: $userCollection');
    } catch (e) {
      log('Error connecting to the database: $e');
    }
  }

  insert(User user) async =>
      await userCollection.insertOne(user.toMap());

  static Future<User> fetch({required String regId}) async {
    return User.fromMap(
      await userCollection.findOne(
        where.eq("regId", regId).fields(
          [
            'name',
            'regId',
            'entryTime',
            'exitTime',
            'isCheckedIn',
            'isCheckedOut',
          ],
        ),
      ),
    );
  }

  static update({required String regId, required bool isInEntryMode}) {
    String dateTime =
        DateTime.now().hour.toString() + DateTime.now().minute.toString();
    userCollection.updateOne(
      where.eq('regId', regId),
      isInEntryMode
          ? modify
              .set('entryTime', dateTime)
              .set('isCheckedIn', 'true')
              .set('isCheckedOut', 'false')
          : modify
              .set('exitTime', dateTime)
              .set('isCheckedOut', 'true')
              .set('isCheckedIn', 'false'),
    );
  }
}
