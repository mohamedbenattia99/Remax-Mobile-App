import 'package:flutter/material.dart';
import '../../models/prep_step_list.dart';
import '../../view/prep_step_list_view.dart';
import '../../models/prep_step.dart';
import '../../viewmodel/prep_step_list_view_model.dart';
class ItineraryApp extends StatefulWidget {
  ItineraryApp();

  @override
  _ItineraryAppState createState() => _ItineraryAppState();
}

class _ItineraryAppState extends State<ItineraryApp> {
  List<PrepStep> prepSteps;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Itinerary'),
      ),
      body: PrepStepListView(
        prepStepListViewModel: PrepStepListViewModel(
          prepStepList: PrepStepList(
            prepSteps: prepSteps,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_box),
        onPressed: disable,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    prepSteps = new List<PrepStep>();
    PrepStep step1 =
        new PrepStep("Etape 1", "Reunion avec le client", "23/03/2020", true);
    this.prepSteps.add(step1);
    PrepStep step2 = new PrepStep(
        "Etape 2", "Choix d'immobilier en question", "23/03/2020", false);
    this.prepSteps.add(step2);
    PrepStep step3 =
        new PrepStep("Etape 3", "Signature du Contrat", "23/03/2020", false);
    this.prepSteps.add(step3);
    PrepStep step4 = new PrepStep("Etape 4", "Paiement", "23/03/2020", false);
    this.prepSteps.add(step4);
    disable();
  }

  void disable() {
    setState(() {
      for (var i = 0; i < 4; i++)
        if (prepSteps[i].isFinished == true) {
          prepSteps[i + 1].checkbox = true;
          prepSteps[i].checkbox = false;
        }
    });
  }
}
