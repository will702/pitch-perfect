import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MiniLineChart extends StatelessWidget {
  const MiniLineChart({super.key, required this.title, required this.points, this.unit = ''});
  final String title;
  final List<FlSpot> points;
  final String unit;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: Theme.of(context).textTheme.titleSmall),
      const SizedBox(height: 8),
      SizedBox(
        height: 140,
        child: points.length < 2
            ? const Center(child: Text('Not enough data'))
            : LineChart(LineChartData(
                gridData: const FlGridData(show: true, drawVerticalLine: false),
                borderData: FlBorderData(show: false),
                titlesData: const FlTitlesData(
                  topTitles: AxisTitles(),
                  rightTitles: AxisTitles(),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: points,
                    isCurved: true,
                    dotData: const FlDotData(show: false),
                    color: color,
                    barWidth: 2,
                  )
                ],
              )),
      ),
    ]);
  }
}
