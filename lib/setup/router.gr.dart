// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i2;
import 'package:fin_del_mundo_management/ui/pages/daily_income_page.dart'
    as _i1;

abstract class $AppRouter extends _i2.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i2.PageFactory> pagesMap = {
    DailyIncomeRoute.name: (routeData) {
      return _i2.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.DailyIncomePage(),
      );
    }
  };
}

/// generated route for
/// [_i1.DailyIncomePage]
class DailyIncomeRoute extends _i2.PageRouteInfo<void> {
  const DailyIncomeRoute({List<_i2.PageRouteInfo>? children})
      : super(
          DailyIncomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'DailyIncomeRoute';

  static const _i2.PageInfo<void> page = _i2.PageInfo<void>(name);
}
