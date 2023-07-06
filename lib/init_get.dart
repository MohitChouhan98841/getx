import 'dart:convert';
import 'dart:io';
import '../extensions.dart';
import 'create_get.dart';
part 'file_content.dart';
main() {
  getInit();
}

Future flutterPubAdd(String package) async {
  printSuccess('getting package $package');
  try {
    var s = await Process.run('flutter', ["pub", "add", package], runInShell:
    true,);
    print(s.stderr);
    printSuccess(s.stdout);
    return s;
  }
  catch (e) {
    printError('error $e');
  }
}

class FileName {
  ///main
  static final main = File('lib/main.dart');

  ///app routes
  static final appRoutes = File('lib/app_routes/app_routes.dart');
  static final appPages = File('lib/app_routes/app_pages.dart');

  ///screen
  static final baseCtr = File('lib/screen/base/base_controller.dart');
  static final textStyle = File('lib/screen/extension/text_style.dart');
  static final appCachedNetworkImage = File('lib/screen/shared/app_cached_network_image.dart');
  static final appTextButton = File('lib/screen/shared/app_text_button.dart');

  ///services
  //api_service
  static final api = File('lib/services/api_service/api.dart');
  static final apiClient = File('lib/services/api_service/api_client.dart');
  static final apiMethods = File('lib/services/api_service/api_methods.dart');
  static final commonResp = File('lib/services/api_service/resp_bin/common_resp.dart');

  //app_services
  static final translationService = File('lib/services/app_services/translation_service'
      '/translation_service.dart'

  );

  static final enUs = File('lib/services/app_services/translation_service/lang_strings_files/en_us'
      '.dart');
  static final trTr = File('lib/services/app_services/translation_service/lang_strings_files/tr_tr'
      '.dart');
  static final langKeys = File('lib/services/app_services/translation_service/lang_strings_files'
      '/lang_keys.dart'
  );

  //network_service
  static final networkService = File('lib/services/network_service/network_service.dart');
  static final firebase = File('lib/services/firebase_service.dart');

  ///utils
  static final appColors = File('lib/utils/app_colors.dart');
  static final appConstants = File('lib/utils/app_constants.dart');
  static final assetsConstants = File('lib/utils/assets_constants.dart');
  static final sharedPre = File('lib/utils/shared_pre.dart');
}
// class FileName{
//   ///main
//   static final main=File('lib/main.dart');
//   ///app routes
//   static const appRoutes='lib/app_routes/app_routes.dart';
//   static const appPages='lib/app_routes/app_pages.dart';
//   ///screen
//   static const baseCtr='lib/screen/base/base_controller.dart';
//   static const textStyle='lib/screen/extension/text_style.dart';
//   static const appCachedNetworkImage='lib/screen/shared/app_cached_network_image.dart';
//   static const appTextButton='lib/screen/shared/app_text_button.dart';
//   ///services
//   //api_service
//   static const api='lib/services/api_service/api.dart';
//   static const apiClient='lib/services/api_service/api_client.dart';
//   static const apiMethods='lib/services/api_service/api_methods.dart';
//   static const commonResp='lib/services/api_service/resp_bin/common_resp.dart';
//   //app_services
//   static const translationService='lib/services/app_services/translation_service/translation_service.dart';
//   static const enUs='lib/services/app_services/translation_service/lang_strings_files/en_us.dart';
//   static const trTr='lib/services/app_services/translation_service/lang_strings_files/tr_tr.dart';
//   static const langKeys='lib/services/app_services/translation_service/lang_strings_files/lang_keys.dart';
//   //network_service
//   static const networkService='lib/services/network_service/network_service.dart';
//   static const firebase='lib/services/firebase_service.dart';
//   ///utils
//   static const appColors='lib/utils/app_colors.dart';
//   static const appConstants='lib/utils/app_constants.dart';
//   static const assetsConstants='lib/utils/assets_constants.dart';
//   static const sharedPre='lib/utils/shared_pre.dart';
// }
void getInit() async {
  bool? useFirebaseNotification;
  while (useFirebaseNotification == null) {
    printSuccess('Do yo want to use FireBase Notification in your project Y/N');
    var input = stdin.readLineSync().toString().trim();
    if (input == 'y' || input == 'Y') {
      useFirebaseNotification = true;
    } else if (input == 'n' || input == 'N') {
      useFirebaseNotification = false;
    } else {
      printError('Please enter Y(yes) or N(no) in console to continue Get setup');
    }
  }
  printSuccess('adding packages');
  await flutterPubAdd('get');
  await flutterPubAdd('get_storage');
  await flutterPubAdd('cached_network_image');
  await flutterPubAdd('connectivity_plus');
  await flutterPubAdd('intl');
  if (useFirebaseNotification) {
    await flutterPubAdd('firebase_auth');
    await flutterPubAdd('firebase_core');
    await flutterPubAdd('firebase_messaging');
    await flutterPubAdd('flutter_local_notifications');
  }

  ///assets
  await Directory("assets").create(recursive: true);

  ///add flutter_localizations and assets in pubspec
  addToPubspec();

  ///creating files
  await FileName.main.openForWrite(DataStrings.main(useFirebaseNotification),);
  await  FileName.textStyle.openForWrite(DataStrings.textStyle,);
  await  FileName.baseCtr.openForWrite(DataStrings.baseController,);
  await FileName.appCachedNetworkImage.openForWrite(DataStrings.appCachedNetworkImage, );
  await FileName.appTextButton.openForWrite(DataStrings.appTextButton, );
  await Directory("lib/model").create(recursive: true);
  await FileName.appRoutes.openForWrite(DataStrings.appRoutes, );
  await  FileName.appPages.openForWrite(DataStrings.appPages,);
  await FileName.translationService.openForWrite(DataStrings.translationService, );
  await FileName.enUs.openForWrite(DataStrings.enUs, );
  await FileName.trTr.openForWrite(DataStrings.trTr, );
  await  FileName.langKeys.openForWrite(DataStrings.langKeys,);
  await  FileName.networkService.openForWrite(DataStrings.networkService,);
  if (useFirebaseNotification) {
    ///Firebase Notification
    await FileName.firebase.openForWrite(DataStrings.firebase, );
  }

  ///Api service
  await FileName.api.openForWrite(DataStrings.api, );
  await FileName.apiClient.openForWrite(DataStrings.apiClient, );
  await FileName.apiMethods.openForWrite(DataStrings.apiMethod, );
  await FileName.commonResp.openForWrite(DataStrings.commonResp, );

  ///Utils
  await FileName.appColors.openForWrite(DataStrings.appColors, );
  await FileName.appConstants.openForWrite(DataStrings.appConstants, );
  await FileName.assetsConstants.openForWrite(DataStrings.assetsConstant, );
  await FileName.sharedPre.openForWrite(DataStrings.sharePre, );


  try {
    getNewScreen('splash');
  } catch (e) {
    printError('error on creating splash $e');
  }
  Process.run(
    'flutter',
    ["pub", "get"],
  );
}

void addToPubspec() async {
  try {
    var file = File('pubspec.yaml');
    List<String> lines = await file.getContent;
    for (int i = 0; i < lines.length; i++) {
      if (lines[i].contains('# assets:')) {
        lines[i] = """
  assets:
    - assets/""";
      } else if (lines[i] == 'dependencies:' && lines[i + 1].trim() != 'flutter_localizations:') {
        lines[i] = """
dependencies:
  flutter_localizations:
    sdk: flutter""";
      }
    }
    file.writeContent(lines);
  } catch (e) {
    printError("unable to add assets $e");
  }
}


