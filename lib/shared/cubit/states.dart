import '../../models/accepted_rejected_model.dart';
import '../../models/order_model.dart';
import '../../models/profile_model.dart';

abstract class HallaqStates {}

class ChangeBottomNavState extends HallaqStates {
  // ignore: prefer_typing_uninitialized_variables
  final index;

  ChangeBottomNavState(this.index);
}

class AutoAcceptModeState extends HallaqStates {}

class ShopInitialState extends HallaqStates {}

class ShopChangeModeState extends HallaqStates {}

/////////////////////
class HallaqLoadingHomeDataState extends HallaqStates {}

class HallaqSuccessHomeDataState extends HallaqStates {}

class HallaqErrorHomeDataState extends HallaqStates {
  final String error;

  HallaqErrorHomeDataState(this.error);
}

class HallaqLoadingBookingDataState extends HallaqStates {}

class HallaqDayChaneState extends HallaqStates {}

class HallaqSuccessBookingDataState extends HallaqStates {}

class HallaqErrorBookingDataState extends HallaqStates {
  final String error;

  HallaqErrorBookingDataState(this.error);
}

class MyOrderLoadingState extends HallaqStates {
  List<DataOrder> oldPosts;
  final bool isFirstFetch;

  MyOrderLoadingState(this.oldPosts, {this.isFirstFetch = false});
}

class MyOrderSuccessState extends HallaqStates {
  final List<DataOrder> Posts;

  MyOrderSuccessState(this.Posts);
}

class MyOrderErrorState extends HallaqStates {}

class InfoLoadingState extends HallaqStates {}

class InfoSuccessState extends HallaqStates {
  InfoSuccessState();
}

class InfoSuccess2State extends HallaqStates {
  final ProfileModel profileModel;
  InfoSuccess2State(this.profileModel);
}

class InfoSuccess8State extends HallaqStates {
  final ProfileModel profileModel;
  InfoSuccess8State(this.profileModel);
}

class InfoLoading3State extends HallaqStates {}

class InfoSuccess3State extends HallaqStates {
  InfoSuccess3State();
}

class InfoSuccess7State extends HallaqStates {
  InfoSuccess7State();
}

class InfoSuccess6State extends HallaqStates {
  InfoSuccess6State();
}

class InfoSuccess4State extends HallaqStates {
  InfoSuccess4State();
}

class InfoSuccess5State extends HallaqStates {
  InfoSuccess5State();
}

class DeviceTokenUpdateState extends HallaqStates {
  DeviceTokenUpdateState();
}

class HallaqLoadingNotifcationState extends HallaqStates {}

class HallaqSuccessNotificationState extends HallaqStates {}

class HallaqErrorNotificationState extends HallaqStates {
  final String error;

  HallaqErrorNotificationState(this.error);
}

class InfoErrorState extends HallaqStates {
  final String error;
  InfoErrorState(this.error);
}

class InfoChangeLimitState extends HallaqStates {}

class InfoChangeCounteryState extends HallaqStates {}

class InfoChangeDayState extends HallaqStates {}

class fileImagePickedSucseesState extends HallaqStates {}

class HallaqLoadingGetProfilesState extends HallaqStates {}

class HallaqSuccessGetProfilesState extends HallaqStates {}

class HallaqErrorGetProfileState extends HallaqStates {
  final String error;

  HallaqErrorGetProfileState(this.error);
}

class HallaqLoadingCancelEmployeeState extends HallaqStates {}

class HallaqSuccessCancelEmployeeState extends HallaqStates {}

class HallaqErrorCancelEmployeeState extends HallaqStates {}

class CountryLoadingState extends HallaqStates {}

class CountrySuccessState extends HallaqStates {}

class ContryErrorState extends HallaqStates {
  final error;

  ContryErrorState(this.error);
}

class AceptOrRejectLoadingState extends HallaqStates {}

class AceptOrRejectSuccessState extends HallaqStates {
  AcceptedOrRejectedModel acceptedOrRejectedModel;
  AceptOrRejectSuccessState(this.acceptedOrRejectedModel);
}

class AceptOrRejectErrorState extends HallaqStates {}

class HallaqLoadingWorkTimeState extends HallaqStates {}

class HallaqSuccessWorkTimeState extends HallaqStates {}

class HallaqErrorWorkTimeState extends HallaqStates {
  final String error;

  HallaqErrorWorkTimeState(this.error);
}

class AddDayToListState extends HallaqStates {}

class HallaqLoadingWorkTimeUpdaeState extends HallaqStates {}

class HallaqSuccessWorkTimeUpdateState extends HallaqStates {}

class HallaqErrorWorkTimeUpdateState extends HallaqStates {
  final String error;

  HallaqErrorWorkTimeUpdateState(this.error);
}

class HallaqSuccessWorkTimeUpdateValueState extends HallaqStates {}

class FcmSuccessState extends HallaqStates {}

//////////////////////
///
class InfoChangeFormTimeState extends HallaqStates {}

class InfoChangeToTimeState extends HallaqStates {}

class ShopLoadingHomeDataState extends HallaqStates {}

class ShopSuccessHomeDataState extends HallaqStates {}

class ShopErrorHomeDataState extends HallaqStates {
  final String error;

  ShopErrorHomeDataState(this.error);
}

class ShopSuccessCategoriesState extends HallaqStates {}

class ShopErrorCategoriesState extends HallaqStates {
  final String error;

  ShopErrorCategoriesState(this.error);
}

class ShopSuccessChangeFavoritesState extends HallaqStates {}

class ShopErrorChangeFavoritesState extends HallaqStates {
  final String error;

  ShopErrorChangeFavoritesState(this.error);
}

class ShopSuccessGetFavoritesState extends HallaqStates {}

class ShopLoadingGetFavoritesState extends HallaqStates {}

class ShopErrorGetFavoritesState extends HallaqStates {
  final String error;

  ShopErrorGetFavoritesState(this.error);
}

class ShopSuccessGetUserDataState extends HallaqStates {}

class ShopLoadingGetUserDataState extends HallaqStates {}

class ShopErrorGetUserDataState extends HallaqStates {
  final String error;

  ShopErrorGetUserDataState(this.error);
}

class ShopSuccessUpdateUserState extends HallaqStates {
  // ShopSuccessUpdateUserState(this.userData);
}

class ShopLoadingUpdateUserState extends HallaqStates {}

class ShopErrorUpdateUserState extends HallaqStates {
  final String error;

  ShopErrorUpdateUserState(this.error);
}

class OpenDrawerState extends HallaqStates {}

class CloseDrawerState extends HallaqStates {}

class ShopProfileImagePickedSuccessState extends HallaqStates {}

class ShopProfileImagePickedErrorState extends HallaqStates {}

class ShopOnPageChangeState extends HallaqStates {}

class ShopLoadingGetProductDetailsState extends HallaqStates {}

class ShopSuccessGetProductDetailsState extends HallaqStates {}

class ShopErrorGetProductDetailsState extends HallaqStates {
  final String error;

  ShopErrorGetProductDetailsState(this.error);
}

class ShopSuccessAddAndRemoveFromCartState extends HallaqStates {}

class ShopErrorAddAndRemoveFromCartState extends HallaqStates {
  final String error;

  ShopErrorAddAndRemoveFromCartState(this.error);
}

class ShopSuccessAddQuantityState extends HallaqStates {}

class ShopErrorAddQuantityState extends HallaqStates {
  final String error;

  ShopErrorAddQuantityState(this.error);
}

class ShopSuccessGetCartsState extends HallaqStates {}

class ShopLoadingGetCartsState extends HallaqStates {}

class ShopErrorGetCartsState extends HallaqStates {
  final String error;

  ShopErrorGetCartsState(this.error);
}

class ShopLoadingAddAddressState extends HallaqStates {}

class ShopSuccessAddAddressState extends HallaqStates {}

class ShopErrorAddAddressState extends HallaqStates {
  final String error;

  ShopErrorAddAddressState(this.error);
}

class DeleteAcountLoadingState extends HallaqStates {}

class DeleteAcountSuccessState extends HallaqStates {}

class DeleteErrorAcountState extends HallaqStates {
  final String error;

  DeleteErrorAcountState(this.error);
}

class ShopLoadingAddOrderState extends HallaqStates {}

class ShopSuccessAddOrderState extends HallaqStates {}

class ShopErrorAddOrderState extends HallaqStates {
  final String error;

  ShopErrorAddOrderState(this.error);
}

class ShopLoadingGetFAQsState extends HallaqStates {}

class ShopSuccessGetFAQsState extends HallaqStates {}

class ShopErrorGetFAQsState extends HallaqStates {
  final String error;

  ShopErrorGetFAQsState(this.error);
}

class ShopChangeExpansionIconState extends HallaqStates {}

class ShopLoadingGetOrdersState extends HallaqStates {}

class ShopSuccessGetOrdersState extends HallaqStates {}

class ShopErrorGetOrdersState extends HallaqStates {
  final String error;

  ShopErrorGetOrdersState(this.error);
}

class ShopChangePasswordVisibility1State extends HallaqStates {}

class ShopChangePasswordVisibility2State extends HallaqStates {}

class ShopLoadingChangePasswordState extends HallaqStates {}

class ShopSuccessChangePasswordState extends HallaqStates {
  // final ChangePasswordModel changePasswordModel;
  // ShopSuccessChangePasswordState(this.changePasswordModel);
}

class ShopErrorChangePasswordState extends HallaqStates {
  final String error;

  ShopErrorChangePasswordState(this.error);
}

class ShopLoadingSearchState extends HallaqStates {}

class ShopSuccessSearchState extends HallaqStates {}

class ShopErrorSearchState extends HallaqStates {
  final error;
  ShopErrorSearchState(this.error);
}
