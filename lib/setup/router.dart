import 'package:auto_route/auto_route.dart';
import 'package:fin_del_mundo_management/setup/router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: DailyIncomeRoute.page, initial: true),
        AutoRoute(page: DailyIncomeFormRoute.page),
      ];
}
