import 'dart:typed_data';

class ResultInformationModel {

  final String name;
  final bool isWeb;
  final String? path;
  final List<int>? bytes;
  final String? extension;
  final Uint8List? uInt8List ;

  const ResultInformationModel({
    required this.name,
    required this.isWeb,
    this.path,
    this.extension,
    this.bytes,
    this.uInt8List
  });

  ResultInformationModel copyWith({
    String? name,
    bool? isWeb,
    String? path,
    String? extension,
    List<int>? bytes,
    Uint8List? uInt8List,
  }) {
    return ResultInformationModel(
      name: name ?? this.name,
      uInt8List: uInt8List ?? this.uInt8List,
      isWeb: isWeb ?? this.isWeb,
      path: path ?? this.path,
      extension: extension ?? this.extension,
      bytes: bytes ?? this.bytes,
    );
  }
}