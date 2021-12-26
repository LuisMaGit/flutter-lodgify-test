import 'package:flutter/material.dart';
import 'package:lodgify/di/locator.dart';
import 'package:lodgify/ui/base_vm.dart';
import 'package:provider/provider.dart';

class BaseView<T extends BaseVM> extends StatefulWidget {
  final Widget Function(BuildContext context, T viewModel, Widget? child)
      builder;
  final Function(T viewModel)? initViewModel;
  final Function(T viewModel)? disponse;
  final bool disposeVM;
  final Widget? notRebuild;

  const BaseView({
    Key? key,
    required this.builder,
    this.initViewModel,
    this.notRebuild,
    this.disponse,
    this.disposeVM = true,
  }) : super(key: key);

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseVM> extends State<BaseView<T>> {
  T viewModel = locator<T>();

  @override
  void initState() {
    if (widget.initViewModel != null) widget.initViewModel!(viewModel);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.disponse != null) widget.disponse!(viewModel);
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.disposeVM) {
      return ChangeNotifierProvider.value(
        value: viewModel,
        child: Consumer(
          child: widget.notRebuild,
          builder: widget.builder,
        ),
      );
    }

    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer(
        child: widget.notRebuild,
        builder: widget.builder,
      ),
    );
  }
}
