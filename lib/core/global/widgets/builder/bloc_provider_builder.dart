import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocProviderBuilder<T extends StateStreamableSource<Object?>>
    extends StatelessWidget {
  const BlocProviderBuilder(
      {required this.create, required this.builder, super.key});

  final T Function(BuildContext context) create;
  final Widget Function(BuildContext context) builder;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: create,
      child: Builder(builder: builder),
    );
  }
}
