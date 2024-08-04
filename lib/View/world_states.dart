import 'package:covid_19_tracker_app/Services/states_services.dart';
import 'package:covid_19_tracker_app/View/countries_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import '../Model/WorldStatesModel.dart';

class WorldStates extends StatefulWidget {
  const WorldStates({super.key});

  @override
  State<WorldStates> createState() => _WorldStatesState();
}

class _WorldStatesState extends State<WorldStates>  with TickerProviderStateMixin{
  late final AnimationController _controller =AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this)..repeat();

  @override
  void dispose(){
    super.dispose();
    _controller.dispose();
  }

  final colorList=<Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices=StatesServices();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height *.01,),
                FutureBuilder(
                    future: statesServices.fecthWorldStatesRecords(),
                    builder: (context,AsyncSnapshot<WorldStatesModel> snapshot){
                    if(!snapshot.hasData){
                      return Expanded(
                      child: SpinKitFadingCircle(
                        color: Colors.black,
                        size: 50,
                        controller: _controller,
                      ),
                      );
                    }else{
                      return Column(
                        children: [
                          PieChart(
                            dataMap: {
                              "Total":double.parse(snapshot.data!.cases!.toString()),
                              "Recover":double.parse(snapshot.data!.recovered!.toString()),
                              "Deaths":double.parse(snapshot.data!.deaths!.toString()),

                            },
                            chartValuesOptions: const ChartValuesOptions(
                              showChartValuesInPercentage: true,
                            ),
                            chartRadius: MediaQuery.of(context).size.width/2.2,
                            legendOptions: const LegendOptions(
                              legendPosition: LegendPosition.left,
                            ),

                            animationDuration:  const Duration(milliseconds: 1200),
                            chartType: ChartType.ring,
                            colorList: colorList,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical:MediaQuery.of(context).size.height *.06 ),
                            child: Card(
                              child: Column(
                                children: [
                                  ReusavbleRow(title: 'Aditya', value: snapshot.data!.cases!.toString()),
                                  ReusavbleRow(title: 'Recovered', value: snapshot.data!.recovered!.toString()),
                                  ReusavbleRow(title: 'Deaths', value: snapshot.data!.deaths!.toString()),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap:(){
                               Navigator.push(context, MaterialPageRoute(builder: (context)=> const CountriesListScreen()));
                           },
                            child: Container(
                              height: 50,
                              decoration:  BoxDecoration(
                                  color: const Color(0xff1aa260),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: const Center(
                                child: Text('Track  Countries'),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
              }
              ),

            ],
          ),
        ),
      ),
    );
  }
}


class ReusavbleRow extends StatelessWidget {
  String title,value;
    ReusavbleRow({super.key,required this.title,required this.value});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(left: 10,right:10,top: 10,bottom: 10),
      child: Column(

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title),
                Text(value),
              ],
          ),
          SizedBox(height: 5,)
         
        ],
      ),
    );
  }
}
