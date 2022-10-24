import 'package:agriapp/constants/constraints.dart';
import 'package:agriapp/models/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var userModel = Provider.of<UserModel>(context);
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kPrimaryColordark,
        elevation: 0,
        title: const Text('Privacy Policy'),
      ),
      body: SingleChildScrollView(
          child: SizedBox(
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Card(
                elevation: 0,
                // color: Colors.transparent,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 20,
                      bottom: 10,
                      left: size.width * 0.05,
                      right: size.width * 0.05),
                  child: Column(
                    children: [
                      Text(
                        "Smart Mobile Tech built thenAgri app as a Free app. This page is used to inform visitors regarding our policies with the collection, use, and disclosure of personal information if anyone decided to use our Service.\n\nIf you choose to use our Service, then you agree to the collection and use of information in relation to this policy. The personal information that we collect is used for providing and improving the Service. We will not use or share your information with anyone except as described in this Privacy Policy.",
                        style: TextStyle(
                          fontSize: size.width * 0.039,
                          fontWeight: FontWeight.w400,
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 12,
                          bottom: 5,
                        ),
                        child: Row(
                          children: [
                            Text(
                              "Information Collection and Use",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: size.width * 0.041,
                                fontWeight: FontWeight.w600,
                                color: Colors.black.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "For a better experience, while using our Service, we may require you to provide us with certain personally identifiable information. The information that we request will be retained by us and used as described in this privacy policy. The app does use third party services that may collect information used to identify you. Link to privacy policy of third party service providers used by the app are listed below.",
                        style: TextStyle(
                          fontSize: size.width * 0.039,
                          fontWeight: FontWeight.w400,
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 12,
                          bottom: 5,
                        ),
                        child: Row(
                          children: [
                            Text(
                              "Log Data",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: size.width * 0.041,
                                fontWeight: FontWeight.w600,
                                color: Colors.black.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "We want to inform you that whenever you use our Service, in case of an error in the app we collect data and information (through third party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (\"IP\") address, device name, operating system version, the configuration of the app when utilizing our Service, the time and date of your use of the Service, and other statistics.",
                        style: TextStyle(
                          fontSize: size.width * 0.039,
                          fontWeight: FontWeight.w400,
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 12,
                          bottom: 5,
                        ),
                        child: Row(
                          children: [
                            Text(
                              "Data Collection",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: size.width * 0.041,
                                fontWeight: FontWeight.w600,
                                color: Colors.black.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        " All primary account data are collected for the purpose of a smooth user experience and app functionality.",
                        style: TextStyle(
                          fontSize: size.width * 0.039,
                          fontWeight: FontWeight.w400,
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 12,
                          bottom: 5,
                        ),
                        child: Row(
                          children: [
                            Text(
                              "Cookies",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: size.width * 0.041,
                                fontWeight: FontWeight.w600,
                                color: Colors.black.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device's internal memory. This Service does not use these \"cookies\" explicitly. However, the app may use third party code and libraries that use \"cookies\" to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service.",
                        style: TextStyle(
                          fontSize: size.width * 0.039,
                          fontWeight: FontWeight.w400,
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
