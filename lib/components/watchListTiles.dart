
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../blocs/stockBloc.dart';
import '../helper/response.dart';
import '../models/stockModel/stocksModel.dart';
import '../models/tickerModel/tickers.dart';
import '../screens/detailsScreen.dart';

class WatchListTiles extends StatefulWidget {
  final String companyCode;
  final String companyName;
  final String companyLogo;
  final bool inFull;

  const WatchListTiles({
    Key key,
    this.companyCode,
    this.companyName,
    this.companyLogo,
    this.inFull,
  }) : super(key: key);

  @override
  State<WatchListTiles> createState() => _WatchListTilesState();
}

class _WatchListTilesState extends State<WatchListTiles> {
  StocksBloc _bloc;
  StocksModel stocksModel;

  @override
  void initState() {
    _bloc = StocksBloc(widget.companyCode);
    super.initState();
  }

  Widget _graph(StocksModel model) {
    final spots = model.data
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
          show: false,
        ),
        borderData: FlBorderData(
          border: Border.all(color: Colors.white12, width: 1),
        ),
      ),
      swapAnimationDuration: const Duration(milliseconds: 150),
      swapAnimationCurve: Curves.linear,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailsScreen(
              companyDetails: CompanyDetails(
                companyName: widget.companyName,
                companyCode: widget.companyCode,
              ),
              model: stocksModel,
              companyLogo: widget.companyLogo,
            ),
          ),
        );
      },
      child: Card(
        elevation: 0,
        color: Colors.blueGrey.shade100.withOpacity(0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.companyCode,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: AutoSizeText(
                          widget.companyName,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: Image(
                      image: AssetImage(
                        widget.companyLogo,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              StreamBuilder<Response<StocksModel>>(
                  stream: _bloc.stocksDataStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      switch (snapshot.data.status) {
                        case Status.loading:
                          break;
                        case Status.completed:
                          stocksModel = StocksModel(
                            data: snapshot.data.data.data,
                          );
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Visibility(
                                visible: widget.inFull,
                                child: SizedBox(
                                  width: 300,
                                  height: 300,
                                  child: _graph(snapshot.data.data),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "\$${snapshot.data.data.data.map((e) => e.open).last.toString()}",
                                style: TextStyle(
                                  fontSize: widget.inFull ? 30 : 40,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: const [
                                          Icon(
                                            Icons.arrow_upward,
                                            size: 12,
                                            color: Colors.grey,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "24h High",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "\$${snapshot.data.data.data.map((e) => e.high).first}",
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: const [
                                          Icon(
                                            Icons.arrow_downward,
                                            size: 12,
                                            color: Colors.grey,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "24h Low",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "\$${snapshot.data.data.data.map((e) => e.low).first}",
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          );
                          break;
                        case Status.error:
                          break;
                      }
                    } else {
                      return const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.black),
                        ),
                      );
                    }
                    return Container();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}