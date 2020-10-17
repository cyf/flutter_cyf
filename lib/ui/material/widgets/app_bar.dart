import 'package:flutter/material.dart';

class FAppBar extends StatefulWidget {
  final String title;
  final Widget leading;
  final List<Widget> actions;
  final Widget bottom;
  final bool automaticallyImplyLeading;

  const FAppBar({
    Key key,
    this.title,
    this.leading,
    this.actions,
    this.bottom,
    this.automaticallyImplyLeading = true
  }) : super(key: key);

  @override
  _FAppBarState createState() => _FAppBarState();
}

class _FAppBarState extends State<FAppBar> {
  @override
  Widget build(BuildContext context) {
    double horizontal = MediaQuery.of(context).viewPadding.top;
    ThemeData _theme = Theme.of(context);
    AppBarTheme _appBarTheme = AppBarTheme.of(context);
    final ScaffoldState scaffold = Scaffold.of(context, nullOk: true);
    final ModalRoute<dynamic> parentRoute = ModalRoute.of(context);

    final bool hasDrawer = scaffold?.hasDrawer ?? false;
    final bool hasEndDrawer = scaffold?.hasEndDrawer ?? false;
    final bool canPop = parentRoute?.canPop ?? false;
    final bool useCloseButton = parentRoute is PageRoute<dynamic> && parentRoute.fullscreenDialog;

    IconThemeData overallIconTheme = _appBarTheme.iconTheme
        ?? _theme.primaryIconTheme;
    IconThemeData actionsIconTheme = _appBarTheme.actionsIconTheme
        ?? overallIconTheme;
    TextStyle centerStyle =
        _appBarTheme.textTheme?.title ?? _theme.primaryTextTheme.title;

    Widget leading = widget.leading;
    if (leading == null && widget.automaticallyImplyLeading) {
      if (hasDrawer) {
        leading = IconButton(
          icon: const Icon(Icons.menu),
          onPressed: _handleDrawerButton,
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        );
      } else {
        if (canPop)
          leading = useCloseButton ? const CloseButton() : const BackButton();
      }
    }
    if (leading != null) {
      leading = ConstrainedBox(
        constraints: const BoxConstraints.tightFor(width: kToolbarHeight),
        child: leading,
      );
    }

    Widget actions;
    if (widget.actions != null && widget.actions.isNotEmpty) {
      actions = Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: widget.actions,
      );
    } else if (hasEndDrawer) {
      actions = IconButton(
        icon: const Icon(Icons.menu),
        onPressed: _handleDrawerButtonEnd,
        tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      );
    }

    // Allow the trailing actions to have their own theme if necessary.
    if (actions != null) {
      actions = IconTheme.merge(
        data: actionsIconTheme,
        child: actions,
      );
    }
    return Container(
      padding: EdgeInsets.only(top: horizontal),
      color: Colors.blue,
      child: Column(
        children: <Widget>[
          Container(
            height: 56,
            child: NavigationToolbar(
              leading: leading,
              middle: Text(
                widget.title,
                style: centerStyle.copyWith(),
                softWrap: false,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: actions,
            ),
          ),
          widget.bottom ?? Container()
        ],
      ),
    );
  }

  void _handleDrawerButton() {
    Scaffold.of(context).openDrawer();
  }

  void _handleDrawerButtonEnd() {
    Scaffold.of(context).openEndDrawer();
  }
}
