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

  Widget buildTextField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey[200], // Background color grey
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
                Container(child: buildSection('Groom', 'assets/Male_image', groomControllers)),
                Container(child: buildSection('Bride', 'assets/Female_image', brideControllers)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
