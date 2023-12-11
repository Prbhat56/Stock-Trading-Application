import 'Data.dart';

class StocksModel {
    List<Data> data;

    StocksModel({this.data});

    factory StocksModel.fromJson(Map<String, dynamic> json) {
        return StocksModel(
            data: json['data'] != null ? (json['data'] as List).map((i) => Data.fromJson(i)).toList() : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        if (this.data != null) {
            data['data'] = this.data.map((v) => v.toJson()).toList();
        }
        return data;
    }
}