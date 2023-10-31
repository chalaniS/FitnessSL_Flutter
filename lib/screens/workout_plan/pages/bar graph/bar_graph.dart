import 'package:fitness/constants.dart';
import 'package:fitness/screens/workout_plan/pages/bar%20graph/bar_data.dart';
import 'package:fitness/screens/workout_plan/pages/progress_page.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarGraphPage extends StatefulWidget {
  final List weeklySummary;
  const BarGraphPage({Key? key, required this.weeklySummary});

  @override
  State<BarGraphPage> createState() => _BarGraphPageState();
}

class _BarGraphPageState extends State<BarGraphPage> {
  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(
      sunAmount: widget.weeklySummary[0],
      monAmount: widget.weeklySummary[1],
      tueAmount: widget.weeklySummary[2],
      wedAmount: widget.weeklySummary[3],
      thuAmount: widget.weeklySummary[4],
      friAmount: widget.weeklySummary[5],
      satAmount: widget.weeklySummary[6],
    );
    myBarData.initializeBardata();
    return BarChart(
      BarChartData(
        maxY: 150,
        minY: 0,
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: getBottomTiles,
            ),
          ),
        ),
        barGroups: myBarData.barData
            .map(
              (data) => BarChartGroupData(
                x: data.x,
                barRods: [
                  BarChartRodData(
                    toY: data.y,
                    color: Color.fromARGB(255, 227, 189, 1),
                    width: 25,
                    borderRadius: BorderRadius.circular(4),
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      toY: 100,
                      color: Colors.grey[200],
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  Widget getBottomTiles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('S', style: style);
        break;
      case 1:
        text = const Text('M', style: style);
        break;
      case 2:
        text = const Text('T', style: style);
        break;
      case 3:
        text = const Text('W', style: style);
        break;
      case 4:
        text = const Text('T', style: style);
        break;
      case 5:
        text = const Text('F', style: style);
        break;
      case 6:
        text = const Text('S', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }
    return SideTitleWidget(child: text, axisSide: meta.axisSide);
  }
}
