import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ChartsScreen extends StatefulWidget {
  const ChartsScreen({Key? key}) : super(key: key);

  @override
  State<ChartsScreen> createState() => _ChartsScreenState();
}

class _ChartsScreenState extends State<ChartsScreen> {
  int _selectedPeriod = 7; // Default to 7 days
  final List<int> _periods = [7, 30, 90];

  final List<Map<String, dynamic>> _salesData = [
    {'date': 'Mon', 'amount': 45000},
    {'date': 'Tue', 'amount': 28000},
    {'date': 'Wed', 'amount': 35000},
    {'date': 'Thu', 'amount': 52000},
    {'date': 'Fri', 'amount': 38000},
    {'date': 'Sat', 'amount': 65000},
    {'date': 'Sun', 'amount': 48000},
  ];

  final List<Map<String, dynamic>> _viewsData = [
    {'date': 'Mon', 'views': 120},
    {'date': 'Tue', 'views': 85},
    {'date': 'Wed', 'views': 95},
    {'date': 'Thu', 'views': 130},
    {'date': 'Fri', 'views': 110},
    {'date': 'Sat', 'views': 145},
    {'date': 'Sun', 'views': 125},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Analytics'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Period Selection
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _periods.map((period) {
                  return ChoiceChip(
                    label: Text('$period days'),
                    selected: _selectedPeriod == period,
                    onSelected: (selected) {
                      setState(() => _selectedPeriod = period);
                    },
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),

            // Sales Chart
            _ChartCard(
              title: 'Sales Overview',
              subtitle: 'Total: MWK ${_calculateTotal(_salesData, 'amount')}',
              chart: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() >= 0 &&
                              value.toInt() < _salesData.length) {
                            return Text(_salesData[value.toInt()]['date']);
                          }
                          return const Text('');
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: _salesData.asMap().entries.map((entry) {
                        return FlSpot(entry.key.toDouble(),
                            entry.value['amount'].toDouble());
                      }).toList(),
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: Colors.blue.withOpacity(0.1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Views Chart
            _ChartCard(
              title: 'Views Analytics',
              subtitle: 'Total Views: ${_calculateTotal(_viewsData, 'views')}',
              chart: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() >= 0 &&
                              value.toInt() < _viewsData.length) {
                            return Text(_viewsData[value.toInt()]['date']);
                          }
                          return const Text('');
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: _viewsData.asMap().entries.map((entry) {
                        return FlSpot(entry.key.toDouble(),
                            entry.value['views'].toDouble());
                      }).toList(),
                      isCurved: true,
                      color: Colors.green,
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: Colors.green.withOpacity(0.1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  int _calculateTotal(List<Map<String, dynamic>> data, String key) {
    return data.fold(0, (sum, item) => sum + item[key] as int);
  }
}

class _ChartCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget chart;

  const _ChartCard({
    required this.title,
    required this.subtitle,
    required this.chart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 200,
            child: chart,
          ),
        ],
      ),
    );
  }
}
