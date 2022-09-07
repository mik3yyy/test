import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget({Key? key, required this.value, required this.data})
      : super(key: key);
  final AsyncValue<T> value;
  final Widget Function(T) data;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      error: (e, st) => Center(child: ErrorMessageWidget(e.toString())),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

class ErrorMessageWidget extends StatelessWidget {
  const ErrorMessageWidget(this.errorMessage, {Key? key}) : super(key: key);
  final String errorMessage;
  @override
  Widget build(BuildContext context) {
    return Text(
      errorMessage,
      style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.red),
    );
  }
}

/// Sliver equivalent of [AsyncValueWidget]
// class AsyncValueSliverWidget<T> extends StatelessWidget {
//   const AsyncValueSliverWidget(
//       {super.key, required this.value, required this.data});
//   final AsyncValue<T> value;
//   final Widget Function(T) data;

//   @override
//   Widget build(BuildContext context) {
//     return value.when(
//       data: data,
//       loading: () => const SliverToBoxAdapter(
//           child: Center(child: CircularProgressIndicator())),
//       error: (e, st) => SliverToBoxAdapter(
//         child: Center(child: ErrorMessageWidget(e.toString())),
//       ),
//     );
//   }
// }