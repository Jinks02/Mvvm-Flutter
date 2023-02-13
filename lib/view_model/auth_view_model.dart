import 'package:flutter/cupertino.dart';
import 'package:mvvm_flutter/model/user_model.dart';
import 'package:mvvm_flutter/repository/auth_repository.dart';
import 'package:mvvm_flutter/utils/routes/routes_name.dart';
import 'package:mvvm_flutter/utils/utils.dart';
import 'package:mvvm_flutter/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class AuthViewModel with ChangeNotifier {
  bool _loginLoading = false;

  bool get getLoginLoading => _loginLoading;

  void setLoginLoading(bool value) {
    _loginLoading = value;
    notifyListeners();
  }

  bool _signUpLoading = false;
  bool get getSignUpLoading => _signUpLoading;
  void setSignUpLoading(bool value) {
    _signUpLoading = value;
    notifyListeners();
  }

  Utils _utils = Utils();

  final _authRepository = AuthRepository();

  Future<void> handleLoginApiFromAuthRepo(
      context, dynamic dataToBeProvided) async {
    // handle whatever comes from api

    setLoginLoading(true);

    _authRepository.loginReqresApi(dataToBeProvided).then((value) {
      setLoginLoading(false);

      final _userViewModel = Provider.of<UserViewModel>(context, listen: false);
      _userViewModel.saveUserDetails(
        UserModel(
          token: value['token'],
        ),
      );

      _utils.showToastMessage("success");
      debugPrint('api hit');
      Navigator.of(context).pushNamed(RoutesName.home);
    }).onError((error, stackTrace) {
      setLoginLoading(false);
      _utils.showErrorFlushBarMessage('error', context);

      debugPrint('error in auth view model');
      // debugPrint(error.toString());
    });
  }

  Future<void> handleRegisterApiFromAuthRepo(
      context, dynamic dataToBeProvided) async {
    // handle whatever comes from api

    setSignUpLoading(true);

    _authRepository.registerReqresApi(dataToBeProvided).then((value) {
      setSignUpLoading(false);
      _utils.showToastMessage("signUp success");
      debugPrint('api hit');
      Navigator.of(context).pushNamed(RoutesName.home);
    }).onError((error, stackTrace) {
      setSignUpLoading(false);
      _utils.showErrorFlushBarMessage('error', context);

      debugPrint('error in auth view model');
      // debugPrint(error.toString());
    });
  }
}
