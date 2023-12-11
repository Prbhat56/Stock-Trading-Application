class Data {
  double open;
  double adjClose;
  double adjHigh;
  double adjLow;
  double adjOpen;
  double adjVolume;
  double close;
  DateTime date;
  double dividend;
  String exchange;
  double high;
  double low;
  double splitFactor;
  String symbol;
  double volume;

  Data({
    this.open,
    this.adjClose,
    this.adjHigh,
    this.adjLow,
    this.adjOpen,
    this.adjVolume,
    this.close,
    this.date,
    this.dividend,
    this.exchange,
    this.high,
    this.low,
    this.splitFactor,
    this.symbol,
    this.volume,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      open: json['open'],
      adjClose: json['adj_close'],
      adjHigh: json['adj_high'],
      adjLow: json['adj_low'],
      adjOpen: json['adj_open'],
      adjVolume: json['adj_volume'],
      close: json['close'],
      date: json["date"]!=null?DateTime.parse(json["date"],):null,
      dividend: json['dividend'],
      exchange: json['exchange'],
      high: json['high'],
      low: json['low'],
      splitFactor: json['split_factor'],
      symbol: json['symbol'],
      volume: json['volume'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['open'] = open;
    data['adj_close'] = adjClose;
    data['adj_high'] = adjHigh;
    data['adj_low'] = adjLow;
    data['adj_open'] = adjOpen;
    data['adj_volume'] = adjVolume;
    data['close'] = close;
    data['date'] = date;
    data['dividend'] = dividend;
    data['exchange'] = exchange;
    data['high'] = high;
    data['low'] = low;
    data['split_factor'] = splitFactor;
    data['symbol'] = symbol;
    data['volume'] = volume;
    return data;
  }
}
