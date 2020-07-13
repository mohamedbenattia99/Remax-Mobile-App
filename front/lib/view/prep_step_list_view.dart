import 'package:flutter/material.dart';
import 'prep_step_view.dart';
import '../viewmodel/prep_step_list_view_model.dart';

class PrepStepListView extends StatefulWidget {
  PrepStepListViewModel prepStepListViewModel;

  PrepStepListView({prepStepListViewModel}) {
    this.prepStepListViewModel = prepStepListViewModel;
  }

  @override
  _PrepStepListViewState createState() => _PrepStepListViewState();
}

class _PrepStepListViewState extends State<PrepStepListView> {
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index) {
      return PrepStepView(stepViewModel: this.widget.prepStepListViewModel.prepStepViewModels[index]);
    }, itemCount: this.widget.prepStepListViewModel.prepStepViewModels.length,);
  }
  
  
}