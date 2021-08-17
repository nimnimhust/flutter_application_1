import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("2021 奥运奖牌榜"),
        leading: Icon(Icons.menu),
        actions: [
          Icon(Icons.settings)
        ],
        elevation: 0.0,
        centerTitle: true,
      ),
      body: MedalList()
    );
  }
}

class Medal {
  String country;
  int golds;
  int silvers;
  int bronzes;
  int total;

  Medal(this.country, this.golds, this.silvers, this.bronzes, {this.total = 0});
}

class MedalList extends StatefulWidget {
  MedalList({Key? key}) : super(key: key);

  @override
  _MedalListState createState() => _MedalListState();
}

class _MedalListState extends State<MedalList> {
  List<Medal> data = [
    Medal('images/china.jpeg', 6, 1, 4),
    Medal('images/japan.jpeg', 5, 1, 0),
    Medal('images/america.jpeg', 4, 2, 4),
    Medal('images/korean.jpeg', 2, 0, 3),
  ];

  var _sortAscending = true;

  List<DataRow> _getUserRows() {
    List<DataRow> dataRows = [];
    for (int i = 0; i < data.length; i++) {
      data[i].total = data[i].golds + data[i].silvers + data[i].bronzes;
      dataRows.add(
        DataRow(
 //         selected: data[i].selected,
 //         onSelectChanged: (selected) {
 //           setState(() {
 //             data[i].selected = selected!;
 //           });
 //         },
          cells: [
            DataCell(Image.asset(
              data[i].country,
              width: 40,
              height: 30,
              fit: BoxFit.fill,
            )),
            DataCell(Text('${data[i].golds}')),
            DataCell(Text('${data[i].silvers}')),
            DataCell(Text('${data[i].bronzes}')),
            DataCell(Text('${data[i].total}')),            
          ]
        )
      );
    }

    return dataRows;
  }

  var _sortColumnIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          sortColumnIndex: _sortColumnIndex,
          sortAscending: _sortAscending,
          dataRowHeight: 100,
          horizontalMargin: 20,
          columnSpacing: 30,
          columns: [
            DataColumn(label: Text('国家')),

            DataColumn(
              label: Text('金牌'),
              numeric: true,
              onSort: (int columnIndex, bool asscending) {
                setState(() {
                  _sortColumnIndex = columnIndex;
                  _sortAscending = asscending;
                  if (asscending) {
                    data.sort((a, b) => a.golds.compareTo(b.golds));
                  } else {
                    data.sort((a, b) => b.golds.compareTo(a.golds));
                  }
                });
              }
            ),
            DataColumn(
              label: Text('银牌'),
              numeric: true,
              onSort: (int columnIndex, bool asscending) {
                setState(() {
                  _sortColumnIndex = columnIndex;
                  _sortAscending = asscending;
                  if (asscending) {
                    data.sort((a, b) => a.silvers.compareTo(b.silvers));
                  } else {
                    data.sort((a, b) => b.silvers.compareTo(a.silvers));
                  }
                });
              }
            ),
            DataColumn(
              label: Text('铜牌'),
              numeric: true,
              onSort: (int columnIndex, bool asscending) {
                setState(() {
                  _sortColumnIndex = columnIndex;
                  _sortAscending = asscending;
                  if (asscending) {
                    data.sort((a, b) => a.bronzes.compareTo(b.bronzes));
                  } else {
                    data.sort((a, b) => b.bronzes.compareTo(a.bronzes));
                  }
                });
              }
            ),  
            DataColumn(
              label: Text('奖牌总数'),
              numeric: true,
              onSort: (int columnIndex, bool asscending) {
                setState(() {
                  _sortColumnIndex = columnIndex;
                  _sortAscending = asscending;
                  if (asscending) {
                    data.sort((a, b) => a.total.compareTo(b.total));
                  } else {
                    data.sort((a, b) => b.total.compareTo(a.total));
                  }
                });
              }
            ),
          ], 
          rows: _getUserRows(),
        )
      ),
    );
  }
}
