import 'dart:async';

import '../helper/response.dart';
import '../models/stockModel/stocksModel.dart';
import '../repository/stocksRepository.dart';

class StocksBloc{
  StocksRepository _stocksRepository;
  StreamController _streamController;
  StreamSink<Response<StocksModel>> get stocksDataSink => _streamController.sink;
  Stream<Response<StocksModel>> get stocksDataStream => _streamController.stream;

  StocksBloc(String companies){
    _streamController = StreamController<Response<StocksModel>>();
    _stocksRepository = StocksRepository();
    fetchStocksDetails(companies);
  }

  fetchStocksDetails(String category) async{
    stocksDataSink.add(Response.loading("Getting company market details"));
    try{
      StocksModel stocks = await _stocksRepository.fetchStocksData(category);
      stocksDataSink.add(Response.completed(stocks));
    } catch(e){
      stocksDataSink.add(Response.error(e.toString()));
    }
  }

  dispose(){
    _streamController.close();
  }
}
