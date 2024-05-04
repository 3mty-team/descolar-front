import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';

class FileUtils {

  static String getFileName(String path) {
    return basename(path);
  }

  static MediaType getMediaType(String type, String path) {
    return MediaType(type, extension(path).substring(1));
  }

}
