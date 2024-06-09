import 'package:flutter/material.dart';
import 'package:project/Json_data/List_Sections.dart';
import 'package:project/Pages/Dashboard_page.dart';
import 'package:project/Pages/Home_Page.dart';

class SectionPage extends StatefulWidget {
  const SectionPage({super.key});

  @override
  State<SectionPage> createState() => _SectionPageState();
}

class _SectionPageState extends State<SectionPage> {
  late TextEditingController searchController;
  @override
  void initState() {
    searchController = TextEditingController();
    searchList = section;
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  bool isearch = false;
  List searchList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Sections',
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 25),
                    ),
                  ],
                ),
                TextFormField(
                  controller: searchController,
                  onChanged: (value) {
                    setState(() {
                      isearch = true;
                    });
                    // search for section
                    searchList = section
                        .where((element) => element.contains(value))
                        .toList();
                    print(searchList);
                  },
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(fontSize: 20),
                    suffixIcon: isearch
                        ? InkWell(
                            onTap: () {
                              searchController.clear();
                              setState(() {
                                isearch = false;
                                searchList = section;
                              });
                            },
                            child: Icon(
                              Icons.clear,
                              size: 35,
                            ),
                          )
                        : Icon(
                            Icons.search,
                            size: 35,
                          ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => DashboardPage()));
                  },
                  child: searchList.isEmpty
                      ? Text('No Sections Found',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w900))
                      : Wrap(
                          children: List.generate(
                            searchList.length,
                            (index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, 'SpecilizationPage');
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, bottom: 8),
                                  child: Container(
                                      height: 200,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: index % 2 == 0
                                            ? Color(0xff66280E)
                                            : Color(0xff8B5D49),
                                      ),
                                      child: Center(
                                        child: Text(
                                          searchList[index],
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
                                            fontSize: 25,
                                          ),
                                        ),
                                      )),
                                ),
                              );
                            },
                          ),
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
