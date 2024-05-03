import 'package:shared_preferences/shared_preferences.dart';

abstract class SearchLocalDataSource {}

class SearchLocalDataSourceImpl implements SearchLocalDataSource {
  final SharedPreferences sharedPreferences;

  SearchLocalDataSourceImpl({required this.sharedPreferences});
}
