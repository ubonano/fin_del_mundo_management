// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:fin_del_mundo_management/ui/pages/daily_income/daily_income_form_page.dart'
    as _i1;
import 'package:fin_del_mundo_management/ui/pages/daily_income/daily_income_page.dart'
    as _i2;

abstract class $AppRouter extends _i3.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    DailyIncomeFormRoute.name: (routeData) {
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.DailyIncomeFormPage(),
      );
    },
    DailyIncomeRoute.name: (routeData) {
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.DailyIncomePage(),
      );
    },
  };
}

/// generated route for
/// [_i1.DailyIncomeFormPage]
class DailyIncomeFormRoute extends _i3.PageRouteInfo<void> {
  const DailyIncomeFormRoute({List<_i3.PageRouteInfo>? children})
      : super(
          DailyIncomeFormRoute.name,
          initialChildren: children,
        );

  static const String name = 'DailyIncomeFormRoute';

  static const _i3.PageInfo<void> page = _i3.PageInfo<void>(name);
}

/// generated route for
/// [_i2.DailyIncomePage]
class DailyIncomeRoute extends _i3.PageRouteInfo<void> {
  const DailyIncomeRoute({List<_i3.PageRouteInfo>? children})
      : super(
          DailyIncomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'DailyIncomeRoute';

  static const _i3.PageInfo<void> page = _i3.PageInfo<void>(name);
}
