import 'package:flutter/material.dart';

// Code stolen from
// https://stackoverflow.com/questions/49307677/how-to-get-height-of-a-widget

/// Use it as following:
///
/// ```dart
/// SizeProviderWidget(
///   child:MyWidget(), //the widget we want the size of,
///   onChildSize:(size) {
///     // the size of the rendered MyWidget() is available here
///   }
/// )
/// ```
