import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:take_note/core/models/status.dart';
import 'package:take_note/core/services/auth_utils.dart';
import 'package:get_it/get_it.dart';
import 'package:take_note/core/viewmodels/base_model.dart';
import 'package:take_note/locator.dart';

class CloudModel extends BaseModel {
  final AuthUtils _authUtils = locator<AuthUtils>();

  Stream<QuerySnapshot> getDocuments(String userId) {
    setState(Status.BUSY);

    var success =  _authUtils.streamDataCollection(userId);

    setState(Status.IDLE);
    return success;

  }

  Future<void> removeDocument(String id) async {
    setState(Status.BUSY);

    var success = await _authUtils.removeDocument(id);

    setState(Status.IDLE);
    return success;
  }


}