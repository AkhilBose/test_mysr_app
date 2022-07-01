import 'package:flutter/material.dart';
import 'package:test_mysr_app/contants.dart';
import 'package:test_mysr_app/models/listed_car.dart';
import 'package:test_mysr_app/ui_elements/size_config.dart';

class ListCard extends StatelessWidget {
  final ListedCar? listedCar;
  const ListCard({Key? key, this.listedCar}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
          width: SizeConfig.blockSizeHorizontal! * 60,
          margin: const EdgeInsets.only(right: 20.0),
          //padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: const Color(0xffffffff)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      "https://images.pexels.com/photos/112460/pexels-photo-112460.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                      width: double.infinity,
                      height: 140,
                      fit: BoxFit.fitWidth,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            color: kPrimaryColor,
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Text(
                "${listedCar!.cName}",
                style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: const Color(0xFF1F2937)),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 3,
                            ),
                            Expanded(
                              child: Text(
                                "in ${listedCar!.cVariant}",
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 9,
                                    color: const Color(0xFF898989)),
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Expanded(
                              child: Text(
                                "₹${listedCar!.cPrice.toString()}",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    color: const Color(0xFF1F2937)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              primary: kButtonPrimaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50))),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(
                                Icons.share_outlined,
                                size: 20,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(bottom:10),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Flexible(
              //         child: DecoratedBox(
              //           decoration: const BoxDecoration(color: Color(0xFF32A636),borderRadius: BorderRadius.all(Radius.circular(5))),
              //           child: Padding(
              //             padding: const EdgeInsets.only(left:4.0,right: 4.0,top: 2,bottom:2),
              //             child: Text(
              //               "${property!.pSubCategory}",
              //               style: TextStyle(
              //                   overflow: TextOverflow.ellipsis,
              //                   fontWeight: FontWeight.w600,
              //                   fontSize: 9.sp,
              //                   color: Colors.white),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => CommonVideoPage(
          //         doc: property, type: "RESOURCES", startFrom: 0.0),
          //   ),
          // );
        });
  }
}
