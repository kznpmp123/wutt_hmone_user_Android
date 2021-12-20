import 'package:dio/dio.dart' as dio;
import 'package:kozarni_ecome/data/constant.dart';

class Api {
  final dio.Dio _dio = dio.Dio();

  Future<void> uploadFile(
    String filePath, {
    String folder = 'items/',
    String? fileName,
  }) async {
    final dio.MultipartFile _file = await dio.MultipartFile.fromFile(
      filePath,
      filename: fileName,
    );
    try {
      await _dio.post(
        "$baseUrl$folder",
        data: dio.FormData.fromMap(
          {
            'file': _file,
          },
        ),
      );
    } catch (e) {
      print("file upload error is $e");
    }
  }
}
