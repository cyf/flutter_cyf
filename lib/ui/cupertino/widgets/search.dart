import 'package:flutter/cupertino.dart';

import 'package:flutter_cyf/common/utils/string_util.dart';

class Search extends StatefulWidget {
  final bool enabled;
  final bool hideLeft;
  final bool hideRight;
  final bool hideSpeak;
  final bool hideSearchIcon;
  final bool autoFocus;
  final String hint;
  final String defaultText;
  final Function leftButtonClick;
  final Function rightButtonClick;
  final Function speakClick;
  final Function inputBoxClick;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;

  const Search({
    Key key,
    this.enabled = true,
    this.hideLeft,
    this.hideRight,
    this.hideSpeak,
    this.hideSearchIcon = false,
    this.autoFocus = false,
    this.hint,
    this.defaultText,
    this.leftButtonClick,
    this.rightButtonClick,
    this.speakClick,
    this.inputBoxClick,
    this.onChanged,
    this.onSubmitted,
  }) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _controller = TextEditingController();
  bool showClear = false;

  @override
  void initState() {
    _setTextField();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(Search oldWidget) {
    _setTextField();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return _genNormalSearch();
  }

  void _setTextField() {
    String keyword = widget.defaultText ?? StringUtil.STRING_EMPTY;
    setState(() {
      _controller.text = keyword;
      showClear = keyword.isNotEmpty;
    });
  }

  _genNormalSearch() {
    return Container(
      child: Row(
        children: <Widget>[
          _warpTap(
            Container(
              padding: widget.hideLeft ?? false
                  ? EdgeInsets.all(5)
                  : EdgeInsets.fromLTRB(6, 5, 10, 5),
              child: widget.hideLeft ?? false
                  ? null
                  : Icon(
                      CupertinoIcons.back,
                      color: CupertinoColors.systemGrey,
                      size: 26,
                    ),
            ),
            widget.leftButtonClick,
          ),
          Expanded(flex: 1, child: _inputBox()),
          _warpTap(
            Container(
              padding: widget.hideRight ?? false
                  ? EdgeInsets.all(5)
                  : EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: widget.hideRight ?? false
                  ? null
                  : Text(
                      '搜索',
                      style: TextStyle(
                          color: CupertinoColors.systemBlue, fontSize: 17),
                    ),
            ),
            widget.rightButtonClick,
          ),
        ],
      ),
    );
  }

  _warpTap(Widget child, void Function() callback) {
    return GestureDetector(
      onTap: () {
        if (callback != null) callback();
      },
      child: child,
    );
  }

  _inputBox() {
    return Container(
      alignment: Alignment.center,
      height: 30,
      decoration: BoxDecoration(
          color: CupertinoColors.systemBackground,
          borderRadius: BorderRadius.circular(5)),
      child: CupertinoTextField(
        controller: _controller,
        prefix: !widget.hideSearchIcon
            ? Icon(
          CupertinoIcons.search,
          size: 20,
          color: CupertinoColors.systemGrey,
        )
            : null,
        suffix: _inputClear,
        placeholder: widget.hint ?? StringUtil.STRING_EMPTY,
        placeholderStyle: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: CupertinoColors.placeholderText),
        onChanged: _onChanged,
        onSubmitted: _onSubmitted,
        autocorrect: false,
        autofocus: widget.autoFocus,
        style: TextStyle(
          fontSize: 18,
          color: CupertinoColors.black,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  get _inputClear {
    return !showClear
        ? widget.hideSpeak
            ? Container()
            : _warpTap(
                Icon(
                  CupertinoIcons.mic,
                  size: 22,
                  color: CupertinoColors.systemBlue,
                ),
                widget.speakClick,
              )
        : _warpTap(
            Icon(
              CupertinoIcons.clear,
              size: 22,
              color: CupertinoColors.systemGrey,
            ),
            () {
              setState(() {
                setState(() {
                  _controller.clear();
                });
              });
              _onChanged(StringUtil.STRING_EMPTY);
              _onSubmitted(StringUtil.STRING_EMPTY);
            },
          );
  }

  void _onChanged(String text) {
    if (text.length > 0) {
      setState(() {
        showClear = true;
      });
    } else {
      setState(() {
        showClear = false;
      });
    }

    if (widget.onChanged != null) {
      widget.onChanged(text);
    }
  }

  void _onSubmitted(String value) {
    if (widget.onSubmitted != null) {
      widget.onSubmitted(value);
    }
  }
}
