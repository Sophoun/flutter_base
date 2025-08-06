import 'package:flutter/material.dart';
import 'package:flutter_base/src/base/base_vm.dart';
import 'package:flutter_base/src/di/di_container.dart';
import 'package:flutter_base/src/inherited/localize_inherited.dart';
import 'package:flutter_base/src/inherited/vm_inherited.dart';

/// BaseWidget is a base class for widgets that need to integrate with ViewModels
/// and handle loading states. It provides a structure for building widgets
/// that can access ViewModels and display loading indicators when necessary.
abstract class BaseWidget extends StatefulWidget {
  const BaseWidget({super.key});

  @override
  State<BaseWidget> createState() => _BaseWidgetState();

  /// The build method should be implemented by subclasses to define the widget's UI.
  // ignore: library_private_types_in_public_api
  Widget build(BuildContext context, _BaseWidgetState state);
}

class _BaseWidgetState extends State<BaseWidget> {
  /// Refresh the widget state
  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  /// Get the ViewModel of type [T] from the inherited widget
  T getVm<T extends BaseVm>() {
    return VmInherited.of<T>(context);
  }

  /// Get the di object of type [T]
  T getDi<T>() => DiContainer.get<T>();

  /// Get localization from the inherited widget
  LocalizeInherited get local => LocalizeInherited.of(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: widget.build(context, this));
  }
}
