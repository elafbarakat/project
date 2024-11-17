import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/config.dart';
// import '../../models/user.dart';
import '../../providers/city_provider.dart';
import '../../providers/user_provider.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context).getUser;
    var cities = Provider.of<CityProvider>(context).getCities;

    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Padding(
              //   padding: const EdgeInsets.all(4.0),
              //   child: ClipRRect(
              //     borderRadius:
              //         // BorderRadius.only(topLeft: Radius.circular(100)),
              //         BorderRadius.circular(200),
              //     child: Card(
              //       // borderOnForeground: true,
              //       shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(100)),
              //       color: Colors.transparent,
              //       shadowColor: Colors.transparent,
              //       child:
              Image.network(
                personlImagePath + 'personalImagee1704571442.jpg',
                width: 150,
                height: 150,
              ),
              //   ),
              // ),
              Table(
                border: const TableBorder(
                  top: BorderSide(color: Colors.blue),
                  bottom: BorderSide(color: Colors.blue),
                  left: BorderSide(color: Colors.blue),
                  right: BorderSide(color: Colors.blue),
                ),
                // textDirection: TextDirection.rtl,

                children: [
                  TableRow(
                    decoration: const BoxDecoration(
                      color: Colors.blueGrey,
                    ),
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Text(
                          'First name ',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          '${user.firstName}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    decoration: BoxDecoration(
                      color: Colors.blue[500]!,
                    ),
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Text(
                          'last name ',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          '${user.lastName}',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                    ),
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Text(
                          'Full english name ',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          '${user.form.english_fullName}',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Text('Father name '),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text('${user.fatherName}'),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Text(
                          'Mother name ',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          '${user.motherName}',
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Text(
                          'birth Date ',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          '${user.birthDate}'.substring(0, 10),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Text(
                          'City ',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          cities
                              .firstWhere(
                                  (element) => element.cityId == user.cityId)
                              .cityName[context.locale.languageCode],
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Text(
                          'constraint',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          '${user.constraint}',
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Text(
                          'ID number',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          '${user.idNumber}',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
