import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();

  List<Map<String, String>> eventList = [];
  int count = 0;

  @override
  void initState() {
    super.initState();
    // Use addPostFrameCallback to execute actions after layout is complete.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Any actions that depend on the layout phase completion can be placed here.
    });

    eventList.addAll([
      {
        'name': 'Mehendi',
        'date': '21st June 2024 | 4:00 PM Onwards',
        'details':
            'Venue - delete it. close. this generator\'s\n current url is: venue. to change it, just enter a'
      },
      {
        'name': 'Sangeet',
        'date': '22nd June 2024 | 7:00 PM Onwards',
        'details': 'Venue - Grand Ballroom, Hyatt Regency'
      },
    ]);
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
                color: Color.fromRGBO(153, 153, 153, 1),
                fontWeight: FontWeight.w400,
                fontSize: 14,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(
              height: 12,
            ),
            TextField(
              controller: controller,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                isDense: true,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: Colors.purple)),
              ),
            ),
          ],
        ),
      ),
    );
  }

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

  void _showEventDialog({int? index}) {
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

  Widget buildInput(TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 150,
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
                borderSide: BorderSide(color: Colors.purple)),
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
          borderSide:
              BorderSide(color: Colors.blue, width: 2.0), // Border when focused
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
              color: Colors.grey, width: 1.0), // Border when not focused
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
                if (count == 0) buildPage1(),
                if(count == 1) buildPage2(),
                if (count == 2) buildPage3(),
                if (count == 3) buildPage4()
                // buildPage3(),
                // buildPage4(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: buildBottomNext(),
    );
  }

  Widget buildPage1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '1. Create Event',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Color.fromRGBO(109, 81, 206, 1),
          ),
        ),
        SizedBox(
          height: 12,
        ),
        // Container(child: buildSection('Groom', 'assets/Male_image', groomControllers)),
        // Container(child: buildSection('Bride', 'assets/Female_image', brideControllers)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildInputText('Groom', groomControllers[0]),
            buildInputText('Bride', brideControllers[0]),
          ],
        ),
        SizedBox(
          height: 24,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Choose Your Side',
            style: TextStyle(
                color: Color.fromRGBO(153, 153, 153, 1),
                fontWeight: FontWeight.w400),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 133,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      width: 1, color: Color.fromRGBO(210, 210, 210, 1)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/Male_image.png',
                      width: 36,
                      height: 37,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Ladke\nWale'),
                    ),
                  ],
                ),
              ),
              Text(
                'or',
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromRGBO(153, 153, 153, 1),
                ),
              ),
              Container(
                width: 133,
                height: 56,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(109, 81, 206, 0.12),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      width: 1, color: Color.fromRGBO(109, 81, 206, 1)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/Female_image.png',
                      width: 36,
                      height: 37,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Ladki\nWale',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color.fromRGBO(109, 81, 206, 1),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 25,
        ),
        buildEventBar('2', 'Bride & Groom Details'),
        SizedBox(
          height: 25,
        ),
        buildEventBar('3', 'Event Details'),
        SizedBox(
          height: 25,
        ),
        buildEventBar('4', 'Song & Caricature'),
      ],
    );
  }

  Widget buildPage2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 12,
        ),
        buildEventComplete(
            'Event Created', 'Ayush weds Netali | 21st June 2025', 0),
            SizedBox(
          height: 25,
        ),
          buildBrideAndGroom(),
          SizedBox(
          height: 25,
        ),
        buildEventBar('3', 'Event Details'),
        SizedBox(
          height: 25,
        ),
        buildEventBar('4', 'Song & Caricature'),
      ],
    );
  }

  Widget buildPage3() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildEventComplete(
            'Event Created', 'Ayush weds Netali | 21st June 2025', 0),
        // SizedBox(height: 23,),
        // buildBrideAndGroom(),
        SizedBox(height: 24),
        buildEventComplete(
            'Bride & Groom Details', 'Bride & Groom family details added', 1),
        SizedBox(
          height: 24,
        ),
        Text(
          '3. Event Details',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Color.fromRGBO(109, 81, 206, 1),
          ),
        ),
        SizedBox(
          height: 12,
        ),
        buildEventDetails('Mehendi  ', ' 21st June 2024 | 4:00 PM Onwards ',
            "Venue - delete it. close. this generator's\n current url is: venue. to change it, just enter a"),
        SizedBox(
          height: 12,
        ),
        buildEventDetails('Sangeet', ' 21st June 2024 | 4:00 PM Onwards ',
            "Venue - delete it. close. this generator's\n current url is: venue. to change it, just enter a"),
        SizedBox(
          height: 12,
        ),
        Center(
          child: GestureDetector(
            onTap: () => buildBottomModal(context),
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
                  SizedBox(
                    width: 2,
                  ),
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
        ),
        SizedBox(
          height: 48,
        ),
        buildEventBar('2', 'Bride & Groom Details'),
        SizedBox(
          height: 25,
        ),
        buildEventBar('3', 'Event Details'),
        SizedBox(
          height: 25,
        ),
        buildEventBar('4', 'Song & Caricature'),
      ],
    );
  }

  Widget buildPage4() {
    return Column(
      children: [
        buildEventComplete(
            'Event Created', 'Ayush weds Netali | 21st June 2025', 0),
        // SizedBox(height: 23,),
        // buildBrideAndGroom(),
        SizedBox(height: 24),
        buildEventComplete(
            'Bride & Groom Details', 'Bride & Groom family details added', 1),
        SizedBox(
          height: 24,
        ),
        buildEventComplete(
            '4 Events added ', 'Haldi | Mehendi  | Sangeet | Wedding', 2),
        SizedBox(
          height: 24,
        ),
        buildSongAndCaricature(),
      ],
    );
  }

  Widget buildEventBar(String num, String title) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(250, 250, 250, 1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color.fromRGBO(232, 232, 232, 1)),
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
                    border:
                        Border.all(color: Color.fromRGBO(232, 232, 232, 1))),
                child: Center(
                  child: Text(
                    '${num}',
                    style: TextStyle(color: Color.fromRGBO(109, 81, 206, 1)),
                  ),
                ),
              ),
              SizedBox(
                width: 12,
              ),
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

  Widget buildEventComplete(String title, String description, int counts) {
    return GestureDetector(
      onTap: () {
        setState(() {
          count = counts;
        });
      },
      child: Container(
        width: 371,
        height: 83,
        decoration: BoxDecoration(
            color: Color.fromRGBO(250, 250, 250, 1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color.fromRGBO(232, 232, 232, 1))),
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
                      color: Color.fromRGBO(135, 135, 135, 1)),
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
            Icon(
              Icons.keyboard_arrow_down,
              size: 25,
            )
          ],
        ),
      ),
    );
  }

  Widget buildBrideAndGroom() {
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
            SizedBox(
              height: 24,
            ),
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
                            color: Color.fromRGBO(148, 148, 148, 1)),
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
                            color: Color.fromRGBO(148, 148, 148, 1)),
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

  Widget buildEventDetails(String title, String date, String venue) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            width: 2,
            height: 153,
            decoration: BoxDecoration(color: Color.fromRGBO(109, 81, 206, 1)),
          ),
          SizedBox(
            width: 8,
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$title',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(135, 135, 135, 1)),
                ),
                Text(
                  '$date',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(135, 135, 135, 1)),
                ),
                Text(
                  "$venue",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(135, 135, 135, 1)),
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
                    SizedBox(
                      width: 44,
                    ),
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
                        SizedBox(
                          width: 12,
                        ),
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

  Widget buildInputs(String text, TextEditingController controller) {
    return Container(
      width: 300,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: '$text',
          hintStyle: TextStyle(color: Colors.grey),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
      ),
    );
  }

  Widget buildEventDetailsDialog() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Text(
            'Add Event Details',
            style: TextStyle(
              color: Color.fromRGBO(114, 114, 114, 1),
              fontFamily: 'Roboto',
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Image.asset(
            'assets/background.png',
            width: 135,
            height: 258,
          ),
          SizedBox(
            height: 24,
          ),
          buildInputs('Event Details', nameController),
          SizedBox(
            height: 24,
          ),
          buildInputs('Event Date and Time', dateController),
          SizedBox(
            height: 24,
          ),
          buildInputs('Event Venue', detailsController),
          SizedBox(
            height: 24,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                eventList.add({
                  'name': nameController.text,
                  'date': dateController.text,
                  'details': detailsController.text,
                });
                nameController.text = 'Event Name';
                dateController.text = 'Event Date & time';
                detailsController.text = 'Event Name';
              });
              Navigator.pop(context);
            },
            child: Container(
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
                    'Add Event',
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
          ),
          SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }

  Widget buildInstructions() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Follow these points for the best results'),
          Text(
              '1. Images should be front facing\n2. Avoid glasses\n3. No darkeness in the background\n4. only one face in the image'),
          Container(
            width: 158,
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
            child: Text(
              'Got it',
              style: TextStyle(
                fontFamily: 'Popins',
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void buildBottomModal(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      isScrollControlled: true, // Allow full screen for bottom sheet
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: SingleChildScrollView(
            // Enable scrolling within the bottom sheet
            child: buildEventDetailsDialog(),
          ),
        );
      },
    );
  }

  Widget buildSongAndCaricature() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '3. Create Event',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Color.fromRGBO(109, 81, 206, 1),
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Text(
            'Selected Music:',
            style: TextStyle(
                color: Color.fromRGBO(118, 118, 118, 1),
                fontWeight: FontWeight.w400,
                fontSize: 16),
          ),
          SizedBox(
            height: 24,
          ),
          Center(
            child: Container(
              width: 250,
              height: 1,
              decoration: BoxDecoration(
                color: Color.fromRGBO(179, 179, 179, 1),
              ),
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Text(
            'Upload the photos of bride & Groom',
            style: TextStyle(
              color: Color.fromRGBO(118, 118, 118, 1),
              fontSize: 16,
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Container(
                    width: 86,
                    height: 86,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      border: Border.all(
                        color: Color.fromRGBO(210, 210, 210, 1),
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.upload,
                          color: Colors.deepPurpleAccent,
                        )),
                  ),
                  Text(
                    'Upload Bride\nImage',
                    style: TextStyle(
                        color: Color.fromRGBO(102, 102, 102, 1),
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        fontFamily: 'Roboto'),
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                    width: 86,
                    height: 86,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      border: Border.all(
                        color: Color.fromRGBO(210, 210, 210, 1),
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.upload,
                          color: Colors.deepPurpleAccent,
                        )),
                  ),
                  Text(
                    'Upload Groom\nImage',
                    style: TextStyle(
                        color: Color.fromRGBO(102, 102, 102, 1),
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        fontFamily: 'Roboto'),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildBottomNext() {
    return Container(
      height:count==0? 190:140,
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center, // Added space between containers
        children: [
          if(count==0)Container(
            width: 424,
            height: 92,
            decoration: BoxDecoration(
              border: Border.all(
                color: Color.fromRGBO(203, 203, 203, 1),
              ),
            ),
          ),
          Container(
            height: count == 0?92:49,
            child: Row(
              mainAxisAlignment:count!=0? MainAxisAlignment
                  .spaceEvenly:MainAxisAlignment.end, // Center the button within the Row
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (count != 0)
                  Container(
                    width: 158,
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
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (count >= 0 && count < 3) {
                        count++;
                      } else if (count == 3) {
                        count = 0;
                      }
                    });
                  },
                  child: Container(
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
