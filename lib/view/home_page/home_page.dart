import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:stafflink/app_constants/app_constants.dart';
import 'package:stafflink/widgets/employee_list_header.dart';
import 'package:stafflink/widgets/employee_tile.dart';

import '../../app_constants/files.dart';
import '../../controller/app_controller.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/float_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final appController = Get.put(AppMainController());

  @override
  void initState() {
    super.initState();
    appController.setDatabase();
    appController.getData().then((value) => stopLoading());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppMainController>(builder: (logic) {
      return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: PrimaryAppBar(
              appBarText: 'Employee List',
            )),
        body: appController.initialDataLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                  strokeWidth: 2,
                ),
              )
            : appController.data.isEmpty
                ? Center(
                    child: SvgPicture.asset(
                      noData,
                    ),
                  )
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const EmployeeListHeader(
                          headerText: 'Current employees',
                        ),
                        FutureBuilder(
                          future: appController.getData(),
                          builder: (BuildContext context, snapshot) {
                            if (snapshot.hasData) {
                              appController.data =
                                  snapshot.data as List<Map<String, dynamic>>;
                              return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: appController.data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return EmployeeTile(
                                      employee: appController.data[index],
                                      index: index,
                                    );
                                  });
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator(
                                color: primaryColor,
                                strokeWidth: 2,
                              ));
                            }
                          },
                        ),
                        const EmployeeListHeader(
                          headerText: 'Previous employees',
                        ),
                        FutureBuilder(
                          future: appController.getPreviousData(),
                          builder: (BuildContext context, snapshot) {
                            if (snapshot.hasData) {
                              appController.previousData =
                                  snapshot.data as List<Map<String, dynamic>>;
                              return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: appController.previousData.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return PreviousEmployeeTile(
                                      employee:
                                          appController.previousData[index],
                                      index: index,
                                    );
                                  });
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator(
                                color: primaryColor,
                                strokeWidth: 2,
                              ));
                            }
                          },
                        ),
                      ],
                    ),
                  ),
        // Center(
        //   child: SvgPicture.asset(
        //     noData,
        //   ),
        // ),
        floatingActionButton: const FloatButton(),
      );
    });
  }

  stopLoading() {
    appController.initialDataLoading = false;
    appController.update();
  }
}
