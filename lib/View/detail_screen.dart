import 'package:covid_19_tracker_app/View/world_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class DetailScreen extends StatefulWidget {
  String image ;
  String name;
  int totalCases,totalDeaths,totalRecovered,active,critical,todayRecovered,tests;
   DetailScreen({
    super.key,
    required this.name,
    required this.image,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.tests,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
         mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment:Alignment.center,
            children: [
              Padding(
                padding:EdgeInsets.only(top: MediaQuery.of(context).size.height* .067),
                child: Card(
                  child: Column(
                    children: [
                           SizedBox(height:MediaQuery.of(context).size.height* .06 ,),
                           ReusavbleRow(title: 'Country', value: widget.name.toString()),
                           ReusavbleRow(title: 'Cases', value: widget.totalCases.toString()),
                           ReusavbleRow(title: 'TotalRecovered', value: widget.totalRecovered.toString()),
                           ReusavbleRow(title: 'TotalDeaths', value: widget.totalDeaths.toString()),
                           ReusavbleRow(title: 'Active', value: widget.active.toString()),
                           ReusavbleRow(title: 'Critical', value: widget.critical.toString()),
                           ReusavbleRow(title: 'TodayRecovered', value: widget.todayRecovered.toString()),
                           ReusavbleRow(title: 'Tests', value: widget.tests.toString()),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          ),
        ],
      ),
    );
  }
}
