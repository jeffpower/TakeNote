import 'package:flutter/foundation.dart';
import 'package:take_note/core/models/status.dart';

class BaseModel extends ChangeNotifier {
  Status _status = Status.IDLE;

  Status  get status => _status;

  void setState(Status status) {
    _status = status;
    notifyListeners();
  }
}