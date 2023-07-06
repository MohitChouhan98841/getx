import 'dart:io';
import '../extensions.dart';
import 'create_get.dart';
import 'init_get.dart';
 //Todo command => dart compile exe init_get.dart
void main(List<String>? arguments)async{
 await get(arguments);
}
void get(List<String>? arguments)async{
  if((arguments?.length??0)!=0){
    if (arguments?[0] == 'init') {
      printSuccess('init command will delete lib folder');
      printSuccess('to continue\n enter y...');
      var input = stdin.readLineSync().toString().trim();
      if (input == 'y' || input == 'Y') {
      getInit();
      }
        return;
    } else if ((arguments?[0] ?? '') == 'page') {
      if ((arguments?.length ?? 0) < 2) {
        printError('error page name not found');
        return;
      }
      printSuccess('do you want to create new ${arguments?[1]} page');
      printSuccess('it will automatically add page to AppRoutes and AppPages and create '
          '${arguments?[1]}_view and ${arguments?[1]}_controller file with code snippet');
      printSuccess('to continue\n enter y...');
      var input = stdin.readLineSync().toString().trim();
      if (!input.contains('y')) {
        return;
      }
      getNewScreen(arguments![1]);
      return;
    }
  }
  printSuccess('Run "get page <pageName>" To create new GetX Screen  ');
    printSuccess('it will automatically add page to AppRoutes and AppPages and create '
        '<pageName>_view and <pageName>_controller file with code snippet');
    printSuccess('Run "get init" To setup new GetX project with get structure');

}
