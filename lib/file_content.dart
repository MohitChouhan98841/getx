part of 'init_get.dart';
class DataStrings {
  static final name = Directory.current.path
      .split('/')
      .last;
  static const appPages = r"""
import 'package:get/get.dart';
import 'app_routes.dart';

class AppPages {
  static const initial = AppRoutes.splash;

  static List<GetPage> routes = [
  ];
}
""";
  static const appRoutes = """
class AppRoutes {
}
""";
  static final networkService = """
import 'dart:async';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:$name/screen/base/base_controller.dart';
"""r"""
class NetworkService extends GetxService {
  var isAvailable = false.obs;
  final _connectivity = Connectivity();
  late StreamSubscription _streamSubscription;

  @override
  void onInit() {
    super.onInit();
    getNetworkConnectionType();
    _streamSubscription = _connectivity.onConnectivityChanged.listen(_updateState);
  }

  Future<void> getNetworkConnectionType() async {
    ConnectivityResult? connectivityResult;
    try {
      connectivityResult = await (_connectivity.checkConnectivity());
    } on PlatformException catch (e) {
      log(e.toString());
    }
    return _updateState(connectivityResult);
  }

  void _updateState(ConnectivityResult? result) {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        isAvailable.value = true;
        break;
      case ConnectivityResult.none:
        isAvailable.value = false;
        break;
      default:
        final ctrl = Get.find<AppBaseController>();
        ctrl.showToast(msg: 'Network Error\nFailed to get Network Status');
        isAvailable.value = false;
        break;
    }
  }

  @override
  void onClose() {
    _streamSubscription.cancel();
  }
}
""";
  static const appColors = r"""
import 'package:flutter/material.dart';

class AppColors {
  static const Color bgColor = Color(0xFFF8F4E9);
  static const Color txtColor = Color(0xFF333333);
  static const Color txtLightColor = Color(0xFF5A5856);
}  
""";
  static const assetsConstant = r"""
class AssetsConstants{
  static const _path="assets/icons";
  //Images _path
  static const String splashLogo ="$_path/splash_logo.png";
  static const String edit ="$_path/edit.png";
  static const String searchIcon ="$_path/search_ic.png";
  static const String filterApplied ="$_path/filter_applied.png";
  static const String filter ="$_path/filter.png";
  static const String mapView ="$_path/map_view_ic.png";
}
""";
  static const appConstants = r"""
//dynamic link query param
const String baseDeepLink = 'https://sepetbox.page.link';
const String storeId = 'store_id';

//dialog type
const int okDialog = 0;
const int yesDialog = 1;

//date format
const String serverFormat = 'yyyy-MM-dd HH:mm:ss';
const String utcFormatDate = "yyyy-MM-dd'T'HH:mm:ss.SSSZ";

//basic constants
const String appName = 'Sepetbox';
const String start = 'Start';

///Google Api keys
//  const String googleApiKey = 'AIzaSyBSkayFQ7A57IipzkYAWrmcxZ3xlA7xOi4';
const String googleApiKey = 'AIzaSyDrlXF4FADo4X4jC4r9tb-Cyty5Xf7sgbE';

///App currency which use to show as symbol
const String appCurrencySymbol = '₺';
""";
  static const sharePre = r"""
import 'package:get_storage/get_storage.dart';

class SharedPre {
  static final SharedPre _sharedPre = SharedPre._internal();

  factory SharedPre() {
    return _sharedPre;
  }

  SharedPre._internal();

  //shared keys
  static const isLogin = 'isLogin';
  static const language = 'language';
  static const loginUser = 'loginUser';
  static const introDone = 'introDone';
  static const locationSet = 'locationSet';
  static const searchRadius = 'searchRadius';
  static const locationData = 'locationData';
  static const authToken = 'authToken';
  static const deviceToken = 'deviceToken';
  static const lastExportEmail = 'lastExportEmail';

  static Future<void> setValue(String key, dynamic value) async {
    final storage = GetStorage();
    return storage.write(key, value);
  }

  static String getStringValue(String key, {String? defaultValue}) {
    final storage = GetStorage();
    return storage.read<String>(key) ?? defaultValue ?? '';
  }

  static getBoolValue(String key, {bool defaultValue = false}) {
    final storage = GetStorage();
    return storage.read<bool>(key) ?? false;
  }

  static getIntValue(String key, {int? defaultValue}) {
    final storage = GetStorage();
    return storage.read<int>(key) ?? defaultValue ?? -1;
  }

  static getDoubleValue(String key, {double? defaultValue}) {
    final storage = GetStorage();
    return storage.read<double>(key) ?? defaultValue ?? -1;
  }

  static Future<void> clearAll() async {
    final deviceToken = getStringValue(SharedPre.deviceToken);
    await GetStorage().erase();
    return setValue(SharedPre.deviceToken, deviceToken);
  }

  /// call this method like this
  ///var data= sp.getObj("key);
  ///Login loginData= Logindata.fromjson(data);
  static Map<String, dynamic> getObj(String key) {
    final prefs = GetStorage();
    return prefs.read<Map<String, dynamic>>(key) ?? {};
  }
} 
""";
  static const space = r"""
import 'package:flutter/material.dart';

extension Space on int {
  Widget toSpace({bool horizontally = true, bool vertically = true}) {
    assert(horizontally != false || vertically != false);
    return SizedBox(
      width: horizontally ? toDouble() : 0,
      height: vertically ? toDouble() : 0,
    );
  }
}
 """;
  static final appTextButton = """
import 'package:flutter/material.dart';
import 'package:$name/screen/extension/text_style.dart';
import 'package:$name/utils/app_colors.dart';

class AppTextButton extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final Color? buttonColor;
  final VoidCallback? onPressed;

  ///for full width button set Alignment.center
  final Alignment? alignment;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final BorderSide? borderSide;
  final BorderRadiusGeometry? borderRadius;
  final Size? minimumSize;
  final Widget? icon;
  final bool tagDragSizeAllow;
  const AppTextButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.textStyle,
    this.tagDragSizeAllow=true,
    this.buttonColor,
    this.alignment,
    this.padding,
    this.margin,
    this.borderSide,
    this.icon,
    this.minimumSize,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: TextButton(

              style: TextButton.styleFrom(
                // visualDensity:VisualDensity(),
                tapTargetSize: tagDragSizeAllow?null:MaterialTapTargetSize.shrinkWrap,
                backgroundColor: buttonColor ?? Colors.red,
                minimumSize: minimumSize,
                shape: RoundedRectangleBorder(
                  borderRadius: borderRadius ?? BorderRadius.circular(0),
                  side: borderSide ??BorderSide.none
                ),
              ),
              onPressed: onPressed,
              child: Container(
                alignment: alignment,
                padding: padding,
                child: Text(
                  text,
                  style: textStyle ??
                      const TextStyle().bold.copyWith(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                ),
              ),
            ),
    );
  }
}

 """;
  static final textStyle = """
import 'package:flutter/material.dart';
import 'package:$name/utils/app_colors.dart';

extension TextStyles on TextStyle {
  TextStyle get appBarTitleStyle => const TextStyle(
    fontWeight: FontWeight.w900,
    fontSize: 18,
  );

  TextStyle get medium => const TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 15,
  );

  TextStyle get bold => const TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 16,
    color: AppColors.txtColor,
  );

  TextStyle get regular => const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 16,
    color: AppColors.txtColor,
  );

  TextStyle get italic => const TextStyle(
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.w400,
    fontSize: 15,
  );

  TextStyle get small => const TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12,
  );

  TextStyle get smallLight => const TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12,
  );
}

 """;
  static final api = """
import 'dart:convert';
import 'package:get/get.dart';
import 'package:$name/services/api_service/resp_bin/common_resp.dart';
import 'api_client.dart';
import 'api_methods.dart';
"""
  r"""
class Api {
  final ApiMethods _apiMethods = ApiMethods();
  final ApiClient _apiClient = ApiClient();
  final errorMessage = 'server not responding';
  static final Api _api = Api._internal();

  factory Api() {
    return _api;
  }

  Api._internal();

  Map<String, String> _getHeader() {
    String token = "";
    return {
      // 'Authorization': "Bearer $token",
      "Content-Type": 'application/json',
    };
  }


  Future<CommonResp> verifyUserPhone(Map body) async {
    try {
      String resp = await _apiClient.postMethod(
        method: _apiMethods.optVerify,
        body: jsonEncode(body),
        header: _getHeader(),
      );

      if (resp.isNotEmpty) {
        return commonRespFromJson(resp);
      } else {
        return CommonResp(message: errorMessage);
      }
    } on Exception catch (e) {
      Get.log('exception on ${_apiMethods.optVerify} $e');
      return CommonResp(message: errorMessage);
    }
  }
}
 """;
  static const apiClient = r"""
import 'dart:developer';
import 'package:get/get_connect/connect.dart';
import 'package:http/http.dart' as http;

class ApiClient extends GetConnect {
  static final ApiClient _apiClient = ApiClient._internal();

  factory ApiClient() {
    return _apiClient;
  }

  ApiClient._internal();

  ///Production
  // static const baseAppUrl = "   your production  base url "; 
  ///Development
  static const baseAppUrl = " your Development  base url "; 
 




  @override
  void onInit() {
    baseUrl = baseAppUrl;
    /*httpClient.addAuthenticator<void>((request) async {
      final token = SharedPre.getStringValue(SharedPre.authToken);
      request.headers['Authorization'] =  "Bearer $token";
      return request;
    });*/

    ///Authenticator will be called 3 times if HttpStatus is
    ///HttpStatus.unauthorized
    //httpClient.maxAuthRetries = 3;
  }

  Future<String> getMethod({
    required String method,
    Map<String, String>? header,
  }) async {
    try {
      log("$baseAppUrl$method");
      if (header != null) {
        log(header.toString());
      }
      // final response = await get("$baseAppUrl$method", headers: header);
      final response = await http.get(
        Uri.parse("$baseAppUrl$method"),
        headers: header,
      );
      log(response.body);
      /*final json = jsonDecode(response.body);
      if (json['code'] == 403) {
        //user blocked
        Get.offAndToNamed(
          AppRoutes.authView,
          arguments: json['message'].toString(),
        );
      }
      if (json['code'] == 401) {
        //token expired
        Get.offAndToNamed(
          AppRoutes.authView,
          arguments: 'Session expired!!!\nPlease login again.',
        );
      }*/
      return response.body;
    } catch (e) {
      log("______ getMethode error ${e.toString()}");
      return '';
    }
  }

  // Post request
  Future<String> postMethod({
    required method,
    String? otherBase,
    required var body,
    Map<String, String>? header,
  }) async {
    try {
      String url;
      if(otherBase==null) {
        url="$baseAppUrl$method";
      } else
      {
        url="$otherBase$method";
      }
      log(url);
      if (header != null) {
        log(header.toString());
      }
      log(body.toString());
      //final response = await post(url, body, headers: header);
      final response = await http.post(
        Uri.parse(url),
        body: body,
        headers: header,
      );
      log(response.body);
      return response.body;
    } catch (e) {
      log("______ post Method error ${e.toString()}");
      return '';
    }
  }

  /// Post request with File
  /// final form = FormData({
  ///   'file': MultipartFile(image, filename: 'avatar.png'),
  ///   'otherFile': MultipartFile(image, filename: 'cover.png'),
  /// });
  Future<String> postWithMultiPart({
    required method,
    required FormData formData,
    Map<String, String>? headers,
  }) async {
    try {
      String url = '$baseAppUrl$method';
      log(url);
      log(formData.files.toString());
      log(formData.fields.toString());
      if (headers?.isNotEmpty ?? false) {
        log(headers.toString());
      }
      final response = await post(
        url,
        formData,
        headers: headers,
      );
      log(response.bodyString.toString());
      return response.bodyString ?? '';
    } catch (e) {
      log("______ postWithMultiPart error ${e.toString()}");
      return '';
    }
  }

  Future<String> postMethodMultipart(
      http.MultipartRequest request, {
        Map<String, String>? header,
      }) async {
    try {
      log(request.fields.toString());
      if (request.files.isNotEmpty) {
        for (var element in request.files) {
          log(element.filename.toString());
        }
      }
      if (header != null) {
        request.headers.addAll(header);
      }
      http.Response response =
      await http.Response.fromStream(await request.send());
      log(response.body.toString());
      return response.body;
    } catch (e) {
      log("______ postMethodMultipart error ${e.toString()}");
      return '';
    }
  }
}
""";
  static const apiMethod = r"""
class ApiMethods {
  static final ApiMethods _apiMethods = ApiMethods._internal();

  factory ApiMethods() {
    return _apiMethods;
  }

  ApiMethods._internal();

  String optVerify = 'optVerifiy';
  String editProfile = 'editProfile';

  
  //payment
  String customers = 'customers';
  String createCard = 'payment_methods';
  String saveCard = 'payment_method/attach';
}

""";
  static const commonResp = r"""
import 'dart:convert';

CommonResp commonRespFromJson(String resp)=>CommonResp.fromJson(jsonDecode(resp));

class CommonResp {
  bool? status;
  int? code;
  String? message,discount;

  CommonResp({this.code, this.message, this.status,this.discount});

  factory CommonResp.fromJson(Map json)=>
      CommonResp(
        message: json['message'].toString(),
        status: json['status'],
        code: json['code'],
        discount: json['discount'].toString(),
      );
}

PromotionResp promotionRespFromJson(String resp)=>PromotionResp.fromJson(jsonDecode(resp));

class PromotionResp {
  bool? status;
  int? code;
  PromotionData? data;

PromotionResp({this.code, this.data, this.status});
  factory PromotionResp.fromJson(Map json)=>
      PromotionResp(
        data: PromotionData.fromJson((json['data'] as List).first),
        status: json['status'],
        code: json['code'],
      );
}

class PromotionData {
  String? header,link;
  PromotionData({this.link, this.header});
  factory PromotionData.fromJson(Map json)=>
      PromotionData(
        header: json['Header'],
        link: json['Link'],
      );
}
""";
  static final firebase = """
import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:$name/utils/shared_pre.dart';
"""
  r"""
      
//Todo change this with your app name 
const String channelName = "Hanggy Food";
const String channelId = "com.hanggyfood.android";
AndroidNotificationChannel channel = const AndroidNotificationChannel(
  channelId, channelName,
  importance: Importance.max,
  //sound: RawResourceAndroidNotificationSound('notification'),
);

class FBNotification {
  FBNotification._();

  static final FlutterLocalNotificationsPlugin localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  factory FBNotification() => _instance;
  static final FBNotification _instance = FBNotification._();

  Future<void> init() async {
    // For iOS request permission first.
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    final DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int? id, String? title, String? body, String? payload) {
        //FBNotification.showNotification(title, body);
      },
    );
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await localNotificationsPlugin.initialize(initializationSettings,
        /*onSelectNotification: (payload) {
      if (payload?.isNotEmpty ?? false) {
        _payloadParse(payload!);
      }
    }*/);
    await localNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      SharedPre.setValue(SharedPre.deviceToken, token ?? '');
      debugPrint('_____ onToken $token');
    } catch (e) {
      debugPrint(e.toString());
    }
    FirebaseMessaging.instance.onTokenRefresh.listen((token) async {
      SharedPre.setValue(SharedPre.deviceToken, token);
      debugPrint('_____ onToken $token');
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      debugPrint('___ data ${message.data.toString()}');
      debugPrint(
          '___ notification ${message.notification?.toMap().toString()}');
      String title = message.notification?.title ?? '';
      String body = message.notification?.body ?? '';
      if (title.isNotEmpty && body.isNotEmpty) {
        showNotification(
          title,
          body,
          payload: message.data.toString(),
        );
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((msg) async {
      if (msg.data.containsKey('notification_type')) {

      }
    });
  }


  static void showNotification(String title, String body,
      {String? payload}) async {
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: AndroidNotificationDetails(
        channelId, channelName,
        importance: Importance.max,
        priority: Priority.high,
        icon: 'app_icon',
        playSound: true,
        showWhen: true,
        enableVibration: true,
        channelShowBadge: true,
        visibility: NotificationVisibility.public,
        //sound: RawResourceAndroidNotificationSound('notification'),
        autoCancel: false,
      ),
      iOS: DarwinNotificationDetails(
        presentSound: true,
        presentAlert: true,
        presentBadge: true,
        //sound: 'notification.wav',
      ),
    );
    await localNotificationsPlugin.show(
      Random().nextInt(4),
      title,
      body,
      platformChannelSpecifics,
      payload: payload ?? '',
    );
  }
}
""";
  static final baseController = """
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
export 'package:$name/app_routes/app_routes.dart';
import 'package:$name/services/api_service/api.dart';
import 'package:intl/intl.dart';
"""
  r"""
class AppBaseController extends GetxController {
  bool _isBusy = false;
  final api = Api();


  void showToast({required String msg, Duration? duration}) {
    Get.showSnackbar(
      GetSnackBar(
        message: msg,
        duration: duration ??
            const Duration(
              seconds: 2,
            ),
      ),
    );
  }

  void exitFromApp() {
    try {
      if (Platform.isAndroid) {
        SystemNavigator.pop();
      } else if (Platform.isIOS) {
        exit(0);
      }
    } catch (e) {
      exitFromApp();
    }
  }

  bool get isBusy => _isBusy;

  void setBusy(bool isBusy) {
    _isBusy = isBusy;
    update();
  }


  String formatDate(String date, String format, String expectFormat,
      {bool? isUtc}) {
    if (date.isEmpty || date.toLowerCase() == 'null') return 'N/A';
    DateTime parse = DateFormat(format).parse(date, isUtc ?? false);
    return DateFormat(expectFormat).format(parse.toLocal());
  }

  String durationToTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
""";
  static const appCachedNetworkImage = r"""
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppCachedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit? fit;
  final double? width, height, radius;
  final Widget? errorWidget;

  const AppCachedNetworkImage({
    Key? key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.radius,
    this.errorWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 0),
      ),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: fit,
        width: width,
        height: height,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            ImageProgressIndicator(
          progress: downloadProgress.progress,
        ),
        errorWidget: (context, url, error) => errorWidget ?? const Icon(Icons.error),
      ),
    );
  }
}

class ImageProgressIndicator extends StatelessWidget {
  final double? progress;

  const ImageProgressIndicator({Key? key, this.progress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 24,
        height: 24,
        child:CircularProgressIndicator(),
      ),
    );
  }
}
""";
  static const translationService = r"""
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'lang_strings_files/en_us.dart';
import 'lang_strings_files/tr_tr.dart';

class TranslationService extends GetxService {
  final translations = <String, Map<String, String>>{}.obs;
  static List<String> languages = ['en'];

  List<Locale> supportedLocales() {
    return TranslationService.languages.map((locale) {
      return fromStringToLocale(locale);
    }).toList();
  }

  Future<TranslationService> init() async {
    await loadTranslation();
    return this;
  }

  Future<void> loadTranslation({String? langCode}) async {
    langCode = langCode ?? getLocale().languageCode;
    Map<String, String> translations = langCode == 'tr' ? trTR : enUS;
    Get.addTranslations({langCode: translations});
    return;
  }

  Locale getLocale() =>fromStringToLocale(Get.deviceLocale?.languageCode ?? 'en');
  

  // Convert string code to local object
  Locale fromStringToLocale(String locale) {
    if (locale.contains('_')) {
      // en_US
      return Locale(locale.split('_').elementAt(0), locale.split('_').elementAt(1));
    } else {
      // en
      return Locale(locale);
    }
  }
}
""";
  static const enUs = r"""
//English string
import 'lang_keys.dart';

const Map<String, String> enUS = {
  /// store string start from here
  LangKeys.fightFoodWastageAndNever:
      "Fight food wastage, and never let food go waste.",
}; 
""";
  static const trTr = r""" 
//Turkey string
import 'lang_keys.dart';

const Map<String, String> trTR = {
  LangKeys.fightFoodWastageAndNever:
      "Yiyecek israfıyla savaş ve israfa son ver.",
  };
""";
  static const langKeys = r""" 
class LangKeys {
  static const String fightFoodWastageAndNever = "Fight food wastage, and never let food go waste.";
  //link text
  static const String bySharingTheLinkAbove =
      "By sharing the link above you accept our <link href="
      "goReferralTermsAndCondition"
      ">referral terms and conditions.</link>";
  static const String byReservingThisMealYou =
      "By reserving this meal you agree to Sepetbox <link href="
      "goTermsAndCondition"
      ">terms & conditions</link>";
  static const String iAgreeWithTheTermsAndConditions =
      "I agree with the <link href="
      "goTermsAndCondition"
      ">terms & conditions</link> and the <link href="
      "goPrivacy"
      ">privacy policy</link>.";
}
""";

  static String main(bool firebase) {
    var res = '';
    if (firebase) {
      res = """
import 'package:firebase_core/firebase_core.dart';
import 'package:$name/services/firebase_service.dart';\n""";
    }
    res = """${res}import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:$name/services/app_services/translation_service/translation_service.dart';
import 'package:$name/app_routes/app_pages.dart';
import 'package:$name/services/network_service/network_service.dart';
import 'package:$name/utils/app_constants.dart';


void main() async{
  await GetStorage.init();
  Get.put(NetworkService());
  await Get.putAsync(() => TranslationService().init());
  WidgetsFlutterBinding.ensureInitialized();\n
  """;
    if (firebase) {
      res = """${res}await Firebase.initializeApp();
  await FBNotification().init();\n""";
    }
    res = """$res  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: appName,
      getPages: AppPages.routes,
      initialRoute: AppPages.initial,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: Get.find<TranslationService>().supportedLocales(),
      translationsKeys: Get.find<TranslationService>().translations,
      locale: Get.find<TranslationService>().getLocale(),
      fallbackLocale: Get.find<TranslationService>().getLocale(),
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.cupertino,
      // theme: ThemeData(
      // ),
    );
  }
}
""";
    return res;
  }
}