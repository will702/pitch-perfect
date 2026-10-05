class SessionMetrics {
  final double averageWpm;
  final int fillerCount;
  final int pauseCount;
  final int longPauseCount;
  final double? averagePitchHz;
  final double? pitchStdDev;
  final double? averageRms;
  final double? volumeVariation; // coefficient of variation of voiced RMS
  final double? scriptCoverage; // 0..1
  final double? keywordCoverage; // 0..1
  final double? overallScore; // 0..100

  const SessionMetrics({
    this.averageWpm = 0,
    this.fillerCount = 0,
    this.pauseCount = 0,
    this.longPauseCount = 0,
    this.averagePitchHz,
    this.pitchStdDev,
    this.averageRms,
    this.volumeVariation,
    this.scriptCoverage,
    this.keywordCoverage,
    this.overallScore,
  });

  SessionMetrics copyWith({double? scriptCoverage, double? keywordCoverage, double? overallScore}) =>
      SessionMetrics(
        averageWpm: averageWpm,
        fillerCount: fillerCount,
        pauseCount: pauseCount,
        longPauseCount: longPauseCount,
        averagePitchHz: averagePitchHz,
        pitchStdDev: pitchStdDev,
        averageRms: averageRms,
        volumeVariation: volumeVariation,
        scriptCoverage: scriptCoverage ?? this.scriptCoverage,
        keywordCoverage: keywordCoverage ?? this.keywordCoverage,
        overallScore: overallScore ?? this.overallScore,
      );
}
