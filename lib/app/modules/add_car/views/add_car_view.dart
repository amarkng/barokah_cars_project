import 'package:barokah_cars_project/app/modules/add_car/views/widgets/added_a_car.dart';
import 'package:barokah_cars_project/app/modules/car_news/controllers/car_news_controller.dart';
import 'package:barokah_cars_project/app/modules/home/controllers/home_controller.dart';
import 'package:barokah_cars_project/app/modules/home/views/widgets/car_detail_page.dart';
import 'package:barokah_cars_project/app/modules/home/views/widgets/home_header.dart';
import 'package:barokah_cars_project/app/modules/profile_screen/controllers/profile_screen_controller.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddCarView extends GetView<CarNewsController> {
  const AddCarView({super.key});
  
  @override
  Widget build(BuildContext context) {
  final DatabaseReference databaseReference = FirebaseDatabase.instance.ref().child('cars');
  final ProfileScreenController profileScreenController = Get.put(ProfileScreenController());
    final HomeController controller = Get.put(HomeController());
    return Scaffold(
      backgroundColor: const Color(0xFFF2F1F6),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const BaroHomeHeader(),
                const SizedBox(height: 36,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Your List Cars", style: GoogleFonts.plusJakartaSans(textStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black)),),
                    GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AddCarWidget())),
                      child: Container(
                        width: 75,
                        height: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xFFE82027)
                        ),
                        child: Text("Add Cars", style: GoogleFonts.plusJakartaSans(textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFFFFFFFF))),),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 24,),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Divider(
                        color: Colors.black, 
                        thickness: 0.5, 
                        indent: 5, 
                        endIndent: 5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16,),
            
                Obx(() {
                  if (controller.filteredCars.isEmpty) {
                    return const Center(child: Text('No cars found'));
                  }

                  // Data dibagi du bagian
                  int halfLength = (controller.filteredCars.length / 2).ceil();
                  List<Map<String, dynamic>> cars1 = controller.filteredCars.sublist(0, halfLength);
                  List<Map<String, dynamic>> cars2 = controller.filteredCars.sublist(halfLength);

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children: cars1.map((car) {
                            return GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => CarDetailPage(car: car,)));
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Center(
                                  child: Container(
                                    width: double.infinity,
                                    height: 170,
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color(0xFFE82027),
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: car['image'] != null
                                            ? Image.network(car['image'], width: 190, height: 80, fit: BoxFit.cover)
                                            : const CircleAvatar(child: Icon(Icons.car_rental)),
                                        ),
                                        const SizedBox(width: 8),
                                                                              Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(height: 4,),
                                                Text(car['model'] ?? 'Unknown', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                                Text(car['merk'] ?? 'Unknown', style: const TextStyle(color: Colors.grey)),
                                              ],
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: car['kondisi'] == 'Bekas' ? Colors.blue : Colors.red,
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: Text(
                                                car['kondisi'] ?? 'Unknown', 
                                                style: const TextStyle(
                                                  color: Colors.white
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Price: Rp${car['harga'] ?? 'N/A'}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(width: 8,),
                      Expanded(
                        child: Column(
                          children: cars2.map((car) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => CarDetailPage(car: car,)));
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Center(
                                  child: Container(
                                    width: double.infinity,
                                    height: 170,
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color(0xFFE82027),
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: car['image'] != null
                                            ? Image.network(car['image'], width: 190, height: 80, fit: BoxFit.cover)
                                            : const CircleAvatar(backgroundColor: Color(0xFFE82027), foregroundColor: Colors.white,child: Icon(FluentIcons.vehicle_car_20_regular),),
                                        ),
                                        const SizedBox(width: 8),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(height: 4),
                                                Text(car['model'] ?? 'Unknown', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                                Text(car['merk'] ?? 'Unknown', style: const TextStyle(color: Colors.grey)),
                                              ],
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: car['kondisi'] == 'Bekas' ? Colors.blue : Colors.red,
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: Text(
                                                car['kondisi'] ?? 'Unknown', 
                                                style: const TextStyle(
                                                  color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Price: Rp${car['harga'] ?? 'N/A'}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}