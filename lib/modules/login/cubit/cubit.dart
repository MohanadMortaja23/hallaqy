import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../../../models/countery_model.dart';
import '../../../models/employees_model.dart';
import '../../../models/error_message.dart';
import '../../../models/login_model.dart';
import '../../../models/message_model.dart';
import '../../../models/profile_model.dart';
import '../../../shared/network/local/cache_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);
  ErrorMessage? errorMessage;
  LoginModel? loginModel;
  void userLogin(
      {@required phone,
      @required device_name,
      @required type,
      @required device_token}) async {
    emit(LoginLoadingState());
    var response = await DioHelper.postData(url: type, data: {
      'device_name': device_name,
      'phone': phone,
      'device_token': device_token
    });
        if (response.statusCode == 200) {
      loginModel = LoginModel.fromJson(response.data);
      emit(LoginSuccessState(loginModel!));
    }
    if (response.statusCode == 422) {
      errorMessage = ErrorMessage.fromJson(response.data);
      print(errorMessage);
      emit(LoginErrorState2(errorMessage!));
    }
  }

  dynamic FromTime = DateTime.now().hour.toString();
  dynamic ToTime = DateTime.now().hour.toString();

  changeVauleUpdateTime(val, val2) {
    FromTime = val;
    ToTime = val2;
    emit(HallaqSuccessWorkTimeUpdateValueState());
  }

  void verifyLogin({@required phone, @required code}) {
    emit(LoginLoadingState());
    DioHelper.postData(
        url: 'partners/verify-code',
        data: {'phone': phone, 'code': code}).then((value) {
      print(value.data);
      loginModel = LoginModel.fromJson(value.data);
      print(loginModel!.user!.phone);
      print(loginModel!.user!.token);

      emit(LoginSuccessState(loginModel!));
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
      print(error.toString());
    });
  }

  bool KyeboardOpen = false;
  ChangeKeyboadr(val) {
    KyeboardOpen = val;
    emit(KeyboardChangeState());
  }

///// Info
  ///
  ///
  bool? isDark = CacheHelper.getBoolean(key: 'isDark') ?? false;

  void changeAppMode({required bool fromShared}) {
    isDark = !isDark!;
    CacheHelper.saveData(key: 'isDark', value: isDark).then((value) {
      emit(ThemChangeModeState());
    });
  }

  bool? AutoAccept = CacheHelper.getBoolean(key: 'AutoAccept') ?? false;

  void changeAutoAcceptMode({required bool fromShared}) {
    AutoAccept = !AutoAccept!;
    CacheHelper.saveData(key: 'AutoAccept', value: isDark).then((value) {
      emit(AutoAcceptModeState());
    });
  }

  void InfoData(
      {@required name, @required from, @required to, file, limitTime}) async {
    DateTime date1 = await DateFormat("hh:mm").parse("$from");
    DateTime date2 = await DateFormat("hh:mm").parse("$to");

    emit(InfoLoadingState());
    FormData formData = FormData.fromMap({
      'limit_time': int.parse('$limitTime'),
      'name': name,
      'work_time_from': DateFormat.Hms().format(date1),
      'work_time_to': DateFormat.Hms().format(date2),
      'image': file != null
          ? await MultipartFile.fromFile(file.path, filename: fileName)
          : null,
    });

    DioHelper.postData(
            url: 'partners/update-profile', data: formData, token: token)
        .then((value) {
      print(value.data);
      emit(InfoSuccessState());
    }).catchError((error) {
      emit(InfoErrorState(error.toString()));
      print(error.toString());
    });
  }

  CountryModel? countryModel;
  Future<void> getCountries() async {
    emit(CountryLoadingState());
    DioHelper.getData(
      url: 'countries',
      token: token,
    ).then((value) {
      print(value.data);
      countryModel = CountryModel.fromJson(value.data);
      emit(CountrySuccessState());
    }).catchError((error) {
      emit(ContryErrorState(error.toString()));
      print(error.toString());
    });
  }

  final picker = ImagePicker();
  File? file;

  Future<void> getImageFromGallery() async {
    final dynamic pickedImage =
        await picker.pickImage(source: ImageSource.gallery).then((value) {
      file = File(value!.path);
      emit(fileImagePickedSucseesState());
    });
    if (pickedImage != null) {
      fileName = pickedImage != null ? pickedImage.path.split('/').last : '';
      emit(ShopProfileImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(ShopProfileImagePickedErrorState());
    }
  }

  bool isShowPassword = true;

  void changePasswordVisibility() {
    isShowPassword = !isShowPassword;
    emit(LoginChangePasswordVisibilityState());
  }

  int? CounteryVal;

  void changeCounteryValue(val) {
    CounteryVal = int.parse('$val');
    emit(InfoChangeCounteryState());
  }

  dynamic Limit;

  void changeLimitValue(val) {
    Limit = val;
    emit(InfoChangeLimitState());
  }

  dynamic from_time = '10:00';

  void changeFromTime(val) {
    from_time = val;
    emit(InfoChangeFormTimeState());
  }

  dynamic to_time = '22:00';

  void changeToTime(val) {
    to_time = val;
    emit(InfoChangeToTimeState());
  }

  EmployeesModel? employeesModel;
  Future<void> getEmployees() async {
    employeesModel = null;
    emit(EmployeesLoadingState());
    DioHelper.getData(
      url: 'partners/employees',
      token: token,
    ).then((value) {
      print(value.data);
      employeesModel = EmployeesModel.fromJson(value.data);
      emit(EmployeesSuccessState());
    }).catchError((error) {
      emit(EmployeesErrorState(error.toString()));
      print(error.toString());
    });
  }

  MessageMdoel? employeesModel2;

  void AddEmployess({@required name, @required img}) async {
    FormData formData = FormData.fromMap({
      'name': name,
      'image': file != null
          ? await MultipartFile.fromFile(file!.path, filename: fileName)
          : null,
    });
    emit(AddEmployessLoadingState());
    DioHelper.postData(
      url: 'partners/employees',
      data: formData,
      token: token,
    ).then((value) {
      employeesModel2 = MessageMdoel.fromJson(value.data);
      print(value.data);

      emit(AddEmployessSuccessState(employeesModel2!));
    }).catchError((error) {
      emit(AddEmployessErrorState(error.toString()));
      print(error.toString());
    });
  }

  void DeleteEmployee({required int id}) {
    emit(HallaqLoadingCancelEmployeeState());
    DioHelper.deleteData(
      url: 'partners/employees/$id',
      token: token,
    ).then((value) {
      getEmployees();
      print(value.data);
      emit(HallaqSuccessCancelEmployeeState());
    }).catchError((error) {
      emit(HallaqErrorCancelEmployeeState());
    });
  }

  void UpdateEmployess({@required name, @required id}) async {
    print(name);
    print(id);
    emit(UpdateEmployessLoadingState());
    DioHelper.putData(
      url: 'partners/employees/$id',
      data: {
        'name': name,
      },
      token: token,
    ).then((value) {
      employeesModel2 = MessageMdoel.fromJson(value.data);
      print(value.data);

      emit(UpdateEmployessSuccessState());
    }).catchError((error) {
      emit(UpdateEmployessErrorState(error.toString()));
      print(error.toString());
    });
  }

  var myToken;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  void Fcm() {
    _firebaseMessaging.requestPermission();

    _firebaseMessaging.getToken().then((value) {
      myToken = value;
      print('this is my token');

      print(myToken);
      emit(FcmSuccessState());
    });
    print(myToken);
  }
}
