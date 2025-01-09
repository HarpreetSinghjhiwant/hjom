import 'package:flutter/material.dart';

class WowInvitePage extends StatefulWidget {
  @override
  _WowInvitePageState createState() => _WowInvitePageState();
}

class _WowInvitePageState extends State<WowInvitePage> {
  int _currentStep = 0;

  final _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  final _groomNameController = TextEditingController();
  final _brideNameController = TextEditingController();

  @override
  void dispose() {
    _groomNameController.dispose();
    _brideNameController.dispose();
    super.dispose();
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
      body: Stepper(
        type: StepperType.vertical,
        currentStep: _currentStep,
        onStepContinue: () {
          if (_formKeys[_currentStep].currentState!.validate()) {
            setState(() => _currentStep++);
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() => _currentStep--);
          }
        },
        steps: _buildSteps(),
        controlsBuilder: (BuildContext context, ControlsDetails details) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (_currentStep > 0)
                ElevatedButton(
                  onPressed: details.onStepCancel,
                  child: const Text('Back'),
                ),
              ElevatedButton(
                onPressed: details.onStepContinue,
                child: _currentStep == 3 ? const Text('Finish') : const Text('Next'),
              ),
            ],
          );
        },
      ),
    );
  }

  List<Step> _buildSteps() {
    return [
      Step(
        title: const Text('Create Event'),
        content: _createEventForm(),
        isActive: _currentStep >= 0,
      ),
      Step(
        title: const Text('Bride & Groom Details'),
        content: _brideGroomDetailsForm(),
        isActive: _currentStep >= 1,
      ),
      Step(
        title: const Text('Event Details'),
        content: _eventDetailsForm(),
        isActive: _currentStep >= 2,
      ),
      Step(
        title: const Text('Song & Caricature'),
        content: _songCaricatureForm(),
        isActive: _currentStep >= 3,
      ),
    ];
  }

  Widget _createEventForm() {
    return Form(
      key: _formKeys[0],
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _groomNameController,
                  decoration: const InputDecoration(labelText: 'Groom Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Groom Name';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 10), // Add spacing between the fields
              Expanded(
                child: TextFormField(
                  controller: _brideNameController,
                  decoration: const InputDecoration(labelText: 'Bride Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Bride Name';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 10), // Space between rows
          ElevatedButton(onPressed: () {}, child: const Text('Load WOW')),
        ],
      ),
    );
  }


  Widget _brideGroomDetailsForm() {
    return Form(
      key: _formKeys[1],
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Bride’s Mother Name'),
                ),
              ),
              const SizedBox(width: 10), // Space between columns
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Bride’s Father Name'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10), // Space between rows
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Groom’s Mother Name'),
                ),
              ),
              const SizedBox(width: 10), // Space between columns
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Groom’s Father Name'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  Widget _eventDetailsForm() {
    return Form(
      key: _formKeys[2],
      child: Column(
        children: [
          ListTile(
            title: const Text('Mehendi'),
            subtitle: const Text('21st June 2024 | 4:00 PM Onwards'),
            trailing: TextButton(onPressed: () {}, child: const Text('Edit')),
          ),
          ListTile(
            title: const Text('Sangeet'),
            subtitle: const Text('22nd June 2024 | 8:00 PM Onwards'),
            trailing: TextButton(onPressed: () {}, child: const Text('Edit')),
          ),
          ElevatedButton(onPressed: () {}, child: const Text('Add Event')),
        ],
      ),
    );
  }

  Widget _songCaricatureForm() {
    return Form(
      key: _formKeys[3],
      child: Column(
        children: [
          DropdownButtonFormField<String>(
            items: ['Music 1', 'Music 2', 'Music 3']
                .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                .toList(),
            onChanged: (value) {},
            decoration: const InputDecoration(labelText: 'Select Music'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(onPressed: () {}, child: const Text('Upload Bride Image')),
          ElevatedButton(onPressed: () {}, child: const Text('Upload Groom Image')),
        ],
      ),
    );
  }
}