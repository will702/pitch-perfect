import 'package:flutter/material.dart';

class MetricCard extends StatelessWidget {
  const MetricCard({super.key, required this.label, required this.value, this.icon});
  final String label;
  final String value;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(value, style: t.titleLarge?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 2),
          Text(label, style: t.labelMedium),
        ]),
      ),
    );
  }
}
