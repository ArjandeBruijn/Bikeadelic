using StrollAndRollDataAccess;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StrollAndRollDesktopApp
{
    public class UpdateInventoryControlViewModel : INotifyPropertyChanged
    {
        public event PropertyChangedEventHandler PropertyChanged;

        public bool AddOrRemove { get; set; }

        public string BikeName { get; set; }

        public bool NewBikeName { get; set; }

        public string BikeModel { get; set; }

        bool _newBikeModel;

        public bool NewBikeModel
        {
            get => _newBikeModel;
            set
            {
                _newBikeModel = value;
                PropertyChanged(this, new PropertyChangedEventArgs(nameof(NewBikeModel)));
            }
        }

        public string ResultMessage { get; set; }

        public void Submit()
        {
            ResultMessage = "";
                
            if (NewBikeName == false)
            {
                if (AddOrRemove == true)
                {
                    DatabaseOperations.AddBike(BikeName, NewBikeName, BikeModel, NewBikeModel);
                }
                else
                {
                    DatabaseOperations.RemoveBike(BikeName, BikeModel);
                }
                 
            }

        }
         
        public UpdateInventoryControlViewModel()
        {
            
        }

    }
}
