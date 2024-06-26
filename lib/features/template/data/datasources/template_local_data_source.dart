import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:descolar_front/core/errors/exceptions.dart';
import 'package:descolar_front/features/template/data/models/template_model.dart';

abstract class TemplateLocalDataSource {
  Future<void> cacheTemplate({required TemplateModel? templateToCache});
  Future<TemplateModel> getLastTemplate();
}

const cachedTemplate = 'CACHED_TEMPLATE';

class TemplateLocalDataSourceImpl implements TemplateLocalDataSource {
  final SharedPreferences sharedPreferences;

  TemplateLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<TemplateModel> getLastTemplate() {
    final jsonString = sharedPreferences.getString(cachedTemplate);

    if (jsonString != null) {
      return Future.value(
          TemplateModel.fromJson(json: json.decode(jsonString)),);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheTemplate({required TemplateModel? templateToCache}) async {
    if (templateToCache != null) {
      sharedPreferences.setString(
        cachedTemplate,
        json.encode(
          templateToCache.toJson(),
        ),
      );
    } else {
      throw CacheException();
    }
  }
}
