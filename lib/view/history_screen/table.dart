import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../api/api_service.dart';
import '../../api/duLieuQuanTrac_model.dart';
import '../../globals/globals.dart';

class TableData extends StatefulWidget {
  const TableData({super.key});

  @override
  State<TableData> createState() => _TableDataState();
}

class _TableDataState extends State<TableData> {
  Globals globals = Get.put(Globals());
  late DuLieuQuanTracModel duLieuQuanTracModel;
  APIService apiService = APIService();

  @override
  Widget build(BuildContext context) {
    double sizeDevice = globals.sizeDevice.value;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(30 / sizeDevice, 0, 35 / sizeDevice, 0),
        height: 670 / sizeDevice,
        width: 1365 / sizeDevice,
        child: SingleChildScrollView(
          child: Table(
            border: TableBorder.all(),
            columnWidths: const {
              0: FractionColumnWidth(0.37),
              1: FractionColumnWidth(0.1),
              2: FractionColumnWidth(0.1),
              3: FractionColumnWidth(0.1),
              4: FractionColumnWidth(0.1),
              5: FractionColumnWidth(0.1),
              6: FractionColumnWidth(0.13),
            },
            children: [
              buildRow([
                // 'STT',
                'Thời gian',
                'pH',
                'COD',
                'BOD',
                'TSS',
                'NH4',
                'Nhiệt độ'
              ], isHeader: true),
              for (int i = 0; i < globals.listData.length; i++)
                buildRow(globals.listData[i].toList()),
            ],
          ),
        ),
      ),
    );
  }

  TableRow buildRow(List<dynamic> cells, {bool isHeader = false}) => TableRow(
          children: cells.map((cell) {
        final style = TextStyle(
            fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
            fontSize: isHeader ? 26 : 22);
        return Padding(
          padding: const EdgeInsets.all(12),
          child: Center(
              child: Text(
            cell.toString(),
            style: style,
          )),
        );
      }).toList());
}
