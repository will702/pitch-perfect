import 'dart:math';
import 'dart:typed_data';

double rms(Float32List x, [int start = 0, int? end]) {
  final e = end ?? x.length;
  if (e <= start) return 0;
  var s = 0.0;
  for (var i = start; i < e; i++) {
    s += x[i] * x[i];
  }
  return sqrt(s / (e - start));
}
