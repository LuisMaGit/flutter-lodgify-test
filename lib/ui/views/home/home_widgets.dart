part of './home.dart';

const _paddingHorizontalHeader = 16.0;
const _progressBarH = 24.0;
const _progressBarBorderR = 16.0;

//Layout
class _Layout extends StatelessWidget {
  final Widget child;
  const _Layout(
    this.child, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      mobile: _WrapperMobile(child),
      desktop: _WrapperDesktop(child),
    );
  }
}

class _WrapperDesktop extends StatelessWidget {
  final Widget child;
  const _WrapperDesktop(this.child, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onBackground,
      ),
      child: Align(
        alignment: const Alignment(.0, -.5),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          constraints: const BoxConstraints(maxWidth: 720),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kBorderCards),
              color: Theme.of(context).colorScheme.background,
              border: Border.all(
                color: Theme.of(context).colorScheme.onSurface,
              )),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: child,
        ),
      ),
    );
  }
}

class _WrapperMobile extends StatelessWidget {
  final double factor;
  final Widget child;
  const _WrapperMobile(this.child, {Key? key, this.factor = .9})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FractionallySizedBox(
        widthFactor: factor,
        child: Align(
          alignment: Alignment.topCenter,
          child: child,
        ),
      ),
    );
  }
}

//Header
class _ProgressBarOptimizationWrapper extends StatelessWidget {
  const _ProgressBarOptimizationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HomeVM>(context);
    return _ProgressBar(
      percent: model.progressBar,
      onFinishAnimation: model.fixProgressBar,
      notAnimateAtFirts: model.progresBarActive,
    );
  }
}

class _ProgressBar extends StatefulWidget {
  final int percent;
  final double height;
  final double borderRadius;
  final double barMinW;
  final double horizontalPadding;
  final VoidCallback? onFinishAnimation;
  final bool notAnimateAtFirts;
  const _ProgressBar({
    Key? key,
    required this.percent,
    this.height = _progressBarH,
    this.borderRadius = _progressBarBorderR,
    this.barMinW = 46,
    this.horizontalPadding = _paddingHorizontalHeader,
    this.onFinishAnimation,
    this.notAnimateAtFirts = false,
  })  : assert(percent >= 0 && percent <= 100),
        super(key: key);

  @override
  State<_ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<_ProgressBar> {
  bool waitToAnimate = false;

  @override
  void initState() {
    startAnimation();
    super.initState();
  }

  void startAnimation() async {
    if (!widget.notAnimateAtFirts) {
      await Future.delayed(const Duration(milliseconds: 300));
    }

    setState(() {
      waitToAnimate = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final barW = constraints.maxWidth * widget.percent / 100;
        final showSmallPercent = barW <= widget.barMinW;
        final percentStr = (widget.percent).toString() + '%';

        return _PaddingHeader(
          child: Stack(
            children: [
              //Background
              const _ProgressBarBackground(),
              //Progress
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                height: widget.height,
                width: waitToAnimate ? barW : 0,
                alignment: Alignment.centerRight,
                onEnd: widget.onFinishAnimation,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 100),
                    child: showSmallPercent
                        ? const SizedBox()
                        : AppText.b1(
                            percentStr,
                            color: AppColors.achromaticWhite,
                            fontWeight: FontWeight.bold,
                            maxLines: 1,
                          ),
                  ),
                ),
              ),
              //Low percent text
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 100),
                child: showSmallPercent
                    ? Padding(
                        padding: EdgeInsets.only(left: barW + 10),
                        child: AppText.b1(percentStr,
                            color: AppColors.successSemidark,
                            fontWeight: FontWeight.bold))
                    : const SizedBox(),
              )
            ],
          ),
        );
      },
    );
  }
}

class _ProgressBarBackground extends StatelessWidget {
  final double height;
  final double borderRadius;
  const _ProgressBarBackground({
    Key? key,
    this.height = _progressBarH,
    this.borderRadius = _progressBarBorderR,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(borderRadius)),
    );
  }
}

class _PaddingHeader extends StatelessWidget {
  final double paddingH;
  final double paddingV;
  final Widget child;
  const _PaddingHeader({
    Key? key,
    this.paddingH = _paddingHorizontalHeader,
    this.paddingV = 0,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: paddingH,
        vertical: paddingV,
      ),
      child: child,
    );
  }
}

class _Title extends StatelessWidget {
  final double top;
  final double bottom;
  final double horizontal;
  const _Title({
    Key? key,
    this.top = 40,
    this.bottom = 10,
    this.horizontal = _paddingHorizontalHeader,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: top,
        right: horizontal,
        left: horizontal,
        bottom: bottom,
      ),
      child: const AppText.h1(AppStrings.homeTitle),
    );
  }
}

//Box
class _BoxWrapper extends StatelessWidget {
  final double paddingV;
  final double paddingH;
  final Widget child;
  const _BoxWrapper({
    Key? key,
    this.paddingV = 14,
    this.paddingH = _paddingHorizontalHeader,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kBorderCards),
          border: Border.all(
            color: Theme.of(context).colorScheme.onSurface,
          )),
      child: _PaddingHeader(
        paddingV: paddingV,
        paddingH: paddingH,
        child: child,
      ),
    );
  }
}

class _ListGroups extends StatelessWidget {
  const _ListGroups({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HomeVM>(context);
    return Flexible(
        child: _BoxWrapper(
      paddingH: 0,
      paddingV: 0,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (context, _) {
          return Divider(
            color: Theme.of(context).colorScheme.onSecondary,
            height: 0,
            thickness: 1,
          );
        },
        itemCount: model.groups.length,
        itemBuilder: (context, idx) {
          return _DropSection(
            idx: idx,
            group: model.groups[idx],
            onTap: model.toggleGroup,
            onTapTask: model.toggleTask,
          );
        },
      ),
    ));
  }
}

class _DropSection extends StatefulWidget {
  final int idx;
  final GroupsHomeModel group;
  final void Function(int idx) onTap;
  final void Function(int groupIdx, int taskIdx) onTapTask;
  const _DropSection({
    Key? key,
    required this.idx,
    required this.group,
    required this.onTap,
    required this.onTapTask,
  }) : super(key: key);

  @override
  State<_DropSection> createState() => _DropSectionState();
}

class _DropSectionState extends State<_DropSection>
    with TickerProviderStateMixin {
  late final bool startAnimationDropped;
  //Arrow animation
  late final AnimationController _controllerArrow;
  late final Animation<double> _animationArrow;
  final arrowDown = .5;
  final arrowUp = .0;

  //Panel drop animation
  late final AnimationController _controllerDrop;
  late final Animation<double> _animationDrop;
  final panelClose = .0;
  final panelOpen = 1.0;

  @override
  void initState() {
    _controllerArrow = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _controllerDrop = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    final curvedAnimArrow = CurvedAnimation(
      parent: _controllerArrow,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn,
    );

    final curvedAnimDrop = CurvedAnimation(
      parent: _controllerArrow,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn,
    );

    startAnimationDropped = widget.group.droped;
    final startRotation = startAnimationDropped ? arrowDown : arrowUp;
    final endRotation = startAnimationDropped ? arrowUp : arrowDown;
    final startDrop = startAnimationDropped ? panelOpen : panelClose;
    final endDrop = startAnimationDropped ? panelClose : panelOpen;

    _animationArrow =
        Tween(begin: startRotation, end: endRotation).animate(curvedAnimArrow);
    _animationDrop =
        Tween(begin: startDrop, end: endDrop).animate(curvedAnimDrop);

    super.initState();
  }

  @override
  void dispose() {
    _controllerArrow.dispose();
    _controllerDrop.dispose();
    super.dispose();
  }

  void fowardAnimation([bool foward = true]) {
    if (foward) {
      _controllerDrop.forward();
      _controllerArrow.forward();
      return;
    }

    _controllerDrop.reverse();
    _controllerArrow.reverse();
  }

  void toggle(int idx) {
    if (_controllerArrow.isAnimating || _controllerDrop.isAnimating) return;

    if (widget.group.droped) {
      fowardAnimation(startAnimationDropped);
    } else {
      fowardAnimation(!startAnimationDropped);
    }
    widget.onTap(idx);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ButtonDrop(
          idx: widget.idx,
          groupName: widget.group.name,
          activeGroup: widget.group.allChecked,
          groupEmpty: widget.group.anyTask,
          onTap: toggle,
          show: widget.group.droped,
          animationArrow: _animationArrow,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SizeTransition(
            sizeFactor: _animationDrop,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                    List<_Task>.generate(widget.group.tasks.length, (taskIdx) {
                  final task = widget.group.tasks[taskIdx];
                  return _Task(
                    groupIdx: widget.idx,
                    taskIdx: taskIdx,
                    text: task.description,
                    onTap: widget.onTapTask,
                    active: task.checked,
                    noText: task.noDescription,
                  );
                })),
          ),
        )
      ],
    );
  }
}

class _ButtonDrop extends StatelessWidget {
  final int idx;
  final String groupName;
  final bool activeGroup;
  final bool show;
  final bool groupEmpty;
  final Animation<double> animationArrow;
  final void Function(int idx) onTap;
  const _ButtonDrop({
    Key? key,
    required this.idx,
    required this.activeGroup,
    required this.show,
    required this.groupName,
    required this.onTap,
    required this.animationArrow,
    required this.groupEmpty,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: _paddingHorizontalHeader,
      ),
      child: RippleButton(
        onTap: () => onTap(idx),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 7,
              child: _GroupLabel(
                idx: idx,
                text: groupName,
                active: activeGroup,
              ),
            ),
            groupEmpty
                ? const SizedBox()
                : Expanded(
                    flex: 3,
                    child: _DropIndicator(
                      idx: idx,
                      active: show,
                      animation: animationArrow,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class _GroupLabel extends StatelessWidget {
  final int idx;
  final String text;
  final bool active;
  const _GroupLabel({
    Key? key,
    required this.text,
    required this.idx,
    this.active = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgIcon(
          active ? AppIcons.groupSelected : AppIcons.group,
        ),
        AppSpacers.h10,
        Flexible(
          child: AppText.h2(
            text,
            color: active
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.secondaryVariant,
          ),
        )
      ],
    );
  }
}

class _DropIndicator extends StatelessWidget {
  final int idx;
  final bool active;
  final Animation<double> animation;
  const _DropIndicator({
    Key? key,
    required this.idx,
    required this.animation,
    this.active = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: AppText.b2(
            active ? AppStrings.homeDropHide : AppStrings.homeDropShow,
            color: Theme.of(context).colorScheme.surface,
            maxLines: 1,
          ),
        ),
        AppSpacers.h5,
        Flexible(
          child: RotationTransition(
            turns: animation,
            child: const SvgIcon(
              AppIcons.arrowDrop,
              size: 12,
            ),
          ),
        ),
      ],
    );
  }
}

class _Task extends StatelessWidget {
  final int groupIdx;
  final int taskIdx;
  final bool active;
  final String text;
  final bool noText;
  final void Function(int groupIdx, int taskIdx) onTap;

  const _Task({
    Key? key,
    required this.active,
    required this.text,
    required this.groupIdx,
    required this.taskIdx,
    required this.onTap,
    required this.noText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: RippleButton(
        onTap: () => onTap(groupIdx, taskIdx),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              child: active
                  ? const SvgIcon(AppIcons.checkTrue)
                  : const SvgIcon(AppIcons.checkFalse),
            ),
            AppSpacers.h10,
            Flexible(
              child: noText
                  ? const AppText.b2(AppStrings.homeTaskNoDescription,
                      maxLines: 1)
                  : AppText.b1(
                      text,
                      fontSize: 16,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

//Error
class _ErrorBody extends StatelessWidget {
  const _ErrorBody({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HomeVM>(context);
    return _BoxWrapper(
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: ErrorScreen(tryAgain: model.tryAgain)),
    );
  }
}
