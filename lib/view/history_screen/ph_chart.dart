import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../api/api_service.dart';
import '../../api/duLieuQuanTrac_model.dart';
import '../../globals/globals.dart';

class PHChart extends StatefulWidget {
  const PHChart({Key? key}) : super(key: key);

  @override
  State<PHChart> createState() => _PHChartState();
}

class _PHChartState extends State<PHChart> {
  Globals globals = Get.put(Globals());

  late List<LiveData> chartData;
  late ChartSeriesController _chartSeriesController;
  late String timeOfDay;
  String dateOfMonth = "";
  late DuLieuQuanTracModel duLieuQuanTracModel;
  APIService apiService = APIService();

  @override
  void initState() {
    chartData = getChartData();
    Timer.periodic(const Duration(seconds: 5), (timer) {
      duLieuQuanTracModel = DuLieuQuanTracModel();
      apiService.getDuLieu(duLieuQuanTracModel);
    });
    Timer.periodic(const Duration(seconds: 5), updateDataSource);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: 600,
      child: SfCartesianChart(
        series: <LineSeries<LiveData, String>>[
          LineSeries<LiveData, String>(
            onRendererCreated: (ChartSeriesController controller) {
              _chartSeriesController = controller;
            },
            dataSource: chartData,
            color: const Color.fromRGBO(192, 108, 132, 1),
            xValueMapper: (LiveData sales, _) => sales.time,
            yValueMapper: (LiveData sales, _) => sales.speed,
          )
        ],
        primaryXAxis: CategoryAxis(
            majorGridLines: const MajorGridLines(width: 1),
            title: AxisTitle(text: 'Time')),
        primaryYAxis: NumericAxis(
          axisLine: const AxisLine(width: 0),
          majorTickLines: const MajorTickLines(size: 0),
          title: AxisTitle(text: 'pH'),
        ),
      ),
    );
  }

  int number = 20;
  var i = 0;
  void updateDataSource(Timer timer) {
    var length = globals.pHDataList.length;
    if (length > 0 && i < length - 1) {
      String a = globals.pHDataList[i]['time'].substring(11, 19);
      double value = globals.pHDataList[i]['pH'];
      chartData.add(LiveData(a, value));
      chartData.removeAt(0);
      _chartSeriesController.updateDataSource(
          addedDataIndex: chartData.length - 1, removedDataIndex: 0);
      i++;
    }
  }

  List<LiveData> getChartData() {
    return <LiveData>[
      LiveData('0', 4.2),
      LiveData('1', 7.2),
      LiveData('2', 3.9),
      LiveData('3', 9.5),
      LiveData('4', 5.4),
      LiveData('5', 4.1),
      LiveData('6', 5.8),
      LiveData('7', 5.1),
      LiveData('8', 9.8),
      LiveData('9', 4.1),
      LiveData('10', 5.3),
      LiveData('11', 7.2),
      LiveData('12', 8.6),
      LiveData('13', 5.2),
      LiveData('14', 9.4),
      LiveData('15', 9.2),
      LiveData('16', 8.6),
      LiveData('17', 7.2),
      LiveData('18', 9.4),
      LiveData('19', 8.6),
    ];
  }
}

class LiveData {
  LiveData(this.time, this.speed);
  final String time;
  final num speed;
}
