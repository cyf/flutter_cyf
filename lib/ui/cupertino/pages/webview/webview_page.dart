import 'dart:async';
import 'package:flutter/cupertino.dart';

import 'package:lottie/lottie.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:flutter_cyf/common/app_manager.dart';

const String kNavigationExamplePage = '''
<!DOCTYPE html><html>
<head><title>Navigation Delegate Example</title></head>
<body>
<p>
The navigation delegate is set to block navigation to the youtube website.
</p>
<ul>
<ul><a href="https://chenyifaer.com">https://chenyifaer.com</a></ul>
<ul><a href="https://apps.chenyifaer.com/chenyifaer">https://apps.chenyifaer.com/chenyifaer</a></ul>
</ul>
</body>
</html>
''';

class WebViewPage extends StatefulWidget {
  final String headerTitle;

  const WebViewPage({Key key, this.headerTitle}) : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  bool _loading = true;
  String lastSelectedValue;

  @override
  Widget build(BuildContext context) {
    double top = MediaQuery.of(context).padding.top;
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.headerTitle ?? "WebViewPage"),
        trailing: navigationControls(),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 44 + top),
            child: WebView(
              initialUrl: 'https://chenyifaer.com',
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
              // TODO(iskakaushik): Remove this when collection literals makes it to stable.
              // ignore: prefer_collection_literals
              javascriptChannels: <JavascriptChannel>[
                _toasterJavascriptChannel(context),
              ].toSet(),
              navigationDelegate: (NavigationRequest request) {
                if (request.url
                    .startsWith('https://apps.chenyifaer.com/chenyifaer')) {
                  print('blocking navigation to $request}');
                  return NavigationDecision.prevent;
                }
                print('allowing navigation to $request');
                return NavigationDecision.navigate;
              },
              onPageStarted: (String url) {
                setState(() {
                  _loading = true;
                });
                print('Page started loading: $url');
              },
              onPageFinished: (String url) {
                setState(() {
                  _loading = false;
                });
                print('Page finished loading: $url');
              },
              gestureNavigationEnabled: true,
            ),
          ),
          Positioned(
            child: _loading ? Center(
              child: SizedBox(
                width: 80,
                height: 80,
                child: Lottie.asset(
                  "assets/animations/loading.json",
                  repeat: true,
                ),
              ),
            ) : Container(),
          ),
          if (lastSelectedValue != null)
            Positioned(
              bottom: AppManager().kBottomNavigationBarHeight + 26,
              child: Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: Text('$lastSelectedValue'),
              ),
            ),
        ],
      ),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
//          CupertinoPageScaffold.of(context).showSnackBar(
//            SnackBar(content: Text(message.message)),
//          );
        });
  }

  Widget navigationControls() {
    return FutureBuilder<WebViewController>(
      future: _controller.future,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        final WebViewController controller = snapshot.data;
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CupertinoButton(
              padding: EdgeInsets.all(0),
              child: const Icon(CupertinoIcons.back,),
              onPressed: !webViewReady
                  ? null
                  : () async {
                if (await controller.canGoBack()) {
                  setState(() { lastSelectedValue = null; });
                  await controller.goBack();
                } else {
                  setState((){ lastSelectedValue = 'No back history item'; });
                  Future.delayed(Duration(milliseconds: 2000), () {
                    setState(() { lastSelectedValue = null; });
                  });
                  return;
                }
              },
            ),
            CupertinoButton(
              padding: EdgeInsets.all(0),
              child: const Icon(CupertinoIcons.forward,),
              onPressed: !webViewReady
                  ? null
                  : () async {
                if (await controller.canGoForward()) {
                  setState(() { lastSelectedValue = null; });
                  await controller.goForward();
                } else {
                  setState(() { lastSelectedValue = 'No forward history item'; });
                  Future.delayed(Duration(milliseconds: 2000), () {
                    setState(() { lastSelectedValue = null; });
                  });
                  return;
                }
              },
            ),
            CupertinoButton(
              padding: EdgeInsets.all(0),
              child: const Icon(CupertinoIcons.refresh,),
              onPressed: !webViewReady
                  ? null
                  : () {
                controller.reload();
              },
            ),
          ],
        );
      },
    );
  }
}
