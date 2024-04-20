import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../models/result_information_model.dart';

class FilePickerService {
  Future<ResultInformationModel?> getFile(
      {List<String>? allowedExtensions,int? maximumSize}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: allowedExtensions == null || allowedExtensions.isEmpty
            ? FileType.any
            : FileType.custom,
        allowedExtensions: allowedExtensions,
        dialogTitle: "Choose File",
        allowMultiple: true);
    if (result != null) {
      PlatformFile file = result.files.single;
      if(maximumSize != null) {
        int size = file.size ;
        if(size > maximumSize * 1024 * 1024) {
          print("The file size exceeds the limit");
          return null ;
        }
      }
      ResultInformationModel information = ResultInformationModel(name: file.name, isWeb: kIsWeb, extension: file.extension);
      if (information.isWeb) {
        information = information.copyWith(bytes: file.bytes!.map((e) => e.toInt()).toList(),uInt8List: file.bytes);
      } else {
        information = information.copyWith(path: file.path);
      }
      return information;
    }
    return null;
  }

  Future<ResultInformationModel?> getImage(
      {List<String>? allowedExtensions}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        dialogTitle: "Choose Image",
        allowedExtensions: allowedExtensions,
        allowMultiple: false);
    if (result != null) {
      PlatformFile file = result.files.single;
      ResultInformationModel information = ResultInformationModel(name: file.name, isWeb: kIsWeb , extension: file.extension);
      if (information.isWeb) {
        information = information.copyWith(bytes: file.bytes!.map((e) => e.toInt()).toList());
      } else {
        information = information.copyWith(path: file.path);
      }
      return information;
    }
    return null;
  }

  Future<List<ResultInformationModel>?> getFiles(
      {List<String>? allowedExtensions}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: allowedExtensions == null || allowedExtensions.isEmpty
            ? FileType.any
            : FileType.custom,
        allowedExtensions: allowedExtensions,
        allowMultiple: true);
    if (result != null) {
      List<PlatformFile> files = result.files.toList();
      List<ResultInformationModel> outputs = files.map((file) {
        ResultInformationModel information =
            ResultInformationModel(name: file.name, isWeb: kIsWeb);
        if (information.isWeb) {
          information = information.copyWith(
              bytes: file.bytes!.map((e) => e.toInt()).toList());
        } else {
          information = information.copyWith(path: file.path);
        }
        return information;
      }).toList();
      return outputs;
    }
    return null;
  }
}

