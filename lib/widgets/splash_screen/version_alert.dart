import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_installer/flutter_app_installer.dart';

class VersionAlert extends StatefulWidget {
  const VersionAlert({super.key, required this.apkUrl, required this.version});

  final String apkUrl;
  final String version;

  @override
  State<VersionAlert> createState() => _VersionAlertState();
}

class _VersionAlertState extends State<VersionAlert> {
  double _progress = 0.0;
  bool _isDownloading = false;
  bool _downloadCompleted = false;
  String? _filePath;

  late final String _apkFileName;

  @override
  void initState() {
    super.initState();
    _apkFileName = 'app_update_${widget.version}.apk';
    _checkExistingApk();
  }

  Future<void> _checkExistingApk() async {
    final downloadsDir = Directory('/storage/emulated/0/Download');
    final path = '${downloadsDir.path}/$_apkFileName';

    final file = File(path);

    if (await file.exists()) {
      setState(() {
        _filePath = path;
        _downloadCompleted = true;
      });
    }
  }

  Future<void> _downloadApk() async {
    setState(() {
      _isDownloading = true;
      _progress = 0;
    });

    try {
      final downloadsDir = Directory('/storage/emulated/0/Download');
      if (!downloadsDir.existsSync()) {
        downloadsDir.createSync(recursive: true);
      }

      final filePath = '${downloadsDir.path}/$_apkFileName';

      final dio = Dio();

      await dio.download(
        widget.apkUrl,
        filePath,
        onReceiveProgress: (received, total) {
          if (total > 0) {
            setState(() {
              _progress = received / total;
            });
          }
        },
      );

      setState(() {
        _isDownloading = false;
        _downloadCompleted = true;
        _filePath = filePath;
      });
    } catch (e) {
      setState(() {
        _isDownloading = false;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Download failed')));
    }
  }

  Future<void> _installApk() async {
    if (_filePath == null) return;

    await FlutterAppInstaller().installApk(filePath: _filePath!);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Update Available'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Version ${widget.version} is available'),
          const SizedBox(height: 16),

          if (_isDownloading) ...[
            LinearProgressIndicator(value: _progress),
            const SizedBox(height: 8),
            Text('${(_progress * 100).toStringAsFixed(0)}%'),
          ],

          if (_downloadCompleted)
            const Text(
              'APK ready to install',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
        ],
      ),
      actions: [
        if (!_isDownloading && !_downloadCompleted)
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Later'),
          ),

        if (!_isDownloading && !_downloadCompleted)
          ElevatedButton(
            onPressed: _downloadApk,
            child: const Text('Download'),
          ),

        if (_downloadCompleted)
          ElevatedButton(onPressed: _installApk, child: const Text('Install')),
      ],
    );
  }
}
