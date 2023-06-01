// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:fin_del_mundo_management/modules/income/income.dart' as _i5;
import 'package:fin_del_mundo_management/modules/income/pages/income_form_page.dart'
    as _i2;
import 'package:fin_del_mundo_management/modules/income/pages/income_page.dart'
    as _i1;
import 'package:flutter/material.dart' as _i4;

abstract class $AppRouter extends _i3.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    IncomeRoute.name: (routeData) {
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.IncomePage(),
      );
    },
    IncomeFormRoute.name: (routeData) {
      final args = routeData.argsAs<IncomeFormRouteArgs>(
          orElse: () => const IncomeFormRouteArgs());
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.IncomeFormPage(
          key: args.key,
          income: args.income,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.IncomePage]
class IncomeRoute extends _i3.PageRouteInfo<void> {
  const IncomeRoute({List<_i3.PageRouteInfo>? children})
      : super(
          IncomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'IncomeRoute';

  static const _i3.PageInfo<void> page = _i3.PageInfo<void>(name);
}

/// generated route for
/// [_i2.IncomeFormPage]
class IncomeFormRoute extends _i3.PageRouteInfo<IncomeFormRouteArgs> {
  IncomeFormRoute({
    _i4.Key? key,
    _i5.Income? income,
    List<_i3.PageRouteInfo>? children,
  }) : super(
          IncomeFormRoute.name,
          args: IncomeFormRouteArgs(
            key: key,
            income: income,
          ),
          initialChildren: children,
        );

  static const String name = 'IncomeFormRoute';

  static const _i3.PageInfo<IncomeFormRouteArgs> page =
      _i3.PageInfo<IncomeFormRouteArgs>(name);
}

class IncomeFormRouteArgs {
  const IncomeFormRouteArgs({
    this.key,
    this.income,
  });

  final _i4.Key? key;

  final _i5.Income? income;

  @override
  String toString() {
    return 'IncomeFormRouteArgs{key: $key, income: $income}';
  }
}
