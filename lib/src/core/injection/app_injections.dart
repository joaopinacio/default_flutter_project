import 'package:default_flutter_project/src/core/constants/enviroment_urls_path.dart';
import 'package:default_flutter_project/src/core/http/http_client.dart';
import 'package:default_flutter_project/src/core/http/http_client_factory.dart';
import 'package:default_flutter_project/src/core/http/config/http_config.dart';
import 'package:default_flutter_project/src/core/services/auth/auth_service.dart';
import 'package:default_flutter_project/src/core/services/auth/auth_service_impl.dart';
import 'package:default_flutter_project/src/core/storage/app_storage.dart';
import 'package:default_flutter_project/src/core/storage/app_storage_impl.dart';
import 'package:flutter/foundation.dart';

import 'config/base_injection.dart';

class AppInjections extends BaseInjection {
  AppInjections()
    : super(
        scopeName: 'App',
        registrations: [
          (i) => i.registerSingletonAsync<AppStorage>(() => AppStorageImpl.create()),
          (i) => i.registerSingleton<IHttpClient>(
            HttpClientFactory.createClient(
              config: HttpConfig(baseUrl: EnviromentUrlsPath.baseUrl),
              enableLogging: kDebugMode,
            ),
          ),
          (i) => i.registerSingletonAsync<IAuthService>(() async {
            final storage = await i.getAsync<AppStorage>();
            return AuthService(storage);
          }),
        ],
      );
}
