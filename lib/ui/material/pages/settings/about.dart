import 'dart:async';
import 'dart:developer' show Timeline, Flow;
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter/material.dart' hide Flow;
import 'package:flutter/gestures.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform;


import 'package:url_launcher/url_launcher.dart';

class _LinkTextSpan extends TextSpan {

  // Beware!
  //
  // This class is only safe because the TapGestureRecognizer is not
  // given a deadline and therefore never allocates any resources.
  //
  // In any other situation -- setting a deadline, using any of the less trivial
  // recognizers, etc -- you would have to manage the gesture recognizer's
  // lifetime and call dispose() when the TextSpan was no longer being rendered.
  //
  // Since TextSpan itself is @immutable, this means that you would have to
  // manage the recognizer from outside the TextSpan, e.g. in the State of a
  // stateful widget that then hands the recognizer to the TextSpan.

  _LinkTextSpan({ TextStyle style, String url, String text }) : super(
      style: style,
      text: text ?? url,
      recognizer: TapGestureRecognizer()
        ..onTap = () {
          launch(url, forceSafariVC: false);
        }
  );
}

void showDemoAboutDialog(BuildContext context) {
  final ThemeData themeData = Theme.of(context);
  final TextStyle aboutTextStyle = themeData.textTheme.body2;
  final TextStyle linkStyle = themeData.textTheme.body2.copyWith(
      color: themeData.accentColor);

  LicenseRegistry.reset();
  LicenseRegistry.addLicense(() async* {
    yield LicenseEntryWithLineBreaks(<String>[''], '''
      MIT License

      Copyright (c) 2020 chenyifaer.com
      
      Permission is hereby granted, free of charge, to any person obtaining a copy
      of this software and associated documentation files (the "Software"), to deal
      in the Software without restriction, including without limitation the rights
      to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
      copies of the Software, and to permit persons to whom the Software is
      furnished to do so, subject to the following conditions:
      
      The above copyright notice and this permission notice shall be included in all
      copies or substantial portions of the Software.
      
      THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
      IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
      FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
      AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
      LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
      OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
      SOFTWARE.
    '''
    );
  });

  showAboutDialog(
    context: context,
    applicationVersion: 'Apri 2020',
    applicationIcon: const ImageIcon(NetworkImage('https://assets.chenyifaer.com/cyf-apps/chenyifaer/512x512.png'), size: 40,),
//    applicationIcon: const FlutterLogo(),
    applicationLegalese: '© 2020 KJXBYZ',
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                style: aboutTextStyle,
                text: 'Flutter Demo is an open-source project to help developers '
                    'build high-performance, high-fidelity, mobile apps for '
                    '${defaultTargetPlatform == TargetPlatform.iOS
                    ? 'multiple platforms' : 'iOS and Android'} '
                    'from a single codebase. Learn more about Flutter at ',
              ),
              _LinkTextSpan(
                style: linkStyle,
                url: 'https://apps.chenyifaer.com/chenyifaer',
              ),
              TextSpan(
                style: aboutTextStyle,
                text: '.\n\nTo see the source code for this app, please visit the ',
              ),
              _LinkTextSpan(
                style: linkStyle,
                url: 'https://github.com/chenyifaerfans/chenyifaerfans-flutter',
                text: 'github repo',
              ),
              TextSpan(
                style: aboutTextStyle,
                text: '.',
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
