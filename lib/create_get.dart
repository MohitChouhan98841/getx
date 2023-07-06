import 'dart:convert';
import 'dart:io';

import '../extensions.dart';

void main(List<String> arguments) {
  getNewScreen(arguments[0]);
}

void getNewScreen(String pageName) async {
  if (pageName.isEmpty) {
    printError('Please enter file name');
    return;
  }
  String fileName = pageName;
  print(Directory.current.path);
  String newDir(fileName) => "${Directory.current.path}/lib/screen/$fileName";
  String view(fileName) => '${newDir(fileName)}/${fileName}_view.dart';
  String controller(fileName) => '${newDir(fileName)}/${fileName}_controller.dart';

  if (await Directory(newDir(fileName)).exists()) {
    printError('$fileName directory  already exists ');
    return;
  }
  addRoute(fileName);
  (await File(view(fileName)).create(recursive: true))
      .writeAsString(getView(fileName), mode: FileMode.write);
  (await File(controller(fileName)).create(recursive: true))
      .writeAsString(getController(fileName), mode: FileMode.write);
  printSuccess('$fileName create success fully');

  // if(await Directory(newDir('copy')).exists()) {
  //    if(await File(view('copy')).exists()){
  //      File(view('copy')).copy(view(fileName));
  //    }
  //    if(await File(controller('copy')).exists()){
  //      File(controller('copy')).copy(controller(fileName));
  //    }
  // }else{
  //   printError('could not copy base code please run with copy argument');
  // }
}

String getView(String fileName) {
  return """
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '${fileName}_controller.dart';

class ${fileName.pascalCase}View extends StatelessWidget {
  const ${fileName.pascalCase}View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<${fileName.pascalCase}Controller>(
      init: ${fileName.pascalCase}Controller(),
      builder: (controller) => Scaffold(
        body: Container(),
      ),
    );
  }
}
""";
}

String getController(String fileName) {
  return """
import 'package:${Directory.current.path.split('/').last}/screen/base/base_controller.dart';
import 'package:get/get.dart';
class  ${fileName.pascalCase}Controller extends AppBaseController{
  
}
 """;
}

void addRoutePage(String fileName) async {
  var current = Directory.current.path;
  if(current.contains('/lib')){
    current = current.split('/lib').first;
  }
  var routesPath = '$current/lib/app_routes/';
  try {
    List<String> lines = await File('${routesPath}app_pages.dart').getContent;
    for (int i = 0; i < lines.length; i++) {
      if (lines[i].contains('import \'app_routes.dart\';')) {
        lines[i] =
            '${lines[i]}\nimport \'package:${current.split('/').last}/screen/$fileName/${fileName}_view.dart\';';
      }
      if (lines[i].contains('];')) {
        lines[i] = """    GetPage(
        name: AppRoutes.${fileName.camelCase},
        page: () =>const ${fileName.pascalCase}View(),
      ),\n];""";
      }
    }
    File('${routesPath}app_pages.dart').writeContent(lines);
  } catch (e) {
    printError("unable to add page route because $e");
  }
}

void addRoute(String fileName) async {
  var current = Directory.current.path;
  if(current.contains('/lib')){
    current = current.split('/lib').first;
  }
  var routesPath = '$current/lib/app_routes/';
  try {
    var file = File('${routesPath}app_routes.dart');
    List<String> lines = await file
        .openRead()
        .transform(utf8.decoder) // Decode bytes to UTF-8.
        .transform(LineSplitter())
        .toList();
    for (int i = 0; i < lines.length; i++) {
      if (lines[i].contains('}')) {
        // print('write');
        lines[i] = '  static const ${fileName.camelCase} = \'/$fileName\';' '\n}';
      }
    }
    file.writeAsString('', mode: FileMode.write);
    for (int i = 0; i < lines.length; i++) {
      await file.writeAsString('${lines[i]}\n', mode: FileMode.append);
    }
    addRoutePage(fileName);
  } catch (e) {
    printError("unable to add page route because $e");
  }
}
