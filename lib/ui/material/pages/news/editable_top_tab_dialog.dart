import 'package:flutter/material.dart';
import 'package:flutter_cyf/common/utils/navigator_util.dart';

class EditableTopTabDialog extends StatefulWidget {
  @override
  _EditableTopTabDialogState createState() => _EditableTopTabDialogState();
}

class _EditableTopTabDialogState extends State<EditableTopTabDialog> {
  bool _editable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(),
        title: Text(!_editable ? '查看' : '编辑'),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Text(
              !_editable ? '编辑' : '完成',
            ),
            onPressed: () {
              if (!_editable) {
                setState(() {
                  _editable = true;
                });
              } else {
                NavigatorUtil.pop(context);
              }
            },
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            child: Text('123'),
          ),
        ],
      ),
    );
  }
}
