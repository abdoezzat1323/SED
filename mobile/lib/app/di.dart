import 'package:dio/dio.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sed/app/app_preferences.dart';
import 'package:sed/data/network/app_api.dart';
import 'package:sed/data/network/dio_factory.dart';
import 'package:sed/data/network/network_info.dart';
import 'package:sed/data/repository/repository_impl.dart';
import 'package:sed/data/source/remote_data_source.dart';
import 'package:sed/domain/repository/repository.dart';
import 'package:sed/domain/usecase/change_password_usecase.dart';
import 'package:sed/domain/usecase/chat_messages_usecase.dart';
import 'package:sed/domain/usecase/chat_send_message_usecase.dart';
import 'package:sed/domain/usecase/delete_item_usecase.dart';
import 'package:sed/domain/usecase/forgotpassword_usecase.dart';
import 'package:sed/domain/usecase/get_all_conversations_usecase.dart';
import 'package:sed/domain/usecase/get_saved_products.dart';
import 'package:sed/domain/usecase/home_usecase.dart';
import 'package:sed/domain/usecase/item_usecase.dart';
import 'package:sed/domain/usecase/login_usecase.dart';
import 'package:sed/domain/usecase/myprofile_data_usecase.dart';
import 'package:sed/domain/usecase/myprofile_get_ads_usecase.dart';
import 'package:sed/domain/usecase/new_conversation_usecase.dart';
import 'package:sed/domain/usecase/notifications.dart';
import 'package:sed/domain/usecase/register_usecase.dart';
import 'package:sed/domain/usecase/reset_password_otp_usecase.dart';
import 'package:sed/domain/usecase/reset_password_usecase.dart';
import 'package:sed/domain/usecase/saving_products_usecase.dart';
import 'package:sed/domain/usecase/search_usecase.dart';
import 'package:sed/domain/usecase/show_items_usecase.dart';
import 'package:sed/domain/usecase/show_profile_usecase.dart';
import 'package:sed/domain/usecase/update_profile_usecase.dart';
import 'package:sed/domain/usecase/verify_email_usecase.dart';
import 'package:sed/presentation/forgot_password/viewmodel/forgotpassword_viewmodel.dart';
import 'package:sed/presentation/login/viewmodel/login_viewmodel.dart';
import 'package:sed/presentation/main_screen/items_screen/viewmodel/products_screen_viewmodel.dart';
import 'package:sed/presentation/main_screen/main_screen_viewmodel/main_screen_viewmodel.dart';
import 'package:sed/presentation/main_screen/sub_screens/chat_screen/message/viewmodel/message_viewmodel.dart';
import 'package:sed/presentation/main_screen/sub_screens/chat_screen/viewmodel/chat_screen_viewmodel.dart';
import 'package:sed/presentation/main_screen/sub_screens/home_screen/view/home_screen_view.dart';
import 'package:sed/presentation/main_screen/sub_screens/home_screen/viewmodel/home_screen_viewmodel.dart';
import 'package:sed/presentation/main_screen/sub_screens/show_items_screen/viewmodel/show_items_screen_viewmodel.dart';
import 'package:sed/presentation/register/viewmodel/register_viewmodel.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/usecase/add_advertisement_usecase.dart';
import '../domain/usecase/update_ad_usecase.dart';
import 'noti.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  //app module, its a module where we put all generic dependencies

  //shared prefs instance
  final sharedPrefs = await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(() =>
      sharedPrefs); //app preference needs an instance of shared preference so we have to initialize one first.

  // app prefs instance
  instance.registerLazySingleton<AppPreferences>(() => AppPreferences(
      instance())); //instance() gets the required instance so it returns sharedPrefs at this case.

  // network info
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  // dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  Dio dio = await instance<DioFactory>().getDio();

  //app service client
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  instance.registerFactory<ResetPasswordOTPUseCase>(
      () => ResetPasswordOTPUseCase(instance()));

  instance.registerFactory<ResetPasswordUsecase>(
      () => ResetPasswordUsecase(instance()));

  // remote data source
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(instance<AppServiceClient>()));

  // repository
  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance()));

  // main screen view
  instance
      .registerLazySingleton<MainScreenViewModel>(() => MainScreenViewModel());

  // home screen view
  instance
      .registerLazySingleton<HomeScreenViewModel>(() => HomeScreenViewModel());

  instance.registerLazySingleton<HomeScreenView>(() => const HomeScreenView());

  instance.registerFactory<HomeUseCase>(() => HomeUseCase(instance()));

  instance.registerLazySingleton<ProductScreenViewModel>(
      () => ProductScreenViewModel());

  instance.registerFactory<ProductUseCase>(() => ProductUseCase(instance()));

  instance
      .registerLazySingleton<ShowItemsViewModel>(() => ShowItemsViewModel());

  instance
      .registerFactory<ShowItemsUseCase>(() => ShowItemsUseCase(instance()));

  instance.registerFactory<SavingProductsUseCase>(
      () => SavingProductsUseCase(instance()));

  instance.registerFactory<ShowProfileUseCase>(
      () => ShowProfileUseCase(instance()));

  instance.registerFactory<AddAdvertisementUseCase>(
      () => AddAdvertisementUseCase(instance()));

  instance.registerFactory<MyProfileDataUseCase>(
      () => MyProfileDataUseCase(instance()));

  instance.registerFactory<MyProfileAdsUseCase>(
      () => MyProfileAdsUseCase(instance()));

  instance.registerFactory<RemoveAdUseCase>(() => RemoveAdUseCase(instance()));

  instance.registerFactory<UpdateAdUseCase>(() => UpdateAdUseCase(instance()));

  instance.registerFactory<NotificationsUseCase>(
      () => NotificationsUseCase(instance()));

  instance.registerFactory<VerifyEmailUseCase>(
      () => VerifyEmailUseCase(instance()));

  instance.registerFactory<GetSavedProductsUseCase>(
      () => GetSavedProductsUseCase(instance()));

  instance.registerFactory<UpdateProfileUseCase>(
      () => UpdateProfileUseCase(instance()));

  instance.registerFactory<ChangePasswordUsecase>(
      () => ChangePasswordUsecase(instance()));

  instance.registerFactory<SearchUseCase>(() => SearchUseCase(instance()));

  instance.registerFactory<NewConversationUseCase>(
      () => NewConversationUseCase(instance()));

  instance.registerFactory<GetAllConversationsUseCase>(
      () => GetAllConversationsUseCase(instance()));

  instance.registerFactory<ChatMessagesUseCase>(
      () => ChatMessagesUseCase(instance()));

  instance
      .registerFactory<NewMessageUseCase>(() => NewMessageUseCase(instance()));

  instance.registerLazySingleton<ChatViewModel>(() => ChatViewModel());

  instance.registerLazySingleton<MessageViewModel>(() => MessageViewModel());

  await initNotificationModule();
}

initLoginModule() async {
  // to check if i added it before at Get It or its the first time
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    // Login use case
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));

    // Login view model
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}

initForgotPasswordModule() async {
  // to check if i added it before at Get It or its the first time
  if (!GetIt.I.isRegistered<ForgotPasswordUseCase>()) {
    // Forgot password use case
    instance.registerFactory<ForgotPasswordUseCase>(
        () => ForgotPasswordUseCase(instance()));

    // Forgot password view model
    instance.registerFactory<ForgotPasswordViewModel>(
        () => ForgotPasswordViewModel(instance()));
  }
}

initRegisterModule() async {
  // to check if i added it before at Get It or its the first time
  if (!GetIt.I.isRegistered<RegisterUseCase>()) {
    // Register use case
    instance
        .registerFactory<RegisterUseCase>(() => RegisterUseCase(instance()));

    // Register view model
    instance.registerFactory<RegisterViewModel>(
        () => RegisterViewModel(instance()));
  }
}

initNotificationModule() async {
  // Notification use case
  instance.registerFactory<FlutterLocalNotificationsPlugin>(
      () => FlutterLocalNotificationsPlugin());

  Noti.initialize(instance<FlutterLocalNotificationsPlugin>());
}
