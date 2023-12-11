class CompanyCodeList {
  List<CompanyDetails> companies;

  CompanyCodeList({
    this.companies,
  });

  factory CompanyCodeList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      return CompanyCodeList(
        companies: (json['data'] as List)
            .map((i) => CompanyDetails.fromJson(i))
            .toList(),
      );
    } else {
      // Handle the case where 'data' is null or not available.
      return CompanyCodeList(companies: []);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> companies = <String, dynamic>{};
    if (this.companies != null) {
      companies['data'] = this.companies.map((v) => v.toJson()).toList();
    }
    return companies;
  }
}

List<CompanyCodeList> companyList = [];

class CompanyDetails {
  final String companyCode;
  final String companyName;

  CompanyDetails({
    this.companyCode,
    this.companyName,
  });

  factory CompanyDetails.fromJson(Map<String, dynamic> json) {
    return CompanyDetails(
      companyCode: json['symbol'],
      companyName: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = companyName;
    data['symbol'] = companyCode;
    return data;
  }
}

class StocksInfo {
  final String companyName;
  final String companyCode;
  final String companyLogo;

  StocksInfo({
    this.companyName,
    this.companyCode,
    this.companyLogo,
  });
}

List<StocksInfo> stocks = [
  StocksInfo(
    companyName: "Apple",
    companyCode: "AAPL",
    companyLogo: "assets/logo/apple.jpeg",
  ),
  StocksInfo(
    companyName: "Amazon",
    companyCode: "AMZN",
    companyLogo: "assets/logo/amazon.png",
  ),
  StocksInfo(
    companyName: "Google",
    companyCode: "GOOG",
    companyLogo: "assets/logo/google.jpeg",
  ),
  StocksInfo(
    companyName: "H&M",
    companyCode: "HNNMY",
    companyLogo: "assets/logo/handm.png",
  ),
  StocksInfo(
    companyName: "Coca-cola",
    companyCode: "KO",
    companyLogo: "assets/logo/download.png",
  ),
  StocksInfo(
    companyName: "Netflix",
    companyCode: "NFLX",
    companyLogo: "assets/logo/netflix.png",
  ),
  StocksInfo(
    companyName: "Nvidia",
    companyCode: "NVDA",
    companyLogo: "assets/logo/nvidia.jpeg",
  ),
  StocksInfo(
    companyName: "Pepsico",
    companyCode: "PEP",
    companyLogo: "assets/logo/pepsi.png",
  ),
  StocksInfo(
    companyName: "Ferrari",
    companyCode: "RACE",
    companyLogo: "assets/logo/ferari.png",
  ),
  StocksInfo(
    companyName: "Tesla",
    companyCode: "TSLA",
    companyLogo: "assets/logo/tesla.jpeg",
  ),
   StocksInfo(
    companyName: "Flipkart",
    companyCode: "FLP",
    companyLogo: "assets/logo/flipkart.png",
  ),
     StocksInfo(
    companyName: "Reliance",
    companyCode: "RLC",
    companyLogo: "assets/logo/reliance.jpeg",
  ),
     StocksInfo(
    companyName: "Tata",
    companyCode: "TT",
    companyLogo: "assets/logo/tata.png",
  ),

];