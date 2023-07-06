import 'dart:convert';
import 'dart:io';

extension StringExtension on String {
  String get pascalCase{
    var temp = '';
    split('_').map((e) => e._pascalHelper).forEach((element) {
      temp = temp + element;
    });
    return temp;
  }

  String get  _pascalHelper {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String get  camelCase {
    var temp = pascalCase;
    return "${temp[0].toLowerCase()}${temp.substring(1)}";
  }
}

extension FileExtension on File{

  Future<File> get _openFile async {
    // var file = File(path);
    if (await exists()) {
      return this;
    } else {
      printSuccess('creating ${path.split('/').last} at $path');
      return await create(recursive: true);
    }
  }
  Future openForWrite(String contents) async{
    final file=await _openFile;
    file.writeAsString(contents, mode: FileMode.write);
    printSuccess('successfully created ${path.split('/').last}');
    return null;
  }

  Future<List<String>> get getContent async => openRead()
      .transform(utf8.decoder) // Decode bytes to UTF-8.
      .transform(LineSplitter())
      .toList();
  void writeContent(List<String> lines)async{
    writeAsString('', mode: FileMode.write);
    for (int i = 0; i < lines.length; i++) {
      await writeAsString('${lines[i]}\n', mode: FileMode.append);
    }
  }
}

void printError(dynamic text) {
  print(' \x1B[31m Error: $text\x1B[0m');
}

void printSuccess(dynamic text) {
  print(' \x1B[32m $text\x1B[0m');
}

String getProjectName()=> Directory.current.path.split('/lib').first.split('/').last;

void main(){
  print("${Directory.current.absolute.path.split('lib/').last}/test_view.dart';");
}
