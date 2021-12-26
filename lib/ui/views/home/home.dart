import 'package:flutter/material.dart';
import 'package:lodgify/ui/base_view.dart';
import 'package:lodgify/ui/resources/app_icons.dart';
import 'package:lodgify/ui/resources/app_strings.dart';
import 'package:lodgify/ui/styles/app_colors.dart';
import 'package:lodgify/ui/styles/app_constants.dart';
import 'package:lodgify/ui/views/home/home_data_model.dart';
import 'package:lodgify/ui/views/home/home_state.dart';
import 'package:lodgify/ui/views/home/home_vm.dart';
import 'package:lodgify/ui/widgets/app_spacer.dart';
import 'package:lodgify/ui/widgets/app_texts.dart';
import 'package:lodgify/ui/widgets/center_loader.dart';
import 'package:lodgify/ui/widgets/error_screen.dart';
import 'package:lodgify/ui/widgets/layout_builder.dart';
import 'package:lodgify/ui/widgets/ripple_button.dart';
import 'package:lodgify/ui/widgets/svg_icon.dart';
import 'package:provider/provider.dart';
part './home_widgets.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BaseView<HomeVM>(
          builder: (context, model, _) => _Layout(
            Builder(builder: (context) {
              if (model.state == HomeState.loading) {
                return const _Loading();
              }

              if (model.state == HomeState.error) {
                return const _Error();
              }

              if (model.state == HomeState.success) {
                return const _Success();
              }

              if (model.state == HomeState.empty) {
                return const _Empty();
              }

              return const SizedBox();
            }),
          ),
        ),
      ),
    );
  }
}

class _Success extends StatelessWidget {
  const _Success({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: const [
        _Title(),
        _ProgressBarOptimizationWrapper(),
        AppSpacers.v30,
        _ListGroups(),
        AppSpacers.v20,
      ],
    );
  }
}

class _Error extends StatelessWidget {
  const _Error({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: const [
        _Title(),
        _ProgressBarBackground(),
        AppSpacers.v30,
        _ErrorBody(),
        AppSpacers.v20,
      ],
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: const [
        _Title(),
        _ProgressBarBackground(),
        AppSpacers.v30,
        _BoxWrapper(paddingV: 24, child: CenterLoader()),
        AppSpacers.v20,
      ],
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: const [
        _Title(),
        _ProgressBarBackground(),
        AppSpacers.v30,
        _BoxWrapper(
          paddingV: 24,
          child: AppText.h1(AppStrings.homeNoGruopTasks),
        ),
        AppSpacers.v20,
      ],
    );
  }
}
