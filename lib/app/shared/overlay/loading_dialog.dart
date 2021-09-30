import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../core/constants/default_style.dart';

part 'loading_dialog.g.dart';

abstract class LoadingDialog {
  Future<void> show();
  Future<void> hide();
}

@Injectable()
class LoadingDialogImpl implements LoadingDialog {
  late OverlayEntry? _entry;

  LoadingDialogImpl() {
    _entry = _page();
  }

  @override
  Future<void> hide() async {
    _entry?.remove();
    _entry = null;
    
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<void> show() async {
    FocusNode? primaryFocus = FocusManager.instance.primaryFocus;
    if (primaryFocus != null) {
      primaryFocus.unfocus();
    }
    _entry ??= _page();

    asuka.addOverlay(_entry!);
    await Future.delayed(const Duration(milliseconds: 500));
  }

  OverlayEntry _page() => OverlayEntry(
    builder: (context) {
      return Container(
        color: DefaultStyle.currentTheme(context).secondary.withOpacity(.3),
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(DefaultStyle.currentTheme(context).primary)
        ),
      );
    },
  );
}
