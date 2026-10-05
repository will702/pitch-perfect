import 'dart:async';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class WhisperModelPaths {
  final String encoder, decoder, tokens;
  const WhisperModelPaths(this.encoder, this.decoder, this.tokens);
}

/// Downloads Whisper-tiny (multilingual, int8) once; inference is on-device.
class ModelManager {
  ModelManager({this.baseUrl = _defaultBase, this.dirOverride});

  static const _defaultBase =
      'https://huggingface.co/csukuangfj/sherpa-onnx-whisper-tiny/resolve/main';
  static const _files = [
    'tiny-encoder.int8.onnx',
    'tiny-decoder.int8.onnx',
    'tiny-tokens.txt',
  ];

  final String baseUrl;
  final Directory? dirOverride;

  Future<Directory> _dir() async {
    final d = dirOverride ??
        Directory(p.join((await getApplicationSupportDirectory()).path, 'models', 'whisper-tiny'));
    await d.create(recursive: true);
    return d;
  }

  Future<WhisperModelPaths?> locate() async {
    final d = await _dir();
    final paths = [for (final f in _files) File(p.join(d.path, f))];
    for (final f in paths) {
      if (!await f.exists() || await f.length() == 0) return null;
    }
    return WhisperModelPaths(paths[0].path, paths[1].path, paths[2].path);
  }

  /// Returns paths, downloading missing files. [onProgress] gets 0..1.
  Future<WhisperModelPaths> ensure(void Function(double) onProgress) async {
    final existing = await locate();
    if (existing != null) return existing;
    final d = await _dir();
    final client = HttpClient();
    try {
      // First pass: sizes, so progress spans all files.
      final sizes = <String, int>{};
      for (final f in _files) {
        final req = await client.headUrl(Uri.parse('$baseUrl/$f'));
        final res = await req.close();
        await res.drain<void>();
        sizes[f] = res.contentLength > 0 ? res.contentLength : 1;
      }
      final total = sizes.values.fold<int>(0, (a, b) => a + b);
      var done = 0;
      for (final f in _files) {
        final target = File(p.join(d.path, f));
        if (await target.exists() && await target.length() > 0) {
          done += sizes[f]!;
          continue;
        }
        final part = File('${target.path}.part');
        final sink = part.openWrite();
        try {
          final req = await client.getUrl(Uri.parse('$baseUrl/$f'));
          final res = await req.close();
          if (res.statusCode != 200) {
            throw HttpException('HTTP ${res.statusCode} for $f');
          }
          await for (final chunk in res) {
            sink.add(chunk);
            done += chunk.length;
            onProgress((done / total).clamp(0.0, 1.0));
          }
          await sink.close();
          await part.rename(target.path);
        } catch (_) {
          await sink.close();
          if (await part.exists()) await part.delete();
          rethrow;
        }
      }
      onProgress(1);
    } finally {
      client.close();
    }
    final paths = await locate();
    if (paths == null) throw StateError('Model files missing after download');
    return paths;
  }
}
