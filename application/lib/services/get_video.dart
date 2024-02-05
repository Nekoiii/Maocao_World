import '../config/app_config.dart';

class GetVideo {
  static Uri getVideoUri() {
    return Uri.parse('${AppConfig.flaskServerUrl}/get_video');
  }
}
