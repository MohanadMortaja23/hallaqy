import 'dart:ffi';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/models/message_model.dart';
import 'package:shop_app/models/order_model.dart';
import 'package:shop_app/modules/home_screen/home_screen.dart';
import 'package:shop_app/modules/nearby_screen/nearby_screen.dart';
import 'package:shop_app/modules/orders/orders_screen.dart';
import 'package:shop_app/modules/profile/profile_screen.dart';

import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../../models/accepted_rejected_model.dart';
import '../../models/booking_model.dart';
import '../../models/countery_model.dart';
import '../../models/dashboard_model.dart';
import '../../models/details_model.dart';
import '../../models/noftication_model.dart';
import '../../models/profile_model.dart';
import '../../models/work_time_model.dart';
import '../../modules/login/login_screen.dart';
import '../components/components.dart';

class HallaqCubit extends Cubit<HallaqStates> {
  HallaqCubit() : super(ShopInitialState());

  static HallaqCubit get(context) => BlocProvider.of(context);
/////////////////

  int bottomNavBarCurrentIndex = 0;

  List<Widget> bottomNavBarScreens = [
    HomeScreen(),
    OrdersScreen2(),
    ProfileScreen()
  ];

  Widget chooseBotNavBarScreen(int index) {
    return bottomNavBarScreens[index];
  }

  void changeBottomNavBarCurrentIndex(int index) {
    bottomNavBarCurrentIndex = index;
    emit(ChangeBottomNavState(bottomNavBarCurrentIndex));
  }

  ///////////////////////
  bool? AutoAccept = CacheHelper.getBoolean(key: 'AutoAccept') ?? false;

  void changeAutoAcceptMode({required bool fromShared}) {
    AutoAccept = !AutoAccept!;
    CacheHelper.saveData(key: 'AutoAccept', value: AutoAccept).then((value) {
      emit(AutoAcceptModeState());
    });
  }

  // HomeModel homeModel;
  DashboardModel? dashboardModel;

  void getDashboardData() {
    emit(HallaqLoadingHomeDataState());
    DioHelper.getData(
      url: 'partners/dashboard',
      token: token,
    ).then((value) {
      print(value.data);
      dashboardModel = DashboardModel.fromJson(value.data);
      emit(HallaqSuccessHomeDataState());
    }).catchError((error) {
      emit(HallaqErrorHomeDataState(error.toString()));
      print(error.toString());
    });
  }

  CountryModel? countryModel;
  DataCountery? initialCountery;
  Future<void> getCountries(id) async {
    emit(CountryLoadingState());
    DioHelper.getData(
      url: 'countries',
      token: token,
    ).then((value) {
      print(value.data);
      countryModel = CountryModel.fromJson(value.data);
      initialCountery = countryModel!.data!.firstWhere((e) {
        return e.id == id;
      });
      emit(CountrySuccessState());
    }).catchError((error) {
      emit(ContryErrorState(error.toString()));
      print(error.toString());
    });
  }

  WorkTime? workTime;
  void getWorkTime() {
    emit(HallaqLoadingWorkTimeState());
    DioHelper.getData(
      url: 'partners/getWorkTime',
      token: token,
    ).then((value) {
      workTime = WorkTime.fromJson(value.data);
      // categoriesModel = CategoriesModel.fromJson(value.data);
      emit(HallaqSuccessWorkTimeState());
    }).catchError((error) {
      emit(HallaqErrorWorkTimeState(error.toString()));
      print(error.toString());
    });
  }

  List<DataCountery>? data = [];

  void AddDayToList() {
    DataCountery dataCountery2 = DataCountery(id: 0, name: 'الاحد');
    data!.add(dataCountery2);

    DataCountery dataCountery3 = DataCountery(id: 1, name: 'الاثنين');
    data!.add(dataCountery3);

    DataCountery dataCountery4 = DataCountery(id: 2, name: 'الثلاثاء');
    data!.add(dataCountery4);

    DataCountery dataCountery5 = DataCountery(id: 3, name: 'الاربعاء');
    data!.add(dataCountery5);

    DataCountery dataCountery6 = DataCountery(id: 4, name: 'الخميس');
    data!.add(dataCountery6);

    DataCountery dataCountery7 = DataCountery(id: 5, name: 'الجمعة');

    DataCountery dataCountery1 = DataCountery(id: 6, name: 'السبت');
    data!.add(dataCountery1);
    data!.add(dataCountery7);
    emit(AddDayToListState());
  }

  MessageMdoel? messageMdoel;
  void UpdateWorkTime({required id, required from, required to}) {
    emit(HallaqLoadingWorkTimeUpdaeState());
    DioHelper.postData(
      data: {
        'id': id,
        'from': from,
        'to': to,
      },
      url: 'partners/updateWorkTime',
      token: token,
    ).then((value) {
      messageMdoel = MessageMdoel.fromJson(value.data);
      // categoriesModel = CategoriesModel.fromJson(value.data);
      emit(HallaqSuccessWorkTimeUpdateState());
    }).catchError((error) {
      emit(HallaqErrorWorkTimeUpdateState(error.toString()));
      print(error.toString());
    });
  }

  dynamic FromTime;
  dynamic ToTime;

  changeVauleUpdateTime(val, val2) {
    FromTime = val;
    ToTime = val2;
    emit(HallaqSuccessWorkTimeUpdateValueState());
  }

  String Day_id = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
  Future<void> changeTimeWork(val) async {
    String formattedDate =
    DateFormat('yyyy-MM-dd').format(val as DateTime).toString();

    Day_id = formattedDate;
    emit(HallaqDayChaneState());
  }

  // CategoriesModel categoriesModel;
  BookingModel? bookingModel;
  void getBookingTody(String date) {
    bookingModel = null;
    emit(HallaqLoadingBookingDataState());

    DioHelper.getData(
      url: 'partners/getbooking?date=$date',
      token: token,
    ).then((value) {
      bookingModel = BookingModel.fromJson(value.data);
      // categoriesModel = CategoriesModel.fromJson(value.data);
      emit(HallaqSuccessBookingDataState());
    }).catchError((error) {
      emit(HallaqErrorBookingDataState(error.toString()));
      print(error.toString());
    });
  }

  OrderMdoel? ordermdoel;
  int pageOrder = 1;
  void Get_Myorder() async {
    if (state is MyOrderLoadingState) return;
    final currentState = state;
    var oldPosts = <DataOrder>[];
    if (currentState is MyOrderSuccessState) {
      oldPosts = currentState.Posts;
    }

    emit(MyOrderLoadingState(oldPosts, isFirstFetch: pageOrder == 1));
    DioHelper.getData(url: 'partners/allbooking?page=$pageOrder', token: token)
        .then((value) {
      print(value.data);
      pageOrder++;
      final posts = (state as MyOrderLoadingState).oldPosts;
      ordermdoel = OrderMdoel.fromJson(value.data);
      print(ordermdoel!.data!.length);

      posts.addAll(ordermdoel!.data!);
      print(posts.length);

      print(pageOrder);

      emit(MyOrderSuccessState(posts));
    }).catchError((error) {
      emit(MyOrderErrorState());
      print(error.toString());
    });
  }

  void InfoData({name, country, file, phone}) async {
    emit(InfoLoadingState());
    FormData formData = FormData.fromMap({
      'name': name,
      'phone': phone,
      'country_id': country,
      'image': await MultipartFile.fromFile(file.path, filename: fileName),
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

  AcceptedOrRejectedModel? acceptedorrejectedmodel;
  void AceptOrReject({status, order_id}) async {
    acceptedorrejectedmodel = null;
    emit(AceptOrRejectLoadingState());

    DioHelper.postData(
        url: 'partners/accept-reject',
        data: {
          'status': status,
          'order_id': order_id,
        },
        token: token)
        .then((value) {
      acceptedorrejectedmodel = AcceptedOrRejectedModel.fromJson(value.data);

      emit(AceptOrRejectSuccessState(acceptedorrejectedmodel!));
    }).catchError((error) {
      emit(AceptOrRejectErrorState());
    });
  }

///////////////Get Profile Data
  ProfileModel? profilemodel;
  void getProfile() {
    emit(HallaqLoadingGetProfilesState());
    DioHelper.getData(
      url: 'partners/profile',
      token: token,
    ).then((value) {
      print(value.data);
      profilemodel = ProfileModel.fromJson(value.data);
      // ordersModel = OrdersModel.fromJson(value.data);
      emit(HallaqSuccessGetProfilesState());
    }).catchError((error) {
      emit(HallaqErrorGetProfileState(error.toString()));
    });
  }

  dynamic from_time = '01:00 Am';

  void changeFromTime(val) {
    from_time = val;
    emit(InfoChangeFormTimeState());
  }

  dynamic to_time = '2:00 PM';

  void changeToTime(val) {
    to_time = val;
    emit(InfoChangeToTimeState());
  }

  dynamic Limit;

  void changeLimitValue(val) {
    Limit = val;
    emit(InfoChangeLimitState());
  }

  int? CounteryVal;

  void changeCounteryValue(val) {
    CounteryVal = val;
    emit(InfoChangeCounteryState());
  }

  int? DayVal;

  void changeDayValue(val) {
    DayVal = val;
    emit(InfoChangeDayState());
  }

  ///
  void InfoData3(
      {int? country, int? auto_accept, device_token, holiday_id}) async {
    print(country);
    emit(InfoLoading3State());

    DioHelper.postData(
        url: 'partners/update-profile',
        data: {
          'country_id': country,
        },
        token: token)
        .then((value) {
      print(value.data);
      emit(InfoSuccess3State());
    }).catchError((error) {
      emit(InfoErrorState(error.toString()));
      print(error.toString());
    });
  }

  void InfoData5(
      {int? country, int? auto_accept, device_token, holiday_id}) async {
    print(country);
    emit(InfoLoading3State());

    DioHelper.postData(
        url: 'partners/update-profile',
        data: {
          'holiday_id': holiday_id,
        },
        token: token)
        .then((value) {
      print(value.data);
      emit(InfoSuccess7State());
    }).catchError((error) {
      emit(InfoErrorState(error.toString()));
      print(error.toString());
    });
  }

  void InfoData6({break_time_from, break_time_to}) async {
    emit(InfoLoading3State());

    DioHelper.postData(
        url: 'partners/update-profile',
        data: {
          'break_time_from': break_time_from,
          'break_time_to': break_time_to,
        },
        token: token)
        .then((value) {
      print(value.data);
      emit(InfoSuccess6State());
    }).catchError((error) {
      emit(InfoErrorState(error.toString()));
      print(error.toString());
    });
  }

  void Infotoken({device_token}) async {
    print(device_token);
    print('Divice Token updated ');
    emit(InfoLoading3State());

    DioHelper.postData(
        url: 'partners/refresh_device_token',
        data: {
          'device_token': device_token,
        },
        token: token)
        .then((value) {
      print(value.data);
      emit(DeviceTokenUpdateState());
    }).catchError((error) {
      emit(InfoErrorState(error.toString()));
      print(error.toString());
    });
  }

  void InfoData4({int? auto_accept}) async {
    emit(InfoLoading3State());

    DioHelper.postData(
        url: 'partners/update-profile',
        data: {'auto_accept': auto_accept},
        token: token)
        .then((value) {
      print(value.data);
      emit(InfoSuccess3State());
    }).catchError((error) {
      emit(InfoErrorState(error.toString()));
      print(error.toString());
    });
  }

  void InfoData2({name, country, file, phone, limitTime}) async {
    print(country);
    emit(InfoLoadingState());
    FormData formData = FormData.fromMap({
      'name': name,
      'phone': phone,
      'limit_time': int.parse('$limitTime'),
    });

    DioHelper.postData(
        url: 'partners/update-profile', data: formData, token: token)
        .then((value) {
      print(value.data);
      profilemodel = ProfileModel.fromJson(value.data);
      emit(InfoSuccess2State(profilemodel!));
    }).catchError((error) {
      emit(InfoErrorState(error.toString()));
      print(error.toString());
    });
  }

  void InfoData8({limitTime}) async {
    emit(InfoLoadingState());
    DioHelper.postData(
        url: 'partners/update-profile',
        data: {
          'limit_time': int.parse('$limitTime'),
        },
        token: token)
        .then((value) {
      print(value.data);
      profilemodel = ProfileModel.fromJson(value.data);
      emit(InfoSuccess8State(profilemodel!));
    }).catchError((error) {
      emit(InfoErrorState(error.toString()));
      print(error.toString());
    });
  }

  void InfoData7({name, country, file, phone, limitTime}) async {
    print(country);
    emit(InfoLoadingState());
    FormData formData = FormData.fromMap({
      'name': name,
      'phone': phone,
    });

    DioHelper.postData(
        url: 'partners/update-profile', data: formData, token: token)
        .then((value) {
      print(value.data);
      profilemodel = ProfileModel.fromJson(value.data);
      emit(InfoSuccess2State(profilemodel!));
    }).catchError((error) {
      emit(InfoErrorState(error.toString()));
      print(error.toString());
    });
  }

  final picker = ImagePicker();
  File? file;

  // Implementing the image picker

  Future<void> getImageFromGallery() async {
    final dynamic pickedImage =
    await picker.pickImage(source: ImageSource.gallery).then((value) {
      file = File(value!.path);
      emit(fileImagePickedSucseesState());
    });
    if (pickedImage != null) {
      fileName = pickedImage != null ? pickedImage.path.split('/').last : '';

      // InfoData(file: file);
      emit(ShopProfileImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(ShopProfileImagePickedErrorState());
    }
  }

  Map<int, bool> favorites = {};

  // ChangeFavoritesModel changeFavoritesModel;

  Map<int, bool> carts = {};

  // ChangeCartsModel changeCartsModel;

  void getUserData() {
    emit(ShopLoadingGetUserDataState());
    DioHelper.getData(url: PROFILE, token: token).then((value) {
      // userModel = LoginModel.fromJson(value.data);
      emit(ShopSuccessGetUserDataState());
    }).catchError((error) {
      emit(ShopErrorGetUserDataState(error.toString()));
      print(error.toString());
    });
  }

  void updateUserFullName(
      {required String name,
        @required email,
        @required phone,
        @required image}) {
    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(url: UPDATE_PROFILE, token: token!, data: {
      'name': name,
      'email': email,
      'phone': phone,
      'image': image
    }).then((value) {
      // userModel = LoginModel.fromJson(value.data);
      // emit(ShopSuccessUpdateUserState(userModel));
    }).catchError((error) {
      emit(ShopErrorUpdateUserState(error.toString()));
      print(error.toString());
    });
  }

  // ProductDetailsModel productDetailsModel;

  void getProductDetailsModel({
    int? id,
  }) {
    emit(ShopLoadingGetProductDetailsState());
    DioHelper.getData(
      url: 'products/$id',
      token: token,
    ).then((value) {
      // productDetailsModel = ProductDetailsModel.fromJson(value.data);
      emit(ShopSuccessGetProductDetailsState());
    }).catchError((error) {
      emit(ShopErrorGetProductDetailsState(error.toString()));
      print(error.toString());
    });
  }

  NotificationModel? notificationModel;
  void getNotification() {
    emit(HallaqLoadingNotifcationState());
    DioHelper.getData(
      url: 'partners/notifications',
      token: token,
    ).then((value) {
      notificationModel = NotificationModel.fromJson(value.data);
      // categoriesModel = CategoriesModel.fromJson(value.data);
      emit(HallaqSuccessNotificationState());
    }).catchError((error) {
      emit(HallaqErrorNotificationState(error.toString()));
      print(error.toString());
    });
  }

  void DeleteAccoount(ctx) {
    emit(DeleteAcountLoadingState());
    DioHelper.deleteData(
      url: 'partners/delete-profile',
      token: token,
    ).then((value) {
      // getCarts();
      CacheHelper.removeData(key: 'token').then((value) {
        navigatorReplacement(ctx, LoginScreen());
      });
      emit(DeleteAcountSuccessState());
    }).catchError((error) {
      emit(DeleteErrorAcountState(error.toString()));
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
      Infotoken(device_token: myToken);
      emit(FcmSuccessState());
    });
    print(myToken);
  }

  bool isDark = false;

  // void changeAppMode({bool fromShared}) {
  //   if (fromShared != null) {
  //     isDark = fromShared;
  //     emit(ShopChangeModeState());
  //   } else {
  //     isDark = !isDark;
  //     CacheHelper.setBoolean(key: 'isDark', value: isDark).then((value) {
  //       emit(ShopChangeModeState());
  //     });
  //   }
  // }

  void addAddress({
    required String name,
    required String city,
    required String region,
    required String details,
    required String notes,
  }) {
    emit(ShopLoadingAddAddressState());
    DioHelper.postData(
      url: ADDRESS,
      token: token!,
      data: {
        'name': name,
        'city': city,
        'region': region,
        'details': details,
        'notes': notes,
        'latitude': '3123123',
        'longitude': '2121545',
      },
    ).then((value) {
      addOrder(idAddress: value.data['data']['id']);
      emit(ShopSuccessAddAddressState());
    }).catchError((error) {
      emit(ShopErrorAddAddressState(error.toString()));
      print(error.toString());
    });
  }

  void addOrder({
    required int idAddress,
  }) {
    emit(ShopLoadingAddOrderState());
    DioHelper.postData(
      url: ORDERS,
      token: token!,
      data: {
        'address_id': idAddress,
        'payment_method': 1,
        'use_points': false,
      },
    ).then((value) {
      // getCarts();
      emit(ShopSuccessAddOrderState());
    }).catchError((error) {
      emit(ShopErrorAddOrderState(error.toString()));
    });
  }

  // FaqsModel faqsModel;

  // void getFAQs() {
  //   emit(ShopLoadingGetFAQsState());
  //   DioHelper.getData(
  //     url: FAQS,
  //   ).then((value) {
  //     faqsModel = FaqsModel.fromJson(value.data);
  //     emit(ShopSuccessGetFAQsState());
  //   }).catchError((error) {
  //     emit(ShopErrorGetFAQsState(error.toString()));
  //   });
  // }

  bool expansionIcon = false;

  void changeExpansionIcon(bool value) {
    expansionIcon = value;
    emit(ShopChangeExpansionIconState());
  }

  // OrdersModel ordersModel;

  void getOrders() {
    emit(ShopLoadingGetOrdersState());
    DioHelper.getData(
      url: ORDERS,
      token: token,
    ).then((value) {
      // ordersModel = OrdersModel.fromJson(value.data);
      emit(ShopSuccessGetOrdersState());
    }).catchError((error) {
      emit(ShopErrorGetOrdersState(error.toString()));
    });
  }

  bool isShowPassword1 = true;

  void changePasswordVisibility1() {
    isShowPassword1 = !isShowPassword1;
    emit(ShopChangePasswordVisibility1State());
  }

  bool isShowPassword2 = true;

  void changePasswordVisibility2() {
    isShowPassword2 = !isShowPassword2;
    emit(ShopChangePasswordVisibility2State());
  }

  // ChangePasswordModel changePasswordModel;

  void changePassword({
    required String currentPassword,
    required String newPassword,
  }) {
    emit(ShopLoadingChangePasswordState());
    DioHelper.postData(
      url: CHANGE_PASSWORD,
      token: token!,
      data: {
        'current_password': currentPassword,
        'new_password': newPassword,
      },
    ).then((value) {
      // changePasswordModel=ChangePasswordModel.fromJson(value.data);
      print('=======================================');
      print(value.data);
      print('=======================================');
      // emit(ShopSuccessChangePasswordState(changePasswordModel));
    }).catchError((error) {
      emit(ShopErrorChangePasswordState(error.toString()));
      print(error.toString());
    });
  }

  // SearchModel searchModel;

  void search({required String text}) {
    emit(ShopLoadingSearchState());
    DioHelper.postData(
      url: PRODUCTS_SEARCH,
      token: token!,
      data: {
        'text': text,
      },
    ).then((value) {
      // searchModel = SearchModel.fromJson(value.data);
      emit(ShopSuccessSearchState());
    }).catchError((error) {
      emit(ShopErrorSearchState(error.toString()));
    });
  }

  Future<void> getImageFromCamera() async {
    final dynamic pickedImage = await picker.pickImage(
        source: ImageSource.camera, maxHeight: 1800, maxWidth: 1800);
    if (pickedImage != null) {
      // profileImage = File(pickedImage.path);
      // List<int> imageBytes = profileImage.readAsBytesSync();
      // base64Image = base64Encode(imageBytes);
      emit(ShopProfileImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(ShopProfileImagePickedErrorState());
    }
  }
}
