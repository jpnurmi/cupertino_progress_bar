# Cupertino Progress Bar for Flutter

[![pub](https://img.shields.io/pub/v/cupertino_progress_bar.svg)](https://pub.dev/packages/cupertino_progress_bar)
[![license: BSD](https://img.shields.io/badge/license-BSD-yellow.svg)](https://opensource.org/licenses/BSD-3-Clause)
![build](https://github.com/jpnurmi/cupertino_progress_bar/workflows/build/badge.svg)
[![codecov](https://codecov.io/gh/jpnurmi/cupertino_progress_bar/branch/master/graph/badge.svg)](https://codecov.io/gh/jpnurmi/cupertino_progress_bar)

A progress bar includes a track that fills from left to right to show the progression of a task with
a known duration. Progress bars are non-interactive, although they are often accompanied by a button
for canceling the corresponding operation.

Always report progress accurately. Don’t display inaccurate progress information just to make your
app appear busy. Only use progress bars for tasks that are quantifiable. Otherwise, use an activity
indicator.

Use progress bars for tasks with a well-defined duration. Progress bars are great for showing the
status of a task, especially when it helps convey how much longer the task needs to complete.

Hide the unfilled portion of track in navigation bars and toolbars. By default, a progress bar’s
track includes both filled and unfilled portions. When used in a navigation bar or toolbar, such as
to denote a page loading, a progress bar should be configured to hide the unfilled portion of the
track.

Consider customizing a progress bar’s appearance to match your app. A progress bar’s appearance can
be adjusted to match your app’s design. You can specify, for example, a custom color for both the
track and fill.

See also:
 * <https://api.flutter.dev/flutter/cupertino/CupertinoActivityIndicator-class.html>
 * <https://developer.apple.com/design/human-interface-guidelines/ios/controls/progress-indicators/>

## Screenshots

### Horizontal

![Light CupertinoProgressBar](https://raw.githubusercontent.com/jpnurmi/cupertino_progress_bar/master/doc/images/light.png "Light CupertinoProgressBar")

### Vertical

![Dark CupertinoProgressBar](https://raw.githubusercontent.com/jpnurmi/cupertino_progress_bar/master/doc/images/dark.png "Dark CupertinoProgressBar")

## Usage

To use this package, add `cupertino_progress_bar` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).
