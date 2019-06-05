using StrollAndRollDataAccess;
using System;
using System.Collections.Generic;
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
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();

            InitializeTabControl();

        }
        private void InitializeTabControl()
        {
            List<string> tableNames = new List<string>();

            tableNames.AddRange(DatabaseOperations.GetTableNames());

            tableNames.AddRange(new string[] 
            {
                CustomTableNames.InventoryGroupsJoin,
                CustomTableNames.QuestionaireJoin,
                CustomTableNames.Constraints,
                CustomTableNames.AddOrUpdateBikePrices,
                CustomTableNames.AppointmentsJoin,
                CustomTableNames.UpdateInventory
            });
             
            tableNames = tableNames.OrderBy(t => t).ToList();

            SelectTableTabItem selectTableTabItem = new SelectTableTabItem(tableNames.ToArray());

            selectTableTabItem.OnShowTableChanged += SelectTableTabItem_OnShowTableChanged;

            mainWindowTabControl.Items.Add(selectTableTabItem);
                
           
             
        }

        private void SelectTableTabItem_OnShowTableChanged(object sender, IsSelectedByTable e)
        {
            string tableName = e.TableName;

            if (e.IsSelected == true)
            {
                string[] tableNames = DatabaseOperations.GetTableNames();

                TabItem tabItem = null;

                if (tableNames.Contains(tableName))
                {
                    tabItem = new TableTabItem(tableName, $"select * from {tableName}");
                }
                else if (tableName == CustomTableNames.InventoryGroupsJoin) {

                    tabItem = new TableTabItem(CustomTableNames.InventoryGroupsJoin, DatabaseOperations.InventorySelectSql);
                     
                }
                else if (tableName == CustomTableNames.InventoryGroupsJoin)
                {

                    tabItem = new TableTabItem(CustomTableNames.InventoryGroupsJoin, DatabaseOperations.InventorySelectSql);
                     
                }
                else if (tableName == CustomTableNames.Constraints)
                {

                    tabItem = new TableTabItem(CustomTableNames.Constraints, "SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS");
                     
                }
                else if (tableName == CustomTableNames.QuestionaireJoin)
                {

                    string joinQuestionaireAnswersSql =
                    $"SELECT * FROM {TableNames.QuestionaireAnswers} left outer join " +
                    $"{TableNames.QuestionaireAgeSelection} on {TableNames.QuestionaireAnswers}.{ColumnNames.Id}" +
                    $"= {ColumnNames.QuestionaireId} left outer join { TableNames.BikePreferences} on  " +
                    $"{ TableNames.BikePreferences}.{ColumnNames.QuestionaireId} = " +
                    $"{ TableNames.BikePreferences}.{ColumnNames.Id}";

                    tabItem = new TableTabItem(CustomTableNames.QuestionaireJoin, joinQuestionaireAnswersSql);
                     
                }
                else if (tableName == CustomTableNames.AddOrUpdateBikePrices)
                {

                    UpdateBikePriceTabItem addOrUpdateBikePriceTabItem
                            = new UpdateBikePriceTabItem();

                    addOrUpdateBikePriceTabItem.BikePriceUpdated += UpdateData;

                    tabItem = addOrUpdateBikePriceTabItem;
                    
                }
                else if (tableName == CustomTableNames.UpdateInventory)
                {

                    UpdateInventory updateInventoryPriceTabItem
                            = new UpdateInventory();

                     
                    tabItem = updateInventoryPriceTabItem;

                }
                

                else if (tableName == CustomTableNames.AppointmentsJoin)
                {
                    string joinQuestionaireAnswersSql =
                                           $"SELECT bb.appointmentid, b.name, a.dayPart, a.date, a.dropofflocation, a.email, a.phone, a.name FROM {TableNames.Appointments} a inner join " +
                                           $"{TableNames.Bikebookings} bb  on a.{ColumnNames.Id} = bb.appointmentid" +
                                           $" inner join {TableNames.Bikes} b on b.id = bb.bikeid order by bb.appointmentid";

                    tabItem = new TableTabItem(CustomTableNames.AppointmentsJoin, joinQuestionaireAnswersSql);
                }

                mainWindowTabControl.Items.Add(tabItem);


            }
            else {

                TabItem item = mainWindowTabControl.Items.Cast<TabItem>().Single(tab => tab.Header.ToString() == e.TableName);

                mainWindowTabControl.Items.Remove(item);
            }
            

            
        }

        private void UpdateData(object sender, EventArgs e)
        {
            foreach (TabItem item in mainWindowTabControl.Items)
            {
                if (item is TableTabItem)
                {
                    ((TableTabItem)item).RefreshData();
                }
                
            }
        }
    }
}
