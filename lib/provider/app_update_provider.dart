import 'package:flutter_riverpod/flutter_riverpod.dart';

enum UpdateStatus { idle, required }

class UpdateController extends Notifier<UpdateStatus> {
  String? apkUrl;
  String? version;

  @override
  UpdateStatus build() {
    return UpdateStatus.idle;
  }

  void requireUpdate({required String apkUrl, required String version}) {
    this.apkUrl = apkUrl;
    this.version = version;
    state = UpdateStatus.required;
  }

  void clear() {
    apkUrl = null;
    version = null;
    state = UpdateStatus.idle;
  }
}

final updateControllerProvider =
    NotifierProvider<UpdateController, UpdateStatus>(UpdateController.new);
