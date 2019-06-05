using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace StrollAndRollDesktopApp
{
    /// <summary>
    /// Interaction logic for TableSelectControl.xaml
    /// </summary>
    public partial class TableSelectControl : UserControl
    {
        ObservableCollection<IsSelectedByTable> _tableSelectionCollection;

        public event EventHandler<IsSelectedByTable> OnShowTableChanged; 

        public TableSelectControl(string[] tableNames)
        {
            InitializeComponent();

            _tableSelectionCollection = new ObservableCollection<IsSelectedByTable>();

            foreach (string tableName in tableNames) {

                IsSelectedByTable isSelectedByTable = new IsSelectedByTable()
                {
                    TableName = tableName,
                };
                isSelectedByTable.OnSelectedChanged += IsSelectedByTable_OnSelectedChanged;

                _tableSelectionCollection.Add(isSelectedByTable);
            }
                 
            selectTableDataGrid.ItemsSource= _tableSelectionCollection;
                
        }

        private void IsSelectedByTable_OnSelectedChanged(object sender, bool e)
        {
            OnShowTableChanged(this, sender as IsSelectedByTable);
        }
    }
}
