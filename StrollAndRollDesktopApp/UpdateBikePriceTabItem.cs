using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Controls;

namespace StrollAndRollDesktopApp
{
    public class UpdateBikePriceTabItem : TabItem
    {
        public event EventHandler BikePriceUpdated;

        public UpdateBikePriceTabItem()
        {
            Header =  CustomTableNames.AddOrUpdateBikePrices;

            BikePriceUpdateControl bikePriceUpdateControl 
                = new BikePriceUpdateControl();

            bikePriceUpdateControl.BikePriceUpdated += BikePriceUpdateControl_BikePriceUpdated;

            Content = bikePriceUpdateControl;

        }

        private void BikePriceUpdateControl_BikePriceUpdated(object sender, EventArgs e)
        {
            BikePriceUpdated(sender, e);
        }
    }
}
