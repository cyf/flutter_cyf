import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';

import 'package:flutter_cyf/common/utils/navigator_util.dart';

class FSwiper extends StatefulWidget {
  final String headerTitle;

  const FSwiper({Key key, this.headerTitle}) : super(key: key);

  @override
  _FSwiperState createState() => _FSwiperState();
}

class _FSwiperState extends State<FSwiper> {
  List<Widget> render(BuildContext context, List children) {
    return ListTile.divideTiles(
        context: context,
        tiles: children.map((dynamic data) {
          return buildListTile(context, data[0], data[1], data[2]);
        })).toList();
  }

  Widget buildListTile(
      BuildContext context, String title, String subtitle, Widget widget) {
    return new ListTile(
      onTap: () {
        NavigatorUtil.push(context, widget);
      },
      title: new Text(title),
      subtitle: new Text(subtitle),
      trailing: new Icon(
        Icons.arrow_forward_ios,
        color: Colors.blueAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.headerTitle ?? "Swiper"),
      ),
      body: ListView(
        children: render(context, [
          ["Horizontal", "Scroll Horizontal", ExampleHorizontal()],
          ["Vertical", "Scroll Vertical", ExampleVertical()],
          ["Fraction", "Fraction style", ExampleFraction()],
          ["Custom Pagination", "Custom Pagination", ExampleCustomPagination()],
          ["Phone", "Phone view", ExamplePhone()],
          ["ScrollView ", "In a ScrollView", ScaffoldWidget(
              child: ExampleSwiperInScrollView(), title: "ScrollView")],
          ["Custom", "Custom all properties", ScaffoldWidget(
            child: ExampleCustom(),
            title: "Custom All",
          )]
        ]),
      ),
    );
  }

}

const List<String> titles = [
  "Flutter Swiper is awosome",
  "Really nice",
  "Yeap"
];

const List<String> images = [
  "assets/images/bg0.jpeg",
  "assets/images/bg1.jpeg",
  "assets/images/bg2.jpeg",
];

class ExampleHorizontal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("ExampleHorizontal"),
        ),
        body: new Swiper(
          itemBuilder: (BuildContext context, int index) {
            return new Image.asset(
              images[index],
              fit: BoxFit.fill,
            );
          },

          indicatorLayout: PageIndicatorLayout.COLOR,
          autoplay: true,
          itemCount: images.length,
          pagination: new SwiperPagination(),
          control: new SwiperControl(),
        ));
  }
}

class ExampleVertical extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("ExampleVertical"),
        ),
        body: new Swiper(
          itemBuilder: (BuildContext context, int index) {
            return new Image.asset(
              images[index],
              fit: BoxFit.fill,
            );
          },
          autoplay: true,
          itemCount: images.length,
          scrollDirection: Axis.vertical,
          pagination: new SwiperPagination(alignment: Alignment.centerRight),
          control: new SwiperControl(),
        ));
  }
}

class ExampleFraction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: Text("ExampleFraction"),
        ),
        body: new Column(
          children: <Widget>[
            Expanded(
                child: new Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return new Image.asset(
                      images[index],
                      fit: BoxFit.fill,
                    );
                  },
                  autoplay: true,
                  itemCount: images.length,
                  pagination:
                  new SwiperPagination(builder: SwiperPagination.fraction),
                  control: new SwiperControl(),
                )),
            Expanded(
                child: new Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return new Image.asset(
                      images[index],
                      fit: BoxFit.fill,
                    );
                  },
                  autoplay: true,
                  itemCount: images.length,
                  scrollDirection: Axis.vertical,
                  pagination: new SwiperPagination(
                      alignment: Alignment.centerRight,
                      builder: SwiperPagination.fraction),
                ))
          ],
        ));
  }
}

class ExampleCustomPagination extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Custom Pagination"),
        ),
        body: new Column(
          children: <Widget>[
            new Expanded(
              child: new Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return new Image.asset(
                    images[index],
                    fit: BoxFit.fill,
                  );
                },
                autoplay: true,
                itemCount: images.length,
                pagination: new SwiperPagination(
                    margin: new EdgeInsets.all(0.0),
                    builder: new SwiperCustomPagination(builder:
                        (BuildContext context, SwiperPluginConfig config) {
                      return new ConstrainedBox(
                        child: new Container(
                            color: Colors.white,
                            child: new Text(
                              "${titles[config.activeIndex]} ${config.activeIndex + 1}/${config.itemCount}",
                              style: new TextStyle(fontSize: 20.0),
                            )),
                        constraints: new BoxConstraints.expand(height: 50.0),
                      );
                    })),
                control: new SwiperControl(),
              ),
            ),
            new Expanded(
              child: new Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return new Image.asset(
                    images[index],
                    fit: BoxFit.fill,
                  );
                },
                autoplay: true,
                itemCount: images.length,
                pagination: new SwiperPagination(
                    margin: new EdgeInsets.all(0.0),
                    builder: new SwiperCustomPagination(builder:
                        (BuildContext context, SwiperPluginConfig config) {
                      return new ConstrainedBox(
                        child: new Row(
                          children: <Widget>[
                            new Text(
                              "${titles[config.activeIndex]} ${config.activeIndex + 1}/${config.itemCount}",
                              style: TextStyle(fontSize: 20.0),
                            ),
                            new Expanded(
                              child: new Align(
                                alignment: Alignment.centerRight,
                                child: new DotSwiperPaginationBuilder(
                                    color: Colors.black12,
                                    activeColor: Colors.black,
                                    size: 10.0,
                                    activeSize: 20.0)
                                    .build(context, config),
                              ),
                            )
                          ],
                        ),
                        constraints: new BoxConstraints.expand(height: 50.0),
                      );
                    })),
                control: new SwiperControl(color: Colors.redAccent),
              ),
            )
          ],
        ));
  }
}

class ExamplePhone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Phone"),
      ),
      body: new Stack(
        children: <Widget>[
          ConstrainedBox(
            constraints: new BoxConstraints.expand(),
            child: new Image.asset(
              "assets/images/bg.jpeg",
              fit: BoxFit.fill,
            ),
          ),
          new Swiper.children(
            autoplay: false,
            pagination: new SwiperPagination(
                margin: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 30.0),
                builder: new DotSwiperPaginationBuilder(
                    color: Colors.white30,
                    activeColor: Colors.white,
                    size: 20.0,
                    activeSize: 20.0)),
            children: <Widget>[
              new Image.asset(
                "assets/images/1.png",
                fit: BoxFit.contain,
              ),
              new Image.asset(
                "assets/images/2.png",
                fit: BoxFit.contain,
              ),
              new Image.asset("assets/images/3.png", fit: BoxFit.contain)
            ],
          )
        ],
      ),
    );
  }
}

class ScaffoldWidget extends StatelessWidget {
  final Widget child;
  final String title;
  final List<Widget> actions;

  ScaffoldWidget({this.child, this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title),
        actions: actions,
      ),
      body: child,
    );
  }
}

///
class ExampleCustom extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _ExampleCustomState();
  }
}

class _ExampleCustomState extends State<ExampleCustom> {
  //properties want to custom
  int _itemCount;

  bool _loop;

  bool _autoplay;

  int _autoplayDely;

  double _padding;

  bool _outer;

  double _radius;

  double _viewportFraction;

  SwiperLayout _layout;

  int _currentIndex;

  double _scale;

  Axis _scrollDirection;

  Curve _curve;

  double _fade;

  bool _autoplayDisableOnInteraction;

  CustomLayoutOption customLayoutOption;

  Widget _buildItem(BuildContext context, int index) {
    return ClipRRect(
      borderRadius: new BorderRadius.all(new Radius.circular(_radius)),
      child: new Image.asset(
        images[index % images.length],
        fit: BoxFit.fill,
      ),
    );
  }

  @override
  void didUpdateWidget(ExampleCustom oldWidget) {
    customLayoutOption = new CustomLayoutOption(startIndex: -1, stateCount: 3)
        .addRotate([-45.0 / 180, 0.0, 45.0 / 180]).addTranslate([
      new Offset(-370.0, -40.0),
      new Offset(0.0, 0.0),
      new Offset(370.0, -40.0)
    ]);
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    customLayoutOption = new CustomLayoutOption(startIndex: -1, stateCount: 3)
        .addRotate([-25.0 / 180, 0.0, 25.0 / 180]).addTranslate([
      new Offset(-350.0, 0.0),
      new Offset(0.0, 0.0),
      new Offset(350.0, 0.0)
    ]);
    _fade = 1.0;
    _currentIndex = 0;
    _curve = Curves.ease;
    _scale = 0.8;
    _controller = new SwiperController();
    _layout = SwiperLayout.TINDER;
    _radius = 10.0;
    _padding = 0.0;
    _loop = true;
    _itemCount = 3;
    _autoplay = false;
    _autoplayDely = 3000;
    _viewportFraction = 0.8;
    _outer = false;
    _scrollDirection = Axis.horizontal;
    _autoplayDisableOnInteraction = false;
    super.initState();
  }

// maintain the index

  Widget buildSwiper() {
    return new Swiper(
      onTap: (int index) {
        Navigator.of(context)
            .push(new MaterialPageRoute(builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text("New page"),
            ),
            body: Container(),
          );
        }));
      },
      customLayoutOption: customLayoutOption,
      fade: _fade,
      index: _currentIndex,
      onIndexChanged: (int index) {
        setState(() {
          _currentIndex = index;
        });
      },
      curve: _curve,
      scale: _scale,
      itemWidth: 300.0,
      controller: _controller,
      layout: _layout,
      outer: _outer,
      itemHeight: 200.0,
      viewportFraction: _viewportFraction,
      autoplayDelay: _autoplayDely,
      loop: _loop,
      autoplay: _autoplay,
      itemBuilder: _buildItem,
      itemCount: _itemCount,
      scrollDirection: _scrollDirection,
      indicatorLayout: PageIndicatorLayout.COLOR,
      autoplayDisableOnInteraction: _autoplayDisableOnInteraction,
      pagination: new SwiperPagination(
          builder: const DotSwiperPaginationBuilder(
              size: 20.0, activeSize: 20.0, space: 10.0)),
    );
  }

  SwiperController _controller;
  TextEditingController numberController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return new Column(children: <Widget>[
      new Container(
        color: Colors.black87,
        child: new SizedBox(
            height: 300.0, width: double.infinity, child: buildSwiper()),
      ),
      new Expanded(
          child: new ListView(
            children: <Widget>[
              new Text("Index:$_currentIndex"),
              new Row(
                children: <Widget>[
                  new RaisedButton(
                    onPressed: () {
                      _controller.previous(animation: true);
                    },
                    child: new Text("Prev"),
                  ),
                  new RaisedButton(
                    onPressed: () {
                      _controller.next(animation: true);
                    },
                    child: new Text("Next"),
                  ),
                  new Expanded(
                      child: new TextField(
                        controller: numberController,
                      )),
                  new RaisedButton(
                    onPressed: () {
                      var text = numberController.text;
                      setState(() {
                        _currentIndex = int.parse(text);
                      });
                    },
                    child: new Text("Update"),
                  ),
                ],
              ),
              new FormWidget(
                  label: "layout",
                  child: new FormSelect(
                      placeholder: "Select layout",
                      value: _layout,
                      values: [
                        SwiperLayout.DEFAULT,
                        SwiperLayout.STACK,
                        SwiperLayout.TINDER,
                        SwiperLayout.CUSTOM
                      ],
                      valueChanged: (value) {
                        _layout = value;
                        setState(() {});
                      })),
              new FormWidget(
                label: "scrollDirection",
                child: new Switch(
                    value: _scrollDirection == Axis.horizontal,
                    onChanged: (bool value) => setState(() => _scrollDirection =
                    value ? Axis.horizontal : Axis.vertical)),
              ),
              new FormWidget(
                label: "autoplayDisableOnInteractio",
                child: new Switch(
                    value: _autoplayDisableOnInteraction,
                    onChanged: (bool value) =>
                        setState(() => _autoplayDisableOnInteraction = value)),
              ),
              //Pannel Begin
              new FormWidget(
                label: "loop",
                child: new Switch(
                    value: _loop,
                    onChanged: (bool value) => setState(() => _loop = value)),
              ),
              new FormWidget(
                label: "outer",
                child: new Switch(
                    value: _outer,
                    onChanged: (bool value) => setState(() => _outer = value)),
              ),
              //Pannel Begin
              new FormWidget(
                label: "autoplay",
                child: new Switch(
                    value: _autoplay,
                    onChanged: (bool value) => setState(() => _autoplay = value)),
              ),

              new FormWidget(
                label: "padding",
                child: new NumberPad(
                  number: _padding,
                  step: 5.0,
                  min: 0.0,
                  max: 30.0,
                  onChangeValue: (num value) {
                    _padding = value.toDouble();
                    setState(() {});
                  },
                ),
              ),
              new FormWidget(
                label: "scale",
                child: new NumberPad(
                  number: _scale,
                  step: 0.1,
                  min: 0.0,
                  max: 1.0,
                  onChangeValue: (num value) {
                    _scale = value.toDouble();
                    setState(() {});
                  },
                ),
              ),
              new FormWidget(
                label: "fade",
                child: new NumberPad(
                  number: _fade,
                  step: 0.1,
                  min: 0.0,
                  max: 1.0,
                  onChangeValue: (num value) {
                    _fade = value.toDouble();
                    setState(() {});
                  },
                ),
              ),
              new FormWidget(
                label: "itemCount",
                child: new NumberPad(
                  number: _itemCount,
                  step: 1,
                  min: 0,
                  max: 100,
                  onChangeValue: (num value) {
                    _itemCount = value.toInt();
                    setState(() {});
                  },
                ),
              ),

              new FormWidget(
                label: "radius",
                child: new NumberPad(
                  number: _radius,
                  step: 1.0,
                  min: 0.0,
                  max: 30.0,
                  onChangeValue: (num value) {
                    this._radius = value.toDouble();
                    setState(() {});
                  },
                ),
              ),

              new FormWidget(
                label: "viewportFraction",
                child: new NumberPad(
                  number: _viewportFraction,
                  step: 0.1,
                  max: 1.0,
                  min: 0.5,
                  onChangeValue: (num value) {
                    _viewportFraction = value.toDouble();
                    setState(() {});
                  },
                ),
              ),

              new FormWidget(
                  label: "curve",
                  child: new FormSelect(
                      placeholder: "Select curve",
                      value: _layout,
                      values: [
                        Curves.easeInOut,
                        Curves.ease,
                        Curves.bounceInOut,
                        Curves.bounceOut,
                        Curves.bounceIn,
                        Curves.fastOutSlowIn
                      ],
                      valueChanged: (value) {
                        _curve = value;
                        setState(() {});
                      })),
            ],
          ))
    ]);
  }
}

class FormWidget extends StatelessWidget {
  final String label;

  final Widget child;

  FormWidget({this.label, this.child});

  @override
  Widget build(BuildContext context) {
    return new Padding(
        padding: new EdgeInsets.all(5.0),
        child: new Row(
          children: <Widget>[
            new Text(label, style: new TextStyle(fontSize: 14.0)),
            new Expanded(
                child:
                new Align(alignment: Alignment.centerRight, child: child))
          ],
        ));
  }
}

class FormSelect<T> extends StatefulWidget {
  final String placeholder;
  final ValueChanged<T> valueChanged;
  final List<dynamic> values;
  final dynamic value;

  FormSelect({this.placeholder, this.valueChanged, this.value, this.values});

  @override
  State<StatefulWidget> createState() {
    return _FormSelectState();
  }
}

class _FormSelectState extends State<FormSelect> {
  int _selectedIndex = 0;

  @override
  void initState() {
    for (int i = 0, c = widget.values.length; i < c; ++i) {
      if (widget.values[i] == widget.value) {
        _selectedIndex = i;
        break;
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String placeholder = widget.placeholder;
    List<dynamic> values = widget.values;

    return new Container(
      child: new InkWell(
        child: new Text(_selectedIndex < 0
            ? placeholder
            : values[_selectedIndex].toString()),
        onTap: () {
          _selectedIndex = 0;
          showBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return new SizedBox(
                  height: values.length * 30.0 + 200.0,
                  child: new Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new SizedBox(
                        height: values.length * 30.0 + 70.0,
                        child: new CupertinoPicker(
                          itemExtent: 30.0,
                          children: values.map((dynamic value) {
                            return new Text(value.toString());
                          }).toList(),
                          onSelectedItemChanged: (int index) {
                            _selectedIndex = index;
                          },
                        ),
                      ),
                      new Center(
                        child: new RaisedButton(
                          onPressed: () {
                            if (_selectedIndex >= 0) {
                              widget
                                  .valueChanged(widget.values[_selectedIndex]);
                            }

                            setState(() {});

                            Navigator.of(context).pop();
                          },
                          child: new Text("ok"),
                        ),
                      )
                    ],
                  ),
                );
              });
        },
      ),
    );
  }
}

class NumberPad extends StatelessWidget {
  final num number;
  final num step;
  final num max;
  final num min;
  final ValueChanged<num> onChangeValue;

  NumberPad({this.number, this.step, this.onChangeValue, this.max, this.min});

  void onAdd() {
    onChangeValue(number + step > max ? max : number + step);
  }

  void onSub() {
    onChangeValue(number - step < min ? min : number - step);
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        new IconButton(icon: new Icon(Icons.exposure_neg_1), onPressed: onSub),
        new Text(
          number is int ? number.toString() : number.toStringAsFixed(1),
          style: new TextStyle(fontSize: 14.0),
        ),
        new IconButton(icon: new Icon(Icons.exposure_plus_1), onPressed: onAdd)
      ],
    );
  }
}

class ExampleSwiperInScrollView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _ExampleState();
  }
}

class _ExampleState extends State<ExampleSwiperInScrollView>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> _animation10;
  Animation<double> _animation11;
  Animation<double> _animation12;
  Animation<double> _animation13;

  _ExampleState();

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  void initState() {
    controller = new AnimationController(vsync: this);
    _animation10 = new Tween(begin: 0.0, end: 1.0).animate(controller);
    _animation11 = new Tween(begin: 0.0, end: 1.0).animate(controller);
    _animation12 = new Tween(begin: 0.0, end: 1.0).animate(controller);
    _animation13 = new Tween(begin: 0.0, end: 1.0).animate(controller);
    controller.animateTo(1.0, duration: new Duration(seconds: 3));
    super.initState();
  }

  Widget _buildDynamicCard() {
    return new Card(
      elevation: 2.0,
      color: Colors.white,
      child: new Stack(
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
              ),
            ],
          ),
          new Column(
            children: <Widget>[
              new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(top: 40.0),
                        ),
                        new ScaleTransition(
                          scale: _animation10,
                          alignment: FractionalOffset.center,
                        ),
                      ],
                    ),
                    new Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(top: 160.0),
                        ),
                        new ScaleTransition(
                          scale: _animation11,
                          alignment: FractionalOffset.center,
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(1.0),
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(top: 160.0),
                        ),
                        new ScaleTransition(
                          scale: _animation12,
                          alignment: FractionalOffset.center,
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(top: 40.0),
                        ),
                        new ScaleTransition(
                          scale: _animation13,
                          alignment: FractionalOffset.center,
                        ),
                      ],
                    ),
                  ]),
              Container(
                padding: const EdgeInsets.all(10.0),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return new Container(
      color: Theme.of(context).primaryColorLight,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
              delegate: new SliverChildBuilderDelegate((c, i) {
                return new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new SizedBox(
                      height: 100.0,
                      child: Swiper(
                        scale:0.8,
                        fade:0.8,
                        itemBuilder: (c, i) {
                          return Container(
                            color: Colors.grey,
                            child: Text("$i"),
                          );
                        },
                        itemCount: 10,
                        pagination: new SwiperPagination(),
                      ),
                    ),
                    new SizedBox(
                      height: 100.0,
                      child: Swiper(
                          scale:0.8,
                          fade:0.8,
                          itemBuilder: (c, i) {
                            return Container(
                              color: Colors.grey,
                              child: Text("$i"),
                            );
                          },
                          pagination: new SwiperPagination(
                              builder: SwiperPagination.fraction),
                          itemCount: 0),
                    ),
                    new SizedBox(
                      height: 100.0,
                      child: Swiper(
                          scale:0.8,
                          fade:0.8,
                          itemBuilder: (c, i) {
                            return Container(
                              color: Colors.grey,
                              child: Text("$i"),
                            );
                          },
                          pagination: new SwiperPagination(
                              builder: SwiperPagination.fraction),
                          itemCount: 10000),
                    ),
                    new SizedBox(
                      height: 100.0,
                      child: Swiper(
                          outer: true,
                          scale:0.8,
                          fade:0.8,
                          itemBuilder: (c, i) {
                            return new Container(
                              color: Colors.grey,
                              child: Text("$i"),
                            );
                          },
                          pagination: SwiperPagination(),
                          itemCount: 10),
                    ),
                    new Text("Image from network"),
                    new SizedBox(
                      height: 300.0,
                      child: new Swiper(
                        itemCount: 10,
                        itemBuilder: (BuildContext context, int index) {
                          return new Image.network(
                              "https://ss3.baidu.com/9fo3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=87d6daed02f41bd5c553eef461d881a0/f9198618367adab4b025268587d4b31c8601e47b.jpg");
                        },
                      ),
                    ),
                    new SizedBox(
                      height: 100.0,
                      child: new Swiper(
                          outer: true,
                          scale:0.8,
                          fade:0.8,
                          itemBuilder: (c, i) {
                            return new Card(
                              elevation: 2.0,
                              child: new Stack(
                                alignment: AlignmentDirectional.center,
                                children: <Widget>[
                                  new Container(
                                    child: new Image.network(
                                        "https://ss3.baidu.com/9fo3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=87d6daed02f41bd5c553eef461d881a0/f9198618367adab4b025268587d4b31c8601e47b.jpg"),
                                  ),
                                  FractionalTranslation(
                                    translation: Offset(0.0, 0.0),
                                    child: new Container(
                                      alignment: new FractionalOffset(0.0, 0.0),
                                      decoration: new BoxDecoration(
                                        border: new Border.all(
                                          color: Colors.lightBlue.withOpacity(0.5),
                                          width: 100.0,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                  new Container(
                                    //padding: const EdgeInsets.only(bottom:10.0),
                                    margin: new EdgeInsets.all(140.0),

                                    child: Icon(Icons.location_on,
                                        color: Colors.white, size: 25.0),
                                  ),
                                ],
                              ),
                            );
                          },
                          pagination:
                          new SwiperPagination(alignment: Alignment.topCenter),
                          itemCount: 10),
                    ),
                    new SizedBox(
                      height: 400.0,
                      child: new Swiper(
                          outer: true,
                          itemBuilder: (c, i) {
                            return _buildDynamicCard();
                          },
                          pagination:
                          new SwiperPagination(alignment: Alignment.topCenter),
                          itemCount: 10),
                    ),
                    new SizedBox(
                      height: 100.0,
                      child: new Swiper(
                          outer: true,
                          fade:0.8,
                          viewportFraction: 0.8,
                          scale: 0.8,
                          itemBuilder: (c, i) {
                            return Container(
                              color: Colors.grey,
                              child: Text("$i"),
                            );
                          },
                          pagination:
                          new SwiperPagination(alignment: Alignment.topCenter),
                          itemCount: 10),
                    ),
                  ],
                );
              }, childCount: 1))
        ],
      ),
    );
  }
}
