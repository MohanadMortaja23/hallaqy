// import 'package:shop_app/models/login_model.dart';

import '../../../models/employees_model.dart';
import '../../../models/error_message.dart';
import '../../../models/login_model.dart';
import '../../../models/message_model.dart';
import '../../../models/profile_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  LoginModel loginModel;

  LoginSuccessState(this.loginModel);
}

class LoginErrorState extends LoginStates {
  final String error;
  LoginErrorState(this.error);
}

class HallaqSuccessWorkTimeUpdateValueState extends LoginStates {}

class LoginErrorState2 extends LoginStates {
  ErrorMessage error;
  LoginErrorState2(this.error);
}

class InfoLoadingState extends LoginStates {}

class KeyboardChangeState extends LoginStates {}

class ThemChangeModeState extends LoginStates {}

class AutoAcceptModeState extends LoginStates {}

class InfoSuccessState extends LoginStates {
  InfoSuccessState();
}

class InfoErrorState extends LoginStates {
  final String error;
  InfoErrorState(this.error);
}

class CountryLoadingState extends LoginStates {}

class CountrySuccessState extends LoginStates {
  CountrySuccessState();
}

class ContryErrorState extends LoginStates {
  final String error;
  ContryErrorState(this.error);
}

class ShopProfileImagePickedSuccessState extends LoginStates {}

class ShopProfileImagePickedErrorState extends LoginStates {}

class fileImagePickedSucseesState extends LoginStates {}

class InfoChangeCounteryState extends LoginStates {}

class InfoChangeLimitState extends LoginStates {}

class InfoChangeFormTimeState extends LoginStates {}

class InfoChangeToTimeState extends LoginStates {}

class EmployeesLoadingState extends LoginStates {}

class EmployeesSuccessState extends LoginStates {
  EmployeesSuccessState();
}

class EmployeesErrorState extends LoginStates {
  final String error;
  EmployeesErrorState(this.error);
}

class LoginChangePasswordVisibilityState extends LoginStates {}

class AddEmployessLoadingState extends LoginStates {}

class AddEmployessSuccessState extends LoginStates {
  final MessageMdoel employeesModel;
  AddEmployessSuccessState(this.employeesModel);
}

class AddEmployessErrorState extends LoginStates {
  final String error;
  AddEmployessErrorState(this.error);
}

class UpdateEmployessLoadingState extends LoginStates {}

class UpdateEmployessSuccessState extends LoginStates {
  UpdateEmployessSuccessState();
}

class FcmSuccessState extends LoginStates {
  FcmSuccessState();
}

class UpdateEmployessErrorState extends LoginStates {
  final String error;
  UpdateEmployessErrorState(this.error);
}

class HallaqLoadingCancelEmployeeState extends LoginStates {}

class HallaqSuccessCancelEmployeeState extends LoginStates {}

class HallaqErrorCancelEmployeeState extends LoginStates {}
