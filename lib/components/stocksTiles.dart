import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../blocs/stockBloc.dart';
import '../helper/response.dart';
import '../models/stockModel/stocksModel.dart';
import '../models/tickerModel/tickers.dart';
import '../screens/detailsScreen.dart';

class StockTiles extends StatefulWidget {
  final String companyName;
  final String companyCode;

  const StockTiles({
    Key key,
    this.companyName,
    this.companyCode,
  }) : super(key: key);

  @override
  State<StockTiles> createState() => _StockTilesState();
}

class _StockTilesState extends State<StockTiles> {
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  StocksBloc _bloc;
  StocksModel stocksModel;

  @override
  void initState() {
    _bloc = StocksBloc(widget.companyCode);
    super.initState();
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
          child: StreamBuilder<Response<StocksModel>>(
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
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.companyCode,
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width/2,
                                child: AutoSizeText(
                                  widget.companyName,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                snapshot.data.data.data.map((e) => e.exchange).first.toString() ?? "",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "EOD : ${dateFormat.format(snapshot.data.data.data.map((e) => e.date).first)}",
                                style: const TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "\$${snapshot.data.data.data.map((e) => e.open).first.toString()}",
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "\$${snapshot.data.data.data.map((e) => e.close).first.toString()}",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "\$${snapshot.data.data.data.map((e) => e.volume).first.toString()}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
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
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                    ),
                  );
                }
                return Container();

              }
          ),
        ),
      ),
    );
  }
}