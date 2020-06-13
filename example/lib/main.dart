import 'package:flutter/cupertino.dart';
import 'package:cupertino_progress_bar/cupertino_progress_bar.dart';

void main() => runApp(Container(child: ExampleApp()));

class ExampleApp extends StatefulWidget {
  @override
  _ExampleAppState createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  bool _dark = false;
  double _value = 0.77;

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(
        brightness: _dark ? Brightness.dark : Brightness.light,
      ),
      home: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          padding: EdgeInsetsDirectional.zero,
          middle: Stack(
            overflow: Overflow.visible,
            children: [
              Center(child: Text('CupertinoProgressBar')),
              Positioned(
                left: -8,
                right: -8,
                bottom: 0,
                child: CupertinoProgressBar(
                  value: _value,
                  trackColor: null,
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                bottom: 0,
                child: CupertinoSwitch(
                  value: _dark,
                  onChanged: (value) => setState(() => _dark = value),
                ),
              )
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${(_value * 100).round()}%'),
                  SizedBox(height: 48),
                  CupertinoProgressBar(
                    value: _value,
                  ),
                ],
              ),
            ),
            CupertinoSlider(
              value: _value,
              onChanged: (value) => setState(() => _value = value),
            ),
          ],
        ),
      ),
    );
  }
}
