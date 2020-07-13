import "../models/demande_list.dart";
import "demande_view_model.dart";

class DemandeListViewModel{
  DemandeList demandeList;
  List<DemandeViewModel> demandeViewModels;

  DemandeListViewModel({demandeList}){
    this.demandeList=demandeList;
    this.demandeViewModels = new List();
    if (this.demandeList!=null){
      for (int i=0;i<this.demandeList.demandes.length;i++)
        demandeViewModels.add(new DemandeViewModel(demande:this.demandeList.demandes[i]));
    }
  }
}