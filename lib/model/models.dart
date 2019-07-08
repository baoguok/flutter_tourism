import 'package:scoped_model/scoped_model.dart';


class Models extends Model {

  Object userInfo = {};

  get _userInfo => userInfo;

  void getUserInfo(val){
    userInfo = val;
    notifyListeners();
  }

//  static Models of(context) =>
//      ScopedModel.of<Models>(context);

}