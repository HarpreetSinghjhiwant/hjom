// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DetailForm extends StatefulWidget {
  final String cardID;
  const DetailForm({
    Key? key,
    required this.cardID,
  }) : super(key: key);

  @override
  State<DetailForm> createState() => _DetailFormState();
}

class _DetailFormState extends State<DetailForm> {
  bool isSelected = false;
  String weedingDate = '';
  double listHeight = 0;

  // Function to get the ordinal suffix for a day
  String getDayWithSuffix(int day) {
    if (day >= 11 && day <= 13) {
      return "${day}th";
    }
    switch (day % 10) {
      case 1:
        return "${day}st";
      case 2:
        return "${day}nd";
      case 3:
        return "${day}rd";
      default:
        return "${day}th";
    }
  }

  // Function to format date and time
  String formatDateTime(DateTime date, {TimeOfDay? time}) {
    String dayWithSuffix = getDayWithSuffix(date.day);
    String month = DateFormat('MMMM').format(date); // Full month name
    String year = date.year.toString();

    if (time != null) {
      // Assuming `context` is available or pass it as a parameter if required
      String formattedTime =
      time.format(context).toLowerCase(); // Time in am/pm
      return "$dayWithSuffix $month $year, $formattedTime Onwards";
    } else {
      return "$dayWithSuffix $month $year";
    }
  }

  List<Map<String, String>> eventList = []; // List to store event details

  void _showEventDialog({int? index}) {
    final TextEditingController nameController = TextEditingController(
        text: index != null ? eventList[index]['name'] : '');
    final TextEditingController dateController = TextEditingController(
        text: index != null ? eventList[index]['date'] : '');
    final TextEditingController detailsController = TextEditingController(
        text: index != null ? eventList[index]['details'] : '');

    // Future<void> pickDateTime(BuildContext context) async {
    //   // Pick the date
    //   DateTime? pickedDate = await showDatePicker(
    //     context: context,
    //     initialDate: DateTime.now(),
    //     firstDate: DateTime.now(), // Disable past dates
    //     lastDate: DateTime(2100),
    //   );

    //   if (pickedDate != null) {
    //     // Pick the time
    //     TimeOfDay? pickedTime = await showTimePicker(
    //       // ignore: use_build_context_synchronously
    //       context: context,
    //       initialTime: TimeOfDay.now(),
    //     );

    //     if (pickedTime != null) {
    //       final formattedDateTime = formatDateTime(pickedDate, pickedTime);

    //       // Update the controller immediately
    //       dateController.text = formattedDateTime;
    //     }
    //   }
    // }

    Future<void> pickDateTime(BuildContext context) async {
      // Pick the date
      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(), // Disable past dates
        lastDate: DateTime(2100),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: Color(0xff007663), // Header background color
                onPrimary: Colors.white, // Header text color
                onSurface: Colors.black, // Body text color
              ),
            ),
            child: child!,
          );
        },
      );

      if (pickedDate != null) {
        // Pick the time
        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: Color(0xff007663), // Header background color
                  onPrimary: Colors.white, // Header text color
                  onSurface: Colors.black, // Body text color
                ),
              ),
              child: child!,
            );
          },
        );

        if (pickedTime != null) {
          final formattedDateTime =
          formatDateTime(pickedDate, time: pickedTime);

          // Update the controller immediately
          setState(() {
            dateController.text = formattedDateTime;
          });
        }
      }
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(index == null ? 'Enter Event Details' : 'Edit Event'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Event Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: dateController,
                decoration: const InputDecoration(
                  labelText: 'Date and Time',
                  border: OutlineInputBorder(),
                ),
                onTap: () => pickDateTime(context),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: detailsController,
                decoration: const InputDecoration(
                  labelText: 'Venue(Address)',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    detailsController.text.isNotEmpty &&
                    dateController.text.isNotEmpty) {
                  // Ensure date is also not empty
                  setState(() {
                    if (index == null) {
                      // Add new event
                      eventList.add({
                        'name': nameController.text,
                        'date': dateController.text, // Add date
                        'details': detailsController.text,
                      });
                    } else {
                      // Update existing event
                      eventList[index] = {
                        'name': nameController.text,
                        'date': dateController.text, // Update date
                        'details': detailsController.text,
                      };
                    }
                    if (index == null) {
                      listHeight += 410;
                    }
                  });
                  Navigator.pop(context);
                } else {
                  // Optionally show a warning if fields are empty
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('All fields are required!')),
                  );
                }
              },
              child: Text(index == null ? 'Done' : 'Save'),
            ),
          ],
        );
      },
    );
  }

  void validateAndNavigate(finaleventListStirng, cardTextStyleValue) {
    bool isBrideValid = true;
    bool isGroomValid = true;

    // Validate Bride fields (0-3)
    for (int i = 0; i <= 3; i++) {
      if (brideControllers[i].text.trim().isEmpty) {
        isBrideValid = false;
        break;
      }
    }

    // Validate Groom fields (0-3)
    for (int i = 0; i <= 3; i++) {
      if (groomControllers[i].text.trim().isEmpty) {
        isGroomValid = false;
        break;
      }
    }

    if (!isBrideValid || !isGroomValid) {
      // Show an error message
      String errorMessage = '';
      if (!isBrideValid && !isGroomValid) {
        errorMessage =
        'Please fill all required fields for both Bride and Groom.';
      } else if (!isBrideValid) {
        errorMessage = 'Please fill all required fields for the Bride.';
      } else {
        errorMessage = 'Please fill all required fields for the Groom.';
      }

      // Show SnackBar
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text(errorMessage)),
      Fluttertoast.showToast(
        msg: errorMessage,
        toastLength: Toast.LENGTH_LONG,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } else {
      // All fields are valid, navigate to the next page
      String brideGrandDetail = '';
      String groomGrandDetail = '';

      if (groomControllers[4].text != '' && groomControllers[5].text == '') {
        groomGrandDetail = ' GrandSon of \n ${groomControllers[4].text}';
      }
      if (groomControllers[4].text == '' && groomControllers[5].text != '') {
        groomGrandDetail = ' GrandSon of \n ${groomControllers[5].text}';
      }
      if (groomControllers[4].text != '' && groomControllers[5].text != '') {
        groomGrandDetail =
        ' GrandSon of \n ${groomControllers[4].text} & ${groomControllers[5].text}';
      }

      if (brideControllers[4].text != '' && brideControllers[5].text == '') {
        brideGrandDetail = ' Granddaughter of \n ${brideControllers[4].text}';
      }
      if (brideControllers[4].text == '' && brideControllers[5].text != '') {
        brideGrandDetail = ' Granddaughter of \n ${brideControllers[5].text}';
      }
      if (brideControllers[4].text != '' && brideControllers[5].text != '') {
        brideGrandDetail =
        ' Granddaughter of \n ${brideControllers[4].text} & ${brideControllers[5].text}';
      }

      isSelected == false
          ? Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WeddingPageEdit(
                groom:
                '${brideControllers[0].text} ${brideControllers[1].text}',
                gmother: brideControllers[2].text,
                gfather: brideControllers[3].text,
                gGrandFather: brideControllers[4].text,
                gGrandMother: brideControllers[5].text,
                bride:
                '${groomControllers[0].text} ${groomControllers[1].text} ',
                bmother: groomControllers[2].text,
                bfather: groomControllers[3].text,
                bGrandFather: groomControllers[4].text,
                bGrandMother: groomControllers[5].text,
                firstPageDate: weedingDate == ''
                    ? formatDateTime(DateTime.now())
                    : weedingDate,
                cardId: widget.cardID,
                eventList: finaleventListStirng,
                cardTextStyle2: cardTextStyleValue,
                isSelected: isSelected,
                brideGrandDetail: brideGrandDetail,
                groomGrandDetail: groomGrandDetail,
                // comingFromDraft: ,
              )))
          : Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WeddingPageEdit(
                groom:
                '${groomControllers[0].text} ${groomControllers[1].text}',
                gmother: groomControllers[2].text,
                gfather: groomControllers[3].text,
                gGrandFather: groomControllers[4].text,
                gGrandMother: groomControllers[5].text,
                bride:
                '${brideControllers[0].text} ${brideControllers[1].text} ',
                bmother: brideControllers[2].text,
                bfather: brideControllers[3].text,
                bGrandFather: brideControllers[4].text,
                bGrandMother: brideControllers[5].text,
                firstPageDate: weedingDate == ''
                    ? formatDateTime(DateTime.now())
                    : weedingDate,
                cardId: widget.cardID,
                eventList: finaleventListStirng,
                cardTextStyle2: cardTextStyleValue,
                isSelected: isSelected,
                brideGrandDetail: groomGrandDetail,
                groomGrandDetail: brideGrandDetail,
              )));
    }
  }

  final List<TextEditingController> brideControllers =
  List.generate(6, (index) => TextEditingController());
  final List<TextEditingController> groomControllers =
  List.generate(6, (index) => TextEditingController());

  Widget buildTextField(String label, TextEditingController controller) {
    return Expanded(
      child: TextFormField(
        cursorColor: const Color(0xff007663),
        decoration: InputDecoration(
          label: Text(label),
          labelStyle: const TextStyle(fontSize: 14),
          floatingLabelStyle: const TextStyle(
            color: Color(0xff007663),
            fontSize: 14,
          ),
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xff007663),
              width: 1.5,
            ),
          ),
        ),
        controller: controller,
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

  // @override
  // void initState() {
  //   if (box7.isNotEmpty) {
  //     List box7Value = [];
  //     box7Value = box7.get('detailform');
  //     setState(() {
  //       // Assign values to brideControllers
  //       for (var i = 0; i < box7Value.length - 1 && i < 5; i++) {
  //         brideControllers[i].text = box7Value[i] ?? '';
  //         log(brideControllers[i].text);
  //       }

  //       // Assign values to groomControllers
  //       for (var i = 6; i <= 11 && i < box7Value.length; i++) {
  //         groomControllers[i - 6].text = box7Value[i] ?? '';
  //         log(groomControllers[i - 6].text);
  //       }

  //       // Add event details
  //       if (box7Value.length > 12 &&
  //           box7Value[12] is List &&
  //           (box7Value[12] as List).isNotEmpty) {
  //         // Safely iterate through the list
  //         for (var item in box7Value[12]) {
  //           if (item is Map) {
  //             // Convert Map<dynamic, dynamic> to Map<String, String>
  //             final convertedMap = item.map(
  //                 (key, value) => MapEntry(key.toString(), value.toString()));
  //             eventList.add(convertedMap);
  //           }
  //         }
  //       }

  //       // Adjust list height
  //       listHeight = eventList.length * 410;
  //     });

  //     log(box7Value.toString());
  //     log(box7Value.length.toString());
  //     // log(eventList.toString());
  //     // log(eventList.length.toString());
  //   }
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Fill Form'),
        // actions: [
        //   ElevatedButton(
        //       onPressed: () {
        //         for (var i = 0; i <= 14; i++) {
        //           log(controllers[i].text);
        //         }
        //       },
        //       child: Text('data'))
        // ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildSection('Bride', 'assets/bride.jpg', brideControllers),
                const SizedBox(height: 20),
                buildSection('Groom', 'assets/groom.jpg', groomControllers),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      const Text(
                        'Wedding Date',
                        style: TextStyle(fontSize: 25),
                      ),
                      Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: Color(0xff007663),
                            onPrimary: Colors.white,
                            onSurface: Colors.black,
                          ),
                        ),
                        child: CalendarDatePicker(
                          currentDate: DateTime.now(),
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(), // Start from today
                          lastDate: DateTime(2035, 12,
                              31), // Allow up to a specific future date
                          onDateChanged: (value) {
                            setState(() {
                              weedingDate = formatDateTime(value);
                            });
                            log(weedingDate);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isSelected = false;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: isSelected == false
                                ? const Color(0xff007663)
                                : null,
                            border: Border.all(
                              color: isSelected == false
                                  ? const Color(0xff007663)
                                  : Colors.grey,
                            ),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(15))),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const CircleAvatar(
                              backgroundImage: AssetImage('assets/bride.jpg'),
                              radius: 30,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Ladki Wale',
                              style: GoogleFonts.getFont(
                                'Roboto',
                                fontSize: 16,
                                fontWeight: isSelected == false
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: isSelected == false
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                            const SizedBox(width: 10),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isSelected = true;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: isSelected ? const Color(0xff007663) : null,
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xff007663)
                                  : Colors.grey,
                            ),
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(15),
                                bottomRight: Radius.circular(15))),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Ladke Wale',
                              style: GoogleFonts.getFont(
                                'Roboto',
                                fontSize: 16,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                            const SizedBox(width: 10),
                            const CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage('assets/groom.jpg'),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      const Text(
                        'Events Details',
                        style: TextStyle(fontSize: 25),
                      ),
                      eventList.isEmpty
                          ? const SizedBox()
                          : SizedBox(
                        height: listHeight,
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: eventList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border:
                                    Border.all(color: Colors.grey),
                                    borderRadius:
                                    BorderRadius.circular(10)),
                                child: Column(
                                  children: [
                                    Text(
                                      'Event ${index + 1}',
                                      style:
                                      const TextStyle(fontSize: 20),
                                    ),
                                    const SizedBox(height: 10),
                                    CustomContainerWithLabel(
                                      labelText: 'Event Name',
                                      valueText:
                                      '${eventList[index]['name']}',
                                    ),

                                    const SizedBox(height: 10),
                                    CustomContainerWithLabel(
                                      labelText: 'Date and Time',
                                      valueText:
                                      '${eventList[index]['date']}',
                                    ),
                                    const SizedBox(height: 10),
                                    CustomContainerWithLabel(
                                      labelText: 'Venue(Address)',
                                      valueText:
                                      '${eventList[index]['details']}',
                                    ),

                                    // TextFormField(
                                    //   readOnly: true,
                                    //   initialValue: eventList[index]
                                    //       ['name'],
                                    //   decoration: const InputDecoration(
                                    //     labelStyle:
                                    //         TextStyle(fontSize: 14),
                                    //     label: Text('Event Name'),
                                    //     border: OutlineInputBorder(),
                                    //   ),
                                    // ),
                                    // const SizedBox(height: 10),
                                    // TextFormField(
                                    //   readOnly: true,
                                    //   decoration: const InputDecoration(
                                    //     labelStyle:
                                    //         TextStyle(fontSize: 14),
                                    //     label: Text('Date and Time'),
                                    //     border: OutlineInputBorder(),
                                    //   ),
                                    //   initialValue: eventList[index]
                                    //       ['name'],
                                    // ),
                                    // const SizedBox(height: 10),
                                    // TextFormField(
                                    //   readOnly: true,
                                    //   initialValue: eventList[index]
                                    //       ['details'],
                                    //   decoration: const InputDecoration(
                                    //     labelStyle:
                                    //         TextStyle(fontSize: 14),
                                    //     label: Text('Venue (Address)'),
                                    //     border: OutlineInputBorder(),
                                    //   ),
                                    // ),

                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton.icon(
                                          style: ElevatedButton.styleFrom(
                                              side: const BorderSide(
                                                  color: Colors.grey),
                                              shape:
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(
                                                      10)),
                                              backgroundColor:
                                              Colors.white),
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.black,
                                          ),
                                          label: const Text(
                                            'Delete',
                                            style: TextStyle(
                                                color: Colors.black),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              eventList.removeAt(index);
                                              listHeight -= 410;
                                            });
                                            // eventList.removeAt(index);
                                            // setState(() {
                                            //   listHeight -= 330;
                                            // });
                                          },
                                        ),
                                        const SizedBox(width: 20),
                                        ElevatedButton.icon(
                                          style: ElevatedButton.styleFrom(
                                              side: const BorderSide(
                                                  color: Colors.grey),
                                              shape:
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(
                                                      10)),
                                              backgroundColor:
                                              Colors.white),
                                          icon: const Icon(
                                            Icons.edit_note_rounded,
                                            color: Colors.black,
                                          ),
                                          label: const Text(
                                            'Edit',
                                            style: TextStyle(
                                                color: Colors.black),
                                          ),
                                          onPressed: () =>
                                              _showEventDialog(
                                                  index: index),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                                side: BorderSide(color: Colors.grey),
                                borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                            backgroundColor: Colors.white),
                        onPressed: () {
                          _showEventDialog();
                          // eventList.length == 4
                          //     ? Fluttertoast.showToast(
                          //         msg: 'Max of 4 events already added',
                          //         toastLength: Toast.LENGTH_LONG,
                          //         timeInSecForIosWeb: 3,
                          //         // backgroundColor: const Color(0xff007663),
                          //         backgroundColor:
                          //             const Color.fromARGB(146, 0, 0, 0),
                          //         textColor: Colors.white,
                          //       )
                          //     :
                          //     showDialog(
                          //         context: context,
                          //         builder: (context) {
                          //           final baseIndex =
                          //               (12 + 3 * (eventList.length + 1 - 1));
                          //           return Dialog(
                          //             child: Container(
                          //               width: MediaQuery.of(context)
                          //                   .size
                          //                   .width, // Set your desired width
                          //               // height: 500, // Set your desired height
                          //               padding: const EdgeInsets.all(16),
                          //               child: Column(
                          //                 mainAxisSize: MainAxisSize.min,
                          //                 children: [
                          //                   Text('Enter Event Details',
                          //                       style: GoogleFonts.getFont(
                          //                           'Roboto',
                          //                           fontSize: 18)),
                          //                   const SizedBox(height: 10),
                          //                   TextFormField(
                          //                     controller:
                          //                         controllers[baseIndex],
                          //                     decoration: const InputDecoration(
                          //                       labelStyle:
                          //                           TextStyle(fontSize: 14),
                          //                       label: Text('Event Name'),
                          //                       border: OutlineInputBorder(),
                          //                     ),
                          //                   ),
                          //                   const SizedBox(height: 10),
                          //                   TextFormField(
                          //                     decoration: const InputDecoration(
                          //                       labelStyle:
                          //                           TextStyle(fontSize: 14),
                          //                       label: Text('Date and Time'),
                          //                       border: OutlineInputBorder(),
                          //                     ),
                          //                     onTap: () async {
                          //                       await pickDateTime(context,
                          //                           controllers[baseIndex + 1]);
                          //                       setState(() {});
                          //                     },
                          //                     controller:
                          //                         controllers[baseIndex + 1],
                          //                   ),
                          //                   const SizedBox(height: 10),
                          //                   TextFormField(
                          //                     controller:
                          //                         controllers[baseIndex + 2],
                          //                     decoration: const InputDecoration(
                          //                       labelStyle:
                          //                           TextStyle(fontSize: 14),
                          //                       label: Text('Venue (Address)'),
                          //                       border: OutlineInputBorder(),
                          //                     ),
                          //                   ),
                          //                   const SizedBox(height: 20),
                          //                   ElevatedButton(
                          //                     onPressed: () {
                          //                       Navigator.pop(context);
                          //                       setState(() {
                          //                         listHeight += 330;
                          //                       });
                          //                     },
                          //                     child: Text('Done'),
                          //                   ),
                          //                 ],
                          //               ),
                          //             ),
                          //           );
                          //         },
                          //       );
                        },
                        child: const Text(
                          'Add Event',
                          style: TextStyle(
                            color: Color(0xff007663),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff007663),
                      foregroundColor: Colors.white,
                      shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  onPressed: () async {
                    if (eventList.isEmpty) {
                      Fluttertoast.showToast(
                        msg: 'Please add atleast 1 event',
                        toastLength: Toast.LENGTH_LONG,
                        timeInSecForIosWeb: 3,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                      );
                    } else {
                      List detaiFormValue = [];
                      for (var i = 0; i < brideControllers.length; i++) {
                        detaiFormValue.add(brideControllers[i].text);
                      }
                      for (var i = 0; i < groomControllers.length; i++) {
                        detaiFormValue.add(groomControllers[i].text);
                      }
                      detaiFormValue.add(eventList);
                      await box7.put('detailform', detaiFormValue);
                      String eventListSting = '';
                      String finaleventListStirng = '';
                      String cardTextStyleValue = '';
                      if (eventList.isEmpty) {
                        finaleventListStirng = '===';
                      } else {
                        for (int i = 0; i < eventList.length; i++) {
                          eventListSting =
                          "$eventListSting=${eventList[i]['name']}=${eventList[i]['date']} \n ${eventList[i]['details']}";
                        }
                        final finalstring =
                            '${eventList.length <= 2 ? '==' : ''}$eventListSting${eventList.length <= 2 ? eventList.length == 1 ? '=' : '==' : eventList.length == 4 ? '======' : '====='}';
                        finaleventListStirng = finalstring;
                      }
                      if (eventList.length == 1) {
                        cardTextStyleValue =
                        "font2,66,color2,107,0=font1,76,color1,265,0=font2,51,color2,393,0=font1,76,color1,557,0=font2,51,color2,685,0=font1,76,color1,849,0=font2,51,color2,977,0=font1,76,color1,1141,0=font2,51,color2,1269,0=font1,51,color1,1449,0";
                      } else if (eventList.length == 2) {
                        cardTextStyleValue =
                        "font2,66,color2,107,0=font1,76,color1,265,0=font2,51,color2,393,0=font1,76,color1,557,0=font2,51,color2,685,0=font1,76,color1,849,0=font2,51,color2,977,0=font1,76,color1,1141,0=font2,51,color2,1269,0=font2,51,color2,977,0=font1,76,color1,1141,0=font2,51,color2,1269,0=font1,51,color1,1449,0";
                      }
                      if (eventList.length == 3) {
                        cardTextStyleValue =
                        "font2,66,color2,107,0=font1,76,color1,265,0=font2,51,color2,393,0=font1,76,color1,557,0=font2,51,color2,685,0=font1,76,color1,849,0=font2,51,color2,977,0=font1,76,color1,1141,0=font2,51,color2,1269,0=font2,51,color2,977,0=font1,76,color1,1141,0=font2,51,color2,1269,0=font2,51,color2,977,0=font1,76,color1,1141,0=font2,51,color2,1269,0=font1,51,color1,1449,0";
                      }
                      if (eventList.length == 4) {
                        cardTextStyleValue =
                        "font2,66,color2,107,0=font1,76,color1,265,0=font2,51,color2,393,0=font1,76,color1,557,0=font2,51,color2,685,0=font1,76,color1,849,0=font2,51,color2,977,0=font1,76,color1,1141,0=font2,51,color2,1269,0=font2,51,color2,977,0=font1,76,color1,1141,0=font2,51,color2,1269,0=font2,51,color2,977,0=font1,76,color1,1141,0=font2,51,color2,1269,0=font2,51,color2,977,0=font1,76,color1,1141,0=font2,51,color2,1269,0=font1,51,color1,1449,0";
                      }
                      log(eventList.length.toString());
                      validateAndNavigate(
                          finaleventListStirng, cardTextStyleValue);
                      // log(finaleventListStirng);
                    }
                  },
                  child: const Text('Next'),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EventManager extends StatefulWidget {
  @override
  _EventManagerState createState() => _EventManagerState();
}

class _EventManagerState extends State<EventManager> {
  final List<Map<String, String>> eventList = []; // List to store event details

  void _showEventDialog({int? index}) {
    final TextEditingController nameController = TextEditingController(
        text: index != null ? eventList[index]['name'] : '');
    final TextEditingController detailsController = TextEditingController(
        text: index != null ? eventList[index]['details'] : '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(index == null ? 'Add Event' : 'Edit Event'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Event Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: detailsController,
                decoration: const InputDecoration(
                  labelText: 'Event Details',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    detailsController.text.isNotEmpty) {
                  setState(() {
                    if (index == null) {
                      // Add new event
                      eventList.add({
                        'name': nameController.text,
                        'details': detailsController.text,
                      });
                    } else {
                      // Update existing event
                      eventList[index] = {
                        'name': nameController.text,
                        'details': detailsController.text,
                      };
                    }
                  });
                  Navigator.pop(context);
                }
              },
              child: Text(index == null ? 'Done' : 'Save'),
            ),
          ],
        );
      },
    );
  }

  void _printEventDetails() {
    if (eventList.isEmpty) {
      print('No events available.');
    } else {
      for (int i = 0; i < eventList.length; i++) {
        print('Event ${i + 1}:');
        print('Name: ${eventList[i]['name']}');
        print('Details: ${eventList[i]['details']}');
        print('---');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Manager'),
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: _printEventDetails, // Button to print event details
            tooltip: 'Print Event Details',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => _showEventDialog(),
              child: const Text('Add Event'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: eventList.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Event ${index + 1}: ${eventList[index]['name']}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text('Details: ${eventList[index]['details']}'),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () => _showEventDialog(index: index),
                                icon: const Icon(Icons.edit),
                                label: const Text('Edit'),
                              ),
                              const SizedBox(width: 10),
                              ElevatedButton.icon(
                                onPressed: () {
                                  setState(() {
                                    eventList.removeAt(index);
                                  });
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.black,
                                ),
                                label: const Text('Delete'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomContainerWithLabel extends StatelessWidget {
  final String labelText;
  final String? valueText; // Optional value to display in the container

  const CustomContainerWithLabel({
    Key? key,
    required this.labelText,
    this.valueText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            valueText ?? '',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
