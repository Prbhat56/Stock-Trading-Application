import '../constants.dart';
import '../helper/ApiPovider.dart';
import '../models/stockModel/stocksModel.dart';

class StocksRepository{
  final ApiProvider _provider = ApiProvider();

  Future<StocksModel> fetchStocksData(String company) async{
    final response = await _provider.get(apiUrlEod+company);
    return StocksModel.fromJson(response);
  }
}