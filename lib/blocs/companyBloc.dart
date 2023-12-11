import 'dart:async';

import 'package:flutter/foundation.dart';

import '../helper/response.dart';
import '../models/tickerModel/tickers.dart';
import '../repository/stocksTickerRepository.dart';

class CompanyBloc{
  StocksTickerRepository _tickerRepository;
  StreamController _streamController;
 StreamSink<Response<CompanyCodeList>> get companyListSink => _streamController.sink;

 Stream<Response<CompanyCodeList>> get companyListStream => _streamController.stream;

  CompanyBloc(){
    _streamController = StreamController<Response<CompanyCodeList>>();
    _tickerRepository = StocksTickerRepository();
    fetchSymbols();
  }

  fetchSymbols() async{
    companyListSink.add(Response.loading('Getting Companies List'));
    try{
      CompanyCodeList companies = await _tickerRepository.fetchTickerData();
      companyListSink.add(Response.completed(companies));
    }catch(e){
      companyListSink.add(Response.error(e.toString()));
      if (kDebugMode) {
        print(e);
      }
    }
  }

  dispose(){
    _streamController.close();
  }
}