class CheckUpdatedVersion {
  final String? apkUrl;
  final String? version;
  final bool isUpdateAvailable;

  CheckUpdatedVersion({
    this.apkUrl,
    this.version,
    required this.isUpdateAvailable,
  });

  factory CheckUpdatedVersion.fromJson(Map<String, dynamic> json) {
    return CheckUpdatedVersion(
      apkUrl: json['apk_url'],
      version: json['version'],
      isUpdateAvailable: json["isUpdateAvailable"] ?? false,
    );
  }
}
