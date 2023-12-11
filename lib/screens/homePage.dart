import 'package:flutter/material.dart';
import '../blocs/companyBloc.dart';
import '../components/companiesList.dart';

import '../components/saerchDelegate.dart';
import '../components/watchListTiles.dart';
import '../helper/response.dart';
import '../models/tickerModel/tickers.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CompanyBloc _bloc;
  int stocksTrends = 3;
  bool openInFull = false;

  @override
  void initState() {
    super.initState();
    _bloc = CompanyBloc();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Stocks",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Welcome back!",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
              );
            },
            splashColor: Colors.transparent,
            icon: const Icon(
              Icons.search,
              size: 30,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  StreamBuilder<Response<CompanyCodeList>>(
                    stream: _bloc.companyListStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        switch (snapshot.data.status) {
                          case Status.loading:
                            return const Loading(
                              loadingMessage: "Loading",
                            );
                            break;
                          case Status.completed:
                            companyList.add(snapshot.data.data);
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Stock Trends",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        if (stocksTrends == 3) {
                                          setState(() {
                                            stocksTrends = 10;
                                          });
                                        } else {
                                          setState(() {
                                            stocksTrends = 3;
                                          });
                                        }
                                      },
                                      child: Text(
                                        stocksTrends == 3
                                            ? "See All"
                                            : "Hide",
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CompaniesList(
                                  companyCodeList: snapshot.data.data,
                                  index: stocksTrends,
                                ),
                              ],
                            );

                            break;
                          case Status.error:
                            return Error(
                              errorMessage: snapshot.data.message,
                              onRetryPressed: () => _bloc.fetchSymbols(),
                            );
                            break;
                        }
                      } else {
                        return const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.black),
                        );
                      }
                      return Container();
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Watchlist",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            openInFull = !openInFull;
                          });
                        },
                        child: Icon(
                          openInFull ? Icons.grid_view : Icons.open_in_full,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: openInFull ? 520 : 240,
                    child: ListView.builder(
                      itemCount: stocks.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return WatchListTiles(
                          companyCode: stocks[index].companyCode,
                          companyLogo: stocks[index].companyLogo,
                          companyName: stocks[index].companyName,
                          inFull: openInFull,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Error extends StatelessWidget {
  final String errorMessage;

  final Function onRetryPressed;

  const Error({Key key, this.errorMessage, this.onRetryPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: onRetryPressed,
            child: const Text('Retry', style: TextStyle(color: Colors.black)),
          )
        ],
      ),
    );
  }
}

class Loading extends StatelessWidget {
  final String loadingMessage;

  const Loading({Key key, this.loadingMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            loadingMessage,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 24),
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
          ),
        ],
      ),
    );
  }
}