import 'package:flutter/material.dart';
import 'package:flutter_base/flutter_base.dart';

// ignore: must_be_immutable
class MessageDialog extends StatelessWidget {
  MessageDialog({super.key});

  MessageDialogData? messageDialogData;

  void setData(MessageDialogData? data) {
    messageDialogData = data;
  }

  @override
  Widget build(BuildContext context) {
    if (messageDialogData?.type == MessageDialogType.toast) {
      Future.delayed(Duration(seconds: 1), () {
        hideMessage();
        messageDialogData?.onCancel?.call();
      });
    }

    return PopScope(
      canPop: false,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Theme.of(context).colorScheme.surfaceDim.withAlpha(180),
        child: Center(
          child: Container(
            width: 230,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 6,
              children: [
                if (messageDialogData?.title != null)
                  Flexible(
                    child: Text(
                      messageDialogData?.title ?? "",
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                Flexible(
                  child: Text(
                    messageDialogData?.message ?? "",
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                ),
                // Show as OK
                if (messageDialogData?.type == MessageDialogType.ok)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    spacing: 6,
                    children: [
                      TextButton(
                        onPressed: () {
                          hideMessage();
                          messageDialogData?.onOk?.call();
                        },
                        child: Text(
                          messageDialogData?.okText ?? "",
                          style: Theme.of(
                            context,
                          ).outlinedButtonTheme.style?.textStyle?.resolve({}),
                        ),
                      ),
                    ],
                  )
                // Show as OK and Cancel
                else if (messageDialogData?.type == MessageDialogType.okCanncel)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    spacing: 2,
                    children: [
                      TextButton(
                        onPressed: () {
                          hideMessage();
                          messageDialogData?.onCancel?.call();
                        },
                        child: Text(
                          messageDialogData?.cancelText ?? "",
                          style:
                              Theme.of(context).textButtonTheme.style?.textStyle
                                  ?.resolve({})
                                  ?.copyWith(color: Colors.redAccent) ??
                              TextStyle(color: Colors.redAccent),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          hideMessage();
                          messageDialogData?.onOk?.call();
                        },
                        child: Text(
                          messageDialogData?.okText ?? "",
                          style: Theme.of(
                            context,
                          ).textButtonTheme.style?.textStyle?.resolve({}),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
