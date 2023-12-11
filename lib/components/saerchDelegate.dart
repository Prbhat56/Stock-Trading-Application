
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/tickerModel/tickers.dart';

class CustomSearchDelegate extends SearchDelegate {

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        splashColor: Colors.transparent,
        icon: const Icon(
          Icons.clear,
          size: 30,
        ),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      splashColor: Colors.transparent,
      icon: const Icon(
        Icons.arrow_back,
        size: 30,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {

    if (query.length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Center(
            child: Text(
              "Search term must be longer than two letters",
            ),
          )
        ],
      );
    }

    List<CompanyCodeList> matchQuery = [];

    for (CompanyCodeList company in companyList) {
      if (company.companies.map((e) => e.companyName).toString().toLowerCase().contains(query.toLowerCase()) | company.companies.map((e) => e.companyCode).toString().toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(company);
      }
    }
    return ListView.separated(
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          onTap: (){},
          title: Text(
            result.companies[index].companyCode,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            result.companies[index].companyName,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
        );
      },
      itemCount: matchQuery.length,
      separatorBuilder: (context, index){
        return const SizedBox(
          height: 10,
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<CompanyCodeList> matchQuery = [];

    for (CompanyCodeList company in companyList) {
      if (company.companies.map((e) => e.companyCode).toString().toLowerCase().contains(query.toLowerCase()) | company.companies.map((e) => e.companyCode).toString().toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(company);
      }
    }

    return ListView.separated(
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          onTap: (){},
          title: Text(
            result.companies[index].companyCode,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            result.companies[index].companyName,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
        );
      },
      itemCount: matchQuery.length,
      separatorBuilder: (context, index){
        return const SizedBox(
          height: 10,
        );
      },
    );
  }
}