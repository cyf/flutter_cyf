import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum AppBarBehavior { normal, pinned, floating, snapping }

class Author extends StatefulWidget {
  final String headerTitle;

  const Author({Key key, this.headerTitle}) : super(key: key);
  @override
  AuthorState createState() => AuthorState();
}

class AuthorState extends State<Author> {
  static final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final double _appBarHeight = 256.0;

  AppBarBehavior _appBarBehavior = AppBarBehavior.pinned;

  @override
  Widget build(BuildContext context) {
    double horizontal = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      key: _scaffoldKey,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: _appBarHeight + horizontal,
            pinned: _appBarBehavior == AppBarBehavior.pinned,
            floating: _appBarBehavior == AppBarBehavior.floating || _appBarBehavior == AppBarBehavior.snapping,
            snap: _appBarBehavior == AppBarBehavior.snapping,
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.create),
                tooltip: 'Edit',
                onPressed: () {
                  _scaffoldKey.currentState.showSnackBar(const SnackBar(
                    content: Text("Editing isn't supported in this screen."),
                  ));
                },
              ),
              PopupMenuButton<AppBarBehavior>(
                onSelected: (AppBarBehavior value) {
                  setState(() {
                    _appBarBehavior = value;
                  });
                },
                itemBuilder: (BuildContext context) => <PopupMenuItem<AppBarBehavior>>[
                  const PopupMenuItem<AppBarBehavior>(
                    value: AppBarBehavior.normal,
                    child: Text('App bar scrolls away'),
                  ),
                  const PopupMenuItem<AppBarBehavior>(
                    value: AppBarBehavior.pinned,
                    child: Text('App bar stays put'),
                  ),
                  const PopupMenuItem<AppBarBehavior>(
                    value: AppBarBehavior.floating,
                    child: Text('App bar floats'),
                  ),
                  const PopupMenuItem<AppBarBehavior>(
                    value: AppBarBehavior.snapping,
                    child: Text('App bar snaps'),
                  ),
                ],
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Text('科技小白英仔'),
              background: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Image.network(
                    'https://assets.chenyifaer.com/cyf-apps/chenyifaer/512x512.png',
                    fit: BoxFit.cover,
                    height: _appBarHeight,
                  ),
                  // This gradient ensures that the toolbar icons are distinct
                  // against the background image.
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.0, -1.0),
                        end: Alignment(0.0, -0.4),
                        colors: <Color>[Color(0x60000000), Color(0x00000000)],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle.dark,
                child: _ContactCategory(
                  icon: FontAwesomeIcons.sitemap,
                  children: <Widget>[
                    _ContactItem(
                      icon: FontAwesomeIcons.home,
                      tooltip: 'HomePage',
                      onPressed: () {
                        _scaffoldKey.currentState.showSnackBar(const SnackBar(
                          content: Text('https://chenyifaer.com.'),
                        ));
                      },
                      lines: const <String>[
                        'https://chenyifaer.com',
                        'HomePage',
                      ],
                    ),
                    _ContactItem(
                      icon: FontAwesomeIcons.github,
                      tooltip: 'GitHub',
                      onPressed: () {
                        _scaffoldKey.currentState.showSnackBar(const SnackBar(
                          content: Text('https://github.com/cyf.'),
                        ));
                      },
                      lines: const <String>[
                        'https://github.com/cyf',
                        'GitHub',
                      ],
                    ),
                    _ContactItem(
                      icon: FontAwesomeIcons.git,
                      tooltip: 'Gitee',
                      onPressed: () {
                        _scaffoldKey.currentState.showSnackBar(const SnackBar(
                          content: Text('https://gitee.com/cyf.'),
                        ));
                      },
                      lines: const <String>[
                        'https://gitee.com/fans',
                        'Gitee',
                      ],
                    ),
                  ],
                ),
              ),
              _ContactCategory(
                icon: Icons.location_on,
                children: <Widget>[
                  _ContactItem(
                    icon: Icons.map,
                    tooltip: 'Address',
                    onPressed: () {
                      _scaffoldKey.currentState.showSnackBar(const SnackBar(
                        content: Text('Qingdao city.'),
                      ));
                    },
                    lines: const <String>[
                      'Qingdao city',
                      'Shandong province',
                      'China',
                      'Address',
                    ],
                  ),
                  _ContactItem(
                    icon: Icons.map,
                    tooltip: 'Address',
                    onPressed: () {
                      _scaffoldKey.currentState.showSnackBar(const SnackBar(
                        content: Text('Qingdao city.'),
                      ));
                    },
                    lines: const <String>[
                      'Qingdao city',
                      'Shandong province',
                      'China',
                      'Address',
                    ],
                  ),
                  _ContactItem(
                    icon: Icons.map,
                    tooltip: 'Address',
                    onPressed: () {
                      _scaffoldKey.currentState.showSnackBar(const SnackBar(
                        content: Text('Qingdao city.'),
                      ));
                    },
                    lines: const <String>[
                      'Qingdao city',
                      'Shandong province',
                      'China',
                      'Address',
                    ],
                  ),
                  _ContactItem(
                    icon: Icons.map,
                    tooltip: 'Address',
                    onPressed: () {
                      _scaffoldKey.currentState.showSnackBar(const SnackBar(
                        content: Text('Qingdao city.'),
                      ));
                    },
                    lines: const <String>[
                      'Qingdao city',
                      'Shandong province',
                      'China',
                      'Address',
                    ],
                  ),
                ],
              ),
              _ContactCategory(
                icon: Icons.today,
                children: <Widget>[
                  _ContactItem(
                    lines: const <String>[
                      'Birthday',
                      'January 9th, 1989',
                    ],
                  ),
                  _ContactItem(
                    lines: const <String>[
                      'Wedding anniversary',
                      'June 21st, 2014',
                    ],
                  ),
                  _ContactItem(
                    lines: const <String>[
                      'Birthday',
                      'January 9th, 1989',
                    ],
                  ),
                  _ContactItem(
                    lines: const <String>[
                      'Wedding anniversary',
                      'June 21st, 2014',
                    ],
                  ),
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

class _ContactCategory extends StatelessWidget {
  const _ContactCategory({ Key key, this.icon, this.children }) : super(key: key);

  final IconData icon;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: themeData.dividerColor))
      ),
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.subhead,
        child: SafeArea(
          top: false,
          bottom: false,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                width: 72.0,
                child: Icon(icon, color: themeData.primaryColor),
              ),
              Expanded(child: Column(children: children)),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  const _ContactItem({ Key key, this.icon, this.lines, this.tooltip, this.onPressed })
      : assert(lines.length > 1),
        super(key: key);

  final IconData icon;
  final List<String> lines;
  final String tooltip;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return MergeSemantics(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ...lines.sublist(0, lines.length - 1).map<Widget>((String line) => Text(line)),
                  Text(lines.last, style: themeData.textTheme.caption),
                ],
              ),
            ),
            if (icon != null)
              SizedBox(
                width: 72.0,
                child: IconButton(
                  icon: Icon(icon),
                  color: themeData.primaryColor,
                  onPressed: onPressed,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
