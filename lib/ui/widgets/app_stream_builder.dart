import 'package:flutter/material.dart';

class AppStreamBuilder<T> extends StatelessWidget {
  final Stream<T> stream;
  final Widget Function(T data) onData;
  final Widget Function(Object error)? onError;
  final Widget Function()? onLoading;

  const AppStreamBuilder({
    Key? key,
    required this.stream,
    required this.onData,
    this.onError,
    this.onLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        if (snapshot.hasData) {
          return onData(snapshot.data!);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildErrorWidget(Object? error) {
    return onError == null
        ? AppStateConnection.error(error: error.toString())
        : onError!(error!);
  }

  Widget _buildLoadingWidget() {
    return onLoading == null ? AppStateConnection.loading() : onLoading!();
  }
}

class AppStateConnection {
  static Widget loading() {
    return const Center(child: CircularProgressIndicator());
  }

  static Widget error({String? error}) {
    final errorMessage = error ?? 'Ha ocurrido un error';
    return Center(child: Text(errorMessage));
  }
}
