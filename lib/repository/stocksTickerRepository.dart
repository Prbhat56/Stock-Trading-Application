import 'package:stock_data_display_app/constants.dart';

import '../helper/ApiPovider.dart';
import '../models/tickerModel/tickers.dart';

class StocksTickerRepository{
  final ApiProvider _provider = ApiProvider();

  Future<CompanyCodeList> fetchTickerData() async{
    final response = await _provider.get(apiUrl);
    return CompanyCodeList.fromJson(response);
  }
}