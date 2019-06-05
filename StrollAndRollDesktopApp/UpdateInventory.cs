using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Controls;

namespace StrollAndRollDesktopApp
{
    public class UpdateInventory : TabItem
    {
        
        public UpdateInventory()
        {
            Header =  CustomTableNames.UpdateInventory;

            UpdateInventoryControlViewModel vm = new UpdateInventoryControlViewModel();

            UpdateInventoryControl updateInventoryControl
                 = new UpdateInventoryControl(vm);

            Content = updateInventoryControl;
        }

         
    }
}
