import 'package:flutter/material.dart';
import 'package:test_mysr_app/contants.dart';
import 'package:test_mysr_app/models/listed_car.dart';
import 'package:test_mysr_app/ui_elements/listing_card.dart';
import 'package:test_mysr_app/ui_elements/size_config.dart';

import '../ui_elements/vertical_tab.dart';

class Garage extends StatefulWidget {
  const Garage({Key? key}) : super(key: key);

  @override
  _GarageState createState() => _GarageState();
}

class _GarageState extends State<Garage> with TickerProviderStateMixin {
  final List data = [
    "All Listing",
    "Hyundai",
    "Volvo",
    "Audi",
    "Mitsubishi",
    "Chevrolet"
  ];
  //these are Company names
  //Todo: need to change this dummy data to actual data from firebase
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: data.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    //tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(110),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: const Text('Acme\'s Garage',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                    color: Colors.black)),
            bottom: TabBar(
              controller: tabController,
              onTap: (index) {
                VerticalScrollableTabBarStatus.setIndex(index);
              },
              indicator: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: kButtonPrimaryColor,
                  ),
                  borderRadius: BorderRadius.circular(10), // Creates border
                  color: Colors.white),
              padding: const EdgeInsets.only(left: 20, bottom: 7),
              isScrollable: true,
              tabs: const [
                //Tabs must be generated according to the database values ie company names
                Tab(
                    child: Text(
                  'All Listings',
                  style: TextStyle(color: Colors.black),
                )),
                Tab(
                    child: Text(
                  'Hyundai',
                  style: TextStyle(color: Colors.black),
                )),
                Tab(
                    child: Text(
                  'Volvo',
                  style: TextStyle(color: Colors.black),
                )),
                Tab(
                    child: Text(
                  'Audi',
                  style: TextStyle(color: Colors.black),
                )),
                Tab(
                    child: Text(
                  'Mitsubishi',
                  style: TextStyle(color: Colors.black),
                )),
                Tab(
                    child: Text(
                  'Chevrolet',
                  style: TextStyle(color: Colors.black),
                )),
              ],
            ),
          ),
        ),
        body: VerticalScrollableTabView(
          tabController: tabController,
          eachItemChild: (object, index) {
            return categorySection(heading: object as String);
          },
          verticalScrollPosition: VerticalScrollPosition.begin,
          listItemData: data,
        ));
  }

  categorySection({required String heading}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: '$heading ',
                  style: const TextStyle(
                    fontFamily: 'WorkSans',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const TextSpan(
                  text: '(6)',
                  style: TextStyle(
                    fontFamily: 'WorkSans',
                    color: Color(0xFFB7B7B7),
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          height: 250,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(
                left: 20.0, right: 10, top: 10, bottom: 10),
            itemBuilder: (context, index) {
              return ListCard(
                  listedCar: ListedCar(
                cId: "",
                cName: "Volvo",
                cVariant: "1.5L petrol engine",
                cPrice: 25000,
              ));
            },
            scrollDirection: Axis.horizontal,
            itemCount: 4,
          ),
        )
      ],
    );
  }
}
