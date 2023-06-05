// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:fin_del_mundo_management/modules/income/income.dart' as _i7;
import 'package:fin_del_mundo_management/modules/income/pages/income_form_page.dart'
    as _i3;
import 'package:fin_del_mundo_management/modules/income/pages/income_page.dart'
    as _i2;
import 'package:fin_del_mundo_management/modules/payment/pages/payment_form_page.dart'
    as _i4;
import 'package:fin_del_mundo_management/modules/payment/pages/payment_page.dart'
    as _i1;
import 'package:fin_del_mundo_management/modules/payment/payment.dart' as _i8;
import 'package:flutter/material.dart' as _i6;

abstract class $AppRouter extends _i5.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    PaymentRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.PaymentPage(),
      );
    },
    IncomeRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.IncomePage(),
      );
    },
    IncomeFormRoute.name: (routeData) {
      final args = routeData.argsAs<IncomeFormRouteArgs>(
          orElse: () => const IncomeFormRouteArgs());
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.IncomeFormPage(
          key: args.key,
          income: args.income,
        ),
      );
    },
    PaymentFormRoute.name: (routeData) {
      final args = routeData.argsAs<PaymentFormRouteArgs>(
          orElse: () => const PaymentFormRouteArgs());
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.PaymentFormPage(
          key: args.key,
          payment: args.payment,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.PaymentPage]
class PaymentRoute extends _i5.PageRouteInfo<void> {
  const PaymentRoute({List<_i5.PageRouteInfo>? children})
      : super(
          PaymentRoute.name,
          initialChildren: children,
        );

  static const String name = 'PaymentRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i2.IncomePage]
class IncomeRoute extends _i5.PageRouteInfo<void> {
  const IncomeRoute({List<_i5.PageRouteInfo>? children})
      : super(
          IncomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'IncomeRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i3.IncomeFormPage]
class IncomeFormRoute extends _i5.PageRouteInfo<IncomeFormRouteArgs> {
  IncomeFormRoute({
    _i6.Key? key,
    _i7.Income? income,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          IncomeFormRoute.name,
          args: IncomeFormRouteArgs(
            key: key,
            income: income,
          ),
          initialChildren: children,
        );

  static const String name = 'IncomeFormRoute';

  static const _i5.PageInfo<IncomeFormRouteArgs> page =
      _i5.PageInfo<IncomeFormRouteArgs>(name);
}

class IncomeFormRouteArgs {
  const IncomeFormRouteArgs({
    this.key,
    this.income,
  });

  final _i6.Key? key;

  final _i7.Income? income;

  @override
  String toString() {
    return 'IncomeFormRouteArgs{key: $key, income: $income}';
  }
}

/// generated route for
/// [_i4.PaymentFormPage]
class PaymentFormRoute extends _i5.PageRouteInfo<PaymentFormRouteArgs> {
  PaymentFormRoute({
    _i6.Key? key,
    _i8.Payment? payment,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          PaymentFormRoute.name,
          args: PaymentFormRouteArgs(
            key: key,
            payment: payment,
          ),
          initialChildren: children,
        );

  static const String name = 'PaymentFormRoute';

  static const _i5.PageInfo<PaymentFormRouteArgs> page =
      _i5.PageInfo<PaymentFormRouteArgs>(name);
}

class PaymentFormRouteArgs {
  const PaymentFormRouteArgs({
    this.key,
    this.payment,
  });

  final _i6.Key? key;

  final _i8.Payment? payment;

  @override
  String toString() {
    return 'PaymentFormRouteArgs{key: $key, payment: $payment}';
  }
}
