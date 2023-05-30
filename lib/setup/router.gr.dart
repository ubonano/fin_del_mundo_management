// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:fin_del_mundo_management/modules/income/income.dart' as _i5;
import 'package:fin_del_mundo_management/modules/income/pages/income_form_page/income_form_page.dart'
    as _i1;
import 'package:fin_del_mundo_management/modules/income/pages/income_page/income_page.dart'
    as _i2;
import 'package:flutter/material.dart' as _i4;

abstract class $AppRouter extends _i3.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    DailyIncomeFormRoute.name: (routeData) {
      final args = routeData.argsAs<DailyIncomeFormRouteArgs>(
          orElse: () => const DailyIncomeFormRouteArgs());
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.IncomeFormPage(
          key: args.key,
          income: args.income,
        ),
      );
    },
    DailyIncomeRoute.name: (routeData) {
      final args = routeData.argsAs<DailyIncomeRouteArgs>(
          orElse: () => const DailyIncomeRouteArgs());
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.IncomePage(key: args.key),
      );
    },
  };
}

/// generated route for
/// [_i1.IncomeFormPage]
class DailyIncomeFormRoute extends _i3.PageRouteInfo<DailyIncomeFormRouteArgs> {
  DailyIncomeFormRoute({
    _i4.Key? key,
    _i5.Income? income,
    List<_i3.PageRouteInfo>? children,
  }) : super(
          DailyIncomeFormRoute.name,
          args: DailyIncomeFormRouteArgs(
            key: key,
            income: income,
          ),
          initialChildren: children,
        );

  static const String name = 'DailyIncomeFormRoute';

  static const _i3.PageInfo<DailyIncomeFormRouteArgs> page =
      _i3.PageInfo<DailyIncomeFormRouteArgs>(name);
}

class DailyIncomeFormRouteArgs {
  const DailyIncomeFormRouteArgs({
    this.key,
    this.income,
  });

  final _i4.Key? key;

  final _i5.Income? income;

  @override
  String toString() {
    return 'DailyIncomeFormRouteArgs{key: $key, income: $income}';
  }
}

/// generated route for
/// [_i2.IncomePage]
class DailyIncomeRoute extends _i3.PageRouteInfo<DailyIncomeRouteArgs> {
  DailyIncomeRoute({
    _i4.Key? key,
    List<_i3.PageRouteInfo>? children,
  }) : super(
          DailyIncomeRoute.name,
          args: DailyIncomeRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'DailyIncomeRoute';

  static const _i3.PageInfo<DailyIncomeRouteArgs> page =
      _i3.PageInfo<DailyIncomeRouteArgs>(name);
}

class DailyIncomeRouteArgs {
  const DailyIncomeRouteArgs({this.key});

  final _i4.Key? key;

  @override
  String toString() {
    return 'DailyIncomeRouteArgs{key: $key}';
  }
}
