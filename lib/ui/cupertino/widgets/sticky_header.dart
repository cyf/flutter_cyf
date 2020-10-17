import 'package:flutter/cupertino.dart';

class StickyHeader extends StatefulWidget {
  final Widget header;
  final bool showSortBtn;
  final Function sortBtnCallBack;

  const StickyHeader({
    Key key,
    @required this.header,
    this.showSortBtn = false,
    this.sortBtnCallBack,
  }) : assert(header != null),
        super(key: key);

  @override
  _StickyHeaderState createState() => _StickyHeaderState();
}

class _StickyHeaderState extends State<StickyHeader> {
  int _quarterTurns = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CupertinoDynamicColor.resolve(
          CupertinoColors.systemBackground, context),
      padding: EdgeInsets.only(left: 16, top: 2, bottom: 2),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _headerContentChildren(),
      ),
    );
  }

  List<Widget> _headerContentChildren() {
    List<Widget> widgets = [];
    widgets.add(widget.header);

    if (widget.showSortBtn) {
      widgets.add(GestureDetector(
        onTap: _toggleSortStatus,
        child: Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(
            right: 6,
          ),
          width: 26,
          child: RotatedBox(
            quarterTurns: _quarterTurns,
            child: Icon(
              CupertinoIcons.loop,
              size: 18,
            ),
          ),
        ),
      ));
    }
    return widgets;
  }

  void _toggleSortStatus() {
    setState(() {
      _quarterTurns = _quarterTurns + 2;
    });

    if (widget.sortBtnCallBack != null) {
      widget.sortBtnCallBack();
    }
  }
}
