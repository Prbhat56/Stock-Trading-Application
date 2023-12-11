import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/stockModel/stocksModel.dart';
import '../models/tickerModel/tickers.dart';

class DetailsScreen extends StatefulWidget {
  final CompanyDetails companyDetails;
  final StocksModel model;
  final String companyLogo;

  const DetailsScreen({
    Key key,
    this.model,
    this.companyDetails,
    this.companyLogo,
  }) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  DateFormat dateFormat = DateFormat("yyyy/MM/dd");

  @override
  void initState() {
    super.initState();
  }

  Widget _scrollGraph() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: const EdgeInsets.only(
          bottom: 15,
        ),
        width: MediaQuery.of(context).size.height * 2,
        child: _graph(),
      ),
    );
  }

  Widget _graph() {
    final spots = widget.model.data
        .asMap()
        .entries
        .map(
          (e) => FlSpot(
            e.key.toDouble(),
            e.value.high,
          ),
        )
        .toList();
    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            dotData: FlDotData(show: false),
            color: Colors.amber,
          ),
        ],
        clipData: FlClipData.all(),
        titlesData: FlTitlesData(
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                reservedSize: 6,
                getTitlesWidget: _bottomTitles,
                showTitles: true,
              ),
            ),
        ),
        borderData: FlBorderData(
          border: Border.all(color: Colors.white12, width: 1),
        ),
      ),
      swapAnimationDuration: const Duration(milliseconds: 150),
      swapAnimationCurve: Curves.linear,
    );
  }

  Widget _bottomTitles(double xValue, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black45,
      fontSize: 14,
    );
    String text(xValue) {
      String cdate = DateFormat("dd-MM")
          .format(widget.model.data.map((e) => e.date) as DateTime);
      return cdate;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: AutoSizeText(
        text.toString(),
        style: style,
        textAlign: TextAlign.left,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.black,
          ),
          iconSize: 40,
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.model.data.map((e) => e.symbol).first.toString(),
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            Text(
              widget.companyDetails.companyName,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\$${widget.model.data.map((e) => e.open).first}",
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                          text: "Exchange : ",
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: widget.model.data
                                  .map((e) => e.exchange)
                                  .first,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ]),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Date Range: ${dateFormat.format(widget.model.data.map((e) => e.date).first)} - ${dateFormat.format(widget.model.data.map((e) => e.date).last)}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                widget.companyLogo != null
                    ? Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.blueGrey.shade400.withOpacity(0.1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image(
                            image: AssetImage(
                              widget.companyLogo,
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2,
              child: _scrollGraph(),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey.withOpacity(0.3),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Icon(
                                  Icons.monetization_on_outlined,
                                  size: 14,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Open Price",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "\$${widget.model.data.map((e) => e.open).first}",
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Icon(
                                  Icons.arrow_upward,
                                  size: 14,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "24h High",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "\$${widget.model.data.map((e) => e.high).first}",
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Icon(
                                  Icons.trending_up,
                                  size: 14,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Volume",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "\$${widget.model.data.map((e) => e.volume).first}",
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Icon(
                                  Icons.arrow_downward,
                                  size: 14,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "24h Low",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "\$${widget.model.data.map((e) => e.low).first}",
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
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
}