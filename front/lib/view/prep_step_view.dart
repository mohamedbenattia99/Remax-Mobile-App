import 'package:flutter/material.dart';
import '../viewmodel/prep_step_view_model.dart';

class PrepStepView extends StatefulWidget {
  PrepStepViewModel stepViewModel;

  PrepStepView({stepViewModel}) {
    this.stepViewModel = stepViewModel;
  }

  @override
  _PrepStepViewState createState() => _PrepStepViewState();
}

class _PrepStepViewState extends State<PrepStepView> {
  
  Color _setColor(){
    if(widget.stepViewModel.step.isFinished==false)
      return Colors.grey;
    else
      return Colors.white;
  }

  Widget build(BuildContext context) {
    return Card(color: _setColor(),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(this.widget.stepViewModel.step.name),
            subtitle: Text(this.widget.stepViewModel.step.date
                ),
            trailing: Checkbox(
              value: this.widget.stepViewModel.step.isFinished,
              onChanged: onCheckBoxChanged,
              tristate: false,
            ),
          ),
          Divider(
            height: 1.0,
          ),
          ListTile(
            leading: Icon(Icons.description),
            title: Text(this.widget.stepViewModel.step.shortDescription),
            subtitle: Text('Description'),
          )
        ],
      ),
    );
  }

  void onCheckBoxChanged(bool value) {
    if (this.widget.stepViewModel.step.checkbox==false)
    return null;
    else
    setState(() {
      this.widget.stepViewModel.step.isFinished = value;
    });
    
  }
  
}