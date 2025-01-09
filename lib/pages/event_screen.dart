import 'package:flutter/material.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  final List<TextEditingController> brideControllers =
  List.generate(6, (index) => TextEditingController());
  final List<TextEditingController> groomControllers =
  List.generate(6, (index) => TextEditingController());

  @override
  void initState() {
    super.initState();
    // Use addPostFrameCallback to execute actions after layout is complete.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Any actions that depend on the layout phase completion can be placed here.
    });
  }

  Widget buildInputText(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$label:',
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            TextField(
              controller: controller,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                isDense: true,
                contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(
                    color: Colors.purple
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInput(TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          controller: controller,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            isDense: true,
            contentPadding:
            const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(
                    color: Colors.purple
                )
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey[900], // Background color grey
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0), // Border radius
          borderSide: BorderSide.none, // No border line
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.blue, width: 2.0), // Border when focused
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.grey, width: 1.0), // Border when not focused
        ),
      ),
    );
  }

  Widget buildSection(
      String title, String imagePath, List<TextEditingController> controllers) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 25),
          ),
          const SizedBox(height: 10),
          CircleAvatar(
            backgroundImage: AssetImage(imagePath),
            backgroundColor: Colors.amber,
            radius: 40,
          ),
          Form(
            child: Column(
              children: [
                const SizedBox(height: 10),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Name',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    buildTextField('First Name', controllers[0]),
                    const SizedBox(width: 10),
                    buildTextField('Last Name', controllers[1]),
                  ],
                ),
                const SizedBox(height: 10),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Parents Name',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    buildTextField('Mother Name', controllers[2]),
                    const SizedBox(width: 10),
                    buildTextField('Father Name', controllers[3]),
                  ],
                ),
                const SizedBox(height: 10),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Grand Parents Name',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    buildTextField('Grand Father Name', controllers[4]),
                    const SizedBox(width: 10),
                    buildTextField('Grand Mother Name', controllers[5]),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.arrow_back_ios_new),
            Image.asset(
              'assets/Icon.png',
              width: 144,
              height: 39,
            ),
            Text(
              'Need Help ?',
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(153, 153, 153, 1)),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   '1. Create Event',
                //   style: TextStyle(
                //     fontFamily: 'Roboto',
                //     fontSize: 18,
                //     fontWeight: FontWeight.w400,
                //     color: Color.fromRGBO(109, 81, 206, 1),
                //   ),
                // ),
                // SizedBox(
                //   height: 12,
                // ),
                // // Container(child: buildSection('Groom', 'assets/Male_image', groomControllers)),
                // // Container(child: buildSection('Bride', 'assets/Female_image', brideControllers)),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     buildInputText('Groom', groomControllers[0]),
                //     buildInputText('Bride', brideControllers[0]),
                //   ],
                // ),
                // SizedBox(height: 24,),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Text(
                //     'Choose Your Side',
                //     style: TextStyle(
                //       color: Color.fromRGBO(153, 153, 153, 1),
                //       fontWeight: FontWeight.w400
                //     ),
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Container(
                //         width: 133,
                //         height: 56,
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(12),
                //           border: Border.all(width: 1,color: Color.fromRGBO(210, 210, 210, 1)),
                //         ),
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             Image.asset(
                //               'assets/Male_image.png',
                //               width: 36,
                //               height: 37,
                //             ),
                //             Padding(
                //               padding: const EdgeInsets.all(8.0),
                //               child: Text(
                //                 'Ladke\nWale'
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //       Text(
                //         'or',
                //         style: TextStyle(
                //           fontSize: 16,
                //           color: Color.fromRGBO(153, 153, 153, 1),
                //         ),
                //       ),
                //       Container(
                //         width: 133,
                //         height: 56,
                //         alignment: Alignment.center,
                //         decoration: BoxDecoration(
                //           color: Color.fromRGBO(109, 81, 206, 0.12),
                //           borderRadius: BorderRadius.circular(12),
                //           border: Border.all(width: 1,color: Color.fromRGBO(109, 81, 206, 1)),
                //         ),
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             Image.asset(
                //                 'assets/Female_image.png',
                //               width: 36,
                //               height: 37,
                //             ),
                //             Padding(
                //               padding: const EdgeInsets.all(8.0),
                //               child: Text(
                //                 'Ladki\nWale',
                //                 style: TextStyle(
                //                   fontSize: 14,
                //                   color: Color.fromRGBO(109, 81, 206, 1),
                //                 ),
                //               ),
                //             ),
                //           ],
                //         ),
                //       )
                //     ],
                //   ),
                // ),
                buildEventComplete('Event Created', 'Ayush weds Netali | 21st June 2025'),
                // SizedBox(height: 23,),
                // buildBrideAndGroom(),
                SizedBox(height: 24),
                buildEventComplete('Bride & Groom Details', 'Bride & Groom family details added'),
            Text(
                '3. Event Details',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(109, 81, 206, 1),
                ),
              ),
                SizedBox(height: 12,),
                buildEventDetails('Mehendi  ', ' 21st June 2024 | 4:00 PM Onwards ', "Venue - delete it. close. this generator's\n current url is: venue. to change it, just enter a"),
                SizedBox(height: 12,),
                buildEventDetails('Sangeet', ' 21st June 2024 | 4:00 PM Onwards ', "Venue - delete it. close. this generator's\n current url is: venue. to change it, just enter a"),
                SizedBox(height: 12,),
                Center(
                  child: Container(
                    width: 117,
                    height: 49,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(245, 245, 245, 1),
                      border: Border.all(
                        color: Color.fromRGBO(114, 114, 114, 0.4),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                            Icons.add_circle_outline_outlined,
                          size: 18,
                          color: Color.fromRGBO(150, 150, 150, 1),
                        ),
                        SizedBox(width: 2,),
                        Text(
                          'Add event',
                          style: TextStyle(
                            fontFamily: 'Popins',
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: Color.fromRGBO(114, 114, 114, 0.72),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 48,),
                buildEventBar('2','Bride & Groom Details'),
                SizedBox(height: 25,),
                buildEventBar('3','Event Details'),
                SizedBox(height: 25,),
                buildEventBar('4','Song & Caricature'),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: buildBottomNext(),
    );
  }

  Widget buildEventBar(String num, String title){
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(250, 250, 250, 1),
          borderRadius: BorderRadius.circular(8),
          border:Border.all( color: Color.fromRGBO(232, 232, 232, 1)),
        ),
        width: 371,
        height: 83,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                width: 43,
                height: 43,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: Color.fromRGBO(232, 232, 232, 1)
                  )
                ),
                child: Center(
                  child: Text(
                      '${num}',
                    style: TextStyle(
                      color: Color.fromRGBO(109, 81, 206, 1)
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12,),
              Text(
                '$title',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  color: Color.fromRGBO(135, 135, 135, 1),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEventComplete(String title,String description){
    return Container(
      width: 371,
      height: 83,
      decoration: BoxDecoration(
        color: Color.fromRGBO(250, 250, 250, 1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color.fromRGBO(232, 232, 232, 1))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 36,
            height: 36,
            child: Icon(
                Icons.check,
              color: Colors.white,
            ),
            decoration: BoxDecoration(
              color: Color.fromRGBO(109, 81, 206, 1),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$title',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Color.fromRGBO(135, 135, 135, 1)
                ),
              ),
              Text(
                '$description',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Color.fromRGBO(153, 153, 153, 1),
                ),
              ),
            ],
          ),
          Icon(Icons.keyboard_arrow_down,size: 25,)
        ],
      ),
    );
  }

  Widget buildBrideAndGroom(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(
            '2. Bride & Groom Details',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Color.fromRGBO(109, 81, 206, 1),
            ),
          ),
            SizedBox(height: 24,),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                              Image.asset(
                                'assets/Female_image.png',
                                width: 40,
                                height: 41,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Bride's Details",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color.fromRGBO(148, 148, 148, 1)
                                  ),
                                ),
                              ),
                  ],
                ),
              ),
            ),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildInput(brideControllers[1]),
              buildInput(brideControllers[2]),
            ],
          ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildInput(brideControllers[3]),
                buildInput(brideControllers[4]),
              ],
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/Male_image.png',
                      width: 40,
                      height: 41,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Groom's Details",
                        style: TextStyle(
                            fontSize: 16,
                            color: Color.fromRGBO(148, 148, 148, 1)
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildInput(groomControllers[1]),
                buildInput(groomControllers[2]),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildInput(groomControllers[3]),
                buildInput(groomControllers[4]),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEventDetails(String title,String date,String venue){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            width: 2,
            height: 153,
            decoration: BoxDecoration(
              color: Color.fromRGBO(109, 81, 206, 1)
            ),
          ),
          SizedBox(width: 8,),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$title',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(135, 135, 135, 1)
                  ),
                ),
                Text(
                  '$date',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(135, 135, 135, 1)
                  ),
                ),
                Text(
                  "$venue",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(135, 135, 135, 1)
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 41,
                      height: 41,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 0, 0, 0.1),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Icon(
                        Icons.delete_outline,
                        size: 21,
                      ),
                    ),
                    SizedBox(width: 44,),
                    Row(
                      children: [
                        Container(
                          width: 41,
                          height: 41,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(109, 81, 206, 0.16),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Icon(
                            Icons.edit,
                            size: 21,
                          ),
                        ),
                        SizedBox(width: 12,),
                        Text(
                          'Edit',
                          style: TextStyle(
                            color: Color.fromRGBO(109, 81, 206, 1),
                              fontSize: 15,
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBottomNext() {
    return Container(
      height: 190,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,  // Added space between containers
        children: [
          Container(
            width: 424,
            height: 92,
            decoration: BoxDecoration(
              border: Border.all(
                color: Color.fromRGBO(203, 203, 203, 1),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: 92,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,  // Center the button within the Row
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 117,
                  height: 49,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(245, 245, 245, 1),
                    border: Border.all(
                      color: Color.fromRGBO(114, 114, 114, 0.4),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Skip',
                        style: TextStyle(
                          fontFamily: 'Popins',
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          color: Color.fromRGBO(114, 114, 114, 0.72),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 117,
                  height: 49,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(109, 81, 206, 1),
                    border: Border.all(
                      color: Color.fromRGBO(214, 214, 214, 1),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Next',
                        style: TextStyle(
                          fontFamily: 'Popins',
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(
                        Icons.arrow_circle_right_outlined,
                        size: 23,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
