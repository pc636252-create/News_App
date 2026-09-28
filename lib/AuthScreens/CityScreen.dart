import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/city_Controller.dart';

class CitySelectionScreen extends GetView<CityController>{
  const CitySelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.lightBlue.shade200, width: 1.5),
                ),
                child: TextField(
                  controller: controller.searchController,
                  decoration: const InputDecoration(
                    hintText: "Search your city",
                    prefixIcon: Icon(Icons.search, color: Colors.black54),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ),


            Expanded(
              child: Obx(() {
                final cities = controller.filteredCities;

                if (cities.isEmpty) {
                  return const Center(child: Text("No cities match your search."));
                }
                return ListView.builder(
                  itemCount: cities.length,
                  itemBuilder: (context, index) {
                    final city = cities[index];

                    return Obx(() {
                      final isSelected = controller.selectedCity.value == city;

                      return GestureDetector(
                        onTap: () => controller.selectCity(city),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                          color: isSelected ? Colors.lightBlue.shade400 : Colors.transparent,
                          child: Row(
                            children: [
                              Icon(
                                Icons.navigation_outlined,
                                color: isSelected ? Colors.white : Colors.black45,
                                size: 20,
                              ),
                              const SizedBox(width: 16),
                              Text(
                                city,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: isSelected ? Colors.white : Colors.black87,
                                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
                  },
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: controller.navigateToNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue.shade400,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    "Next",
                    style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
