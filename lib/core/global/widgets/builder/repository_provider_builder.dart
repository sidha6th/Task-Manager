import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RepositoryProviderBuilder<T> extends StatelessWidget {
  const RepositoryProviderBuilder(
      {required this.create, required this.builder, super.key});

  final T Function(BuildContext context) create;
  final Widget Function(BuildContext context) builder;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: create,
      child: Builder(builder: builder),
    );
  }
}
