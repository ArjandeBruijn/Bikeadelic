using SendEmail;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;


namespace StrollAndRollDataAccess
{
    public static class DatabaseOperations
    {
        public static string InventorySelectSql => "select count(b.name) as 'Count',m.displayorder, b.name, b.id, m.description, m.id as modelid from inventory i " +
            $"inner join bikes b on i.bikeid = b.id " +
            $"left outer join bikemodels m on m.id =  i.bikeModel " +
            $"group by b.name, b.id, m.description, m.id, m.displayorder ";

        static string ConnectionString => "Data Source=tcp:s13.winhost.com;Initial Catalog = DB_127283_data; User ID = DB_127283_data_user; Password=G0dverd0mme!;Integrated Security = False;";

        public static string SubmitQuestionaire(string WhereDoYouHangOutOnline,
            string FavoritePlacesToHangOutAroundTown,
            string HowLikelyAreYouToRentAWeirdBike,
            string WhyWouldYouOrWouldntYouBeInterested,
            string AreOurPricesWithinYourBudget,
            string WhatDoYouDislikeAboutOurWebsite,
            string DeliverOrPickUp,
            string WhereWouldYouLikeToRide,
            string HowManyHoursWouldYouLikeTheBike,
            Dictionary<string, int> Ageselectiontable,
            List<string> bikeSelectionResult,
            string EmailAddress,
            string HowManyTimesAYearEmail)
        {

            string ageSelectionTableId = Guid.NewGuid().ToString();
            string questionaireId = Guid.NewGuid().ToString();

            string[] bikeSelectionSqls =
               bikeSelectionResult.Select(bikeId => $"insert into {TableNames.QuestionaireBikePreferenceSelection} (id, questionaireid, bikeid) values ('{Guid.NewGuid().ToString()}', '{questionaireId}', '{bikeId}')  ").ToArray();

            List<string> sqls = new List<string>()
            {
                $"insert into  {TableNames.QuestionaireAnswers} (id) values ('{questionaireId}')",
                $"insert into {TableNames.QuestionaireAgeSelection}  (id, questionaireId) values ('{ageSelectionTableId}', '{questionaireId}')",
            }.Union(bikeSelectionSqls).ToList();

            void AddToSqlListIfPropHasValue(string tableName, string propertyName, string propertyValue)
            {
                string EscapeApostrophe(string value)
                {
                    return value.Replace("'", " ");
                }

                if (!String.IsNullOrEmpty(propertyValue) && propertyValue != "Please select...")
                {
                    sqls.Add($"update {tableName }  set {propertyName}= '{EscapeApostrophe(propertyValue)}'");
                }
            }

            
   

            AddToSqlListIfPropHasValue(TableNames.QuestionaireAnswers, nameof(FavoritePlacesToHangOutAroundTown),  FavoritePlacesToHangOutAroundTown);
            AddToSqlListIfPropHasValue(TableNames.QuestionaireAnswers, nameof(HowLikelyAreYouToRentAWeirdBike), HowLikelyAreYouToRentAWeirdBike);
            AddToSqlListIfPropHasValue(TableNames.QuestionaireAnswers, nameof(WhyWouldYouOrWouldntYouBeInterested), WhyWouldYouOrWouldntYouBeInterested);
            AddToSqlListIfPropHasValue(TableNames.QuestionaireAnswers, nameof(AreOurPricesWithinYourBudget), AreOurPricesWithinYourBudget);
            AddToSqlListIfPropHasValue(TableNames.QuestionaireAnswers, nameof(WhatDoYouDislikeAboutOurWebsite), WhatDoYouDislikeAboutOurWebsite);
            AddToSqlListIfPropHasValue(TableNames.QuestionaireAnswers, nameof(DeliverOrPickUp), DeliverOrPickUp);
            AddToSqlListIfPropHasValue(TableNames.QuestionaireAnswers, nameof(WhereWouldYouLikeToRide), WhereWouldYouLikeToRide);
            AddToSqlListIfPropHasValue(TableNames.QuestionaireAnswers, nameof(HowManyHoursWouldYouLikeTheBike), HowManyHoursWouldYouLikeTheBike);
            AddToSqlListIfPropHasValue(TableNames.QuestionaireAnswers, nameof(EmailAddress), EmailAddress);
            AddToSqlListIfPropHasValue(TableNames.QuestionaireAnswers, nameof(HowManyTimesAYearEmail), HowManyTimesAYearEmail);

            foreach (KeyValuePair<string, int> agecohort in Ageselectiontable)
            {
                AddToSqlListIfPropHasValue(TableNames.QuestionaireAgeSelection, agecohort.Key, agecohort.Value.ToString());
            }

            foreach (string sql in sqls)
            {
                Exception error = ExecuteNonQuery(sql);

                if (error != null)
                {
                    string email = GetCompanyEmailAddress();

                    EmailSender emailSender = new EmailSender(email);

                    emailSender.SendToBikeadelics("error submitting queries", sql);
                }
            }

            return "Questionaire successfully submitted";

        }

        public static Faq[] GetFrequentlyAskedQuestions()
        {
            string sql = "select * from FAQ";

            Faq GetFaqFromReader(SqlDataReader reader)
            {
                Faq faq = new Faq();

                faq.ID = reader["ID"].ToString();

                faq.Question = reader["Question"].ToString();

                faq.Answer = reader["Answer"].ToString();

                return faq;
            }
            return GetItems(sql, GetFaqFromReader);
        }
        public static BikeModel[] GetBikeModels()
        {
            string sql = "select * from dbo.BikeModels";

            BikeModel GetBikeModelFromReader(SqlDataReader reader)
            {
                BikeModel bikeModel = new BikeModel();

                bikeModel.ID = reader["ID"].ToString();

                bikeModel.Description = reader["Description"].ToString();
                 
                return bikeModel;
            }
            return GetItems(sql, GetBikeModelFromReader);
             
        }
        public static Bike GetBikeByName(string bikeName)
        {
            Bike[] bikes = DatabaseOperations.GetBikes();

            Bike currentBike = bikes.SingleOrDefault(b => b.Name == bikeName);

            return currentBike;
        }
        public static void RemoveBike(string bikeName, string bikeModelDescription)
        {
            Bike currentBike = GetBikeByName(bikeName);

            InventoryGroup[] inventory = GetInventory();

            //string id = inventory.SingleOrDefault(i => i.BikeId == currentBike.Id);



            //string sql = $"delete from dbo.inventory where id ={id}";



        }
        public static void AddBike(string bikeName, bool newBikeName, string bikeModelDescription, bool newBikeModel )
        {
            Bike currentBike = GetBikeByName(bikeName);
             
            if (newBikeName==false)
            {
                if (currentBike==null)
                {
                    throw new System.Exception($"No bike name {bikeName}");
                }
            }
             
            string bikeId = currentBike.Id;

            BikeModel[] bikeModels = DatabaseOperations.GetBikeModels();

            BikeModel currentBikeModel = bikeModels.SingleOrDefault(bm => bm.Description == bikeModelDescription);

            if (newBikeModel == false)
            {
                if (currentBikeModel == null)
                {
                    //throw new System.Exception($"No bikemodel name {bikeModelDescription}");
                }
            }

            string bikeModelId = currentBikeModel != null ? currentBikeModel.ID : "";

            string newGuid = Guid.NewGuid().ToString();

            string sql = $"insert into dbo.inventory (id, bikeid, bikemodel) values('{newGuid}', '{bikeId}', '{bikeModelId}')";

            Exception error = ExecuteNonQuery(sql);

            if (error != null)
            {
                throw error;
            }
            
        }
        public static string GetRandomQuote()
        {
            string sql = "select quote from quotes";

            string GetQuoteFromReader(SqlDataReader reader)
            {
                return reader["quote"].ToString();
            }

            string[] quotes = GetItems(sql, GetQuoteFromReader);

            return quotes[new Random().Next(quotes.Length)];
        }
        static string GetBikeIdFromBikeName(string bikeName)
        {
            Bike[] bikes = GetBikes();

            return bikes.Single(bike => bike.Name.ToLower() == bikeName.ToLower()).Id;
        }
        static string GetBikeNameFromBikeId(string bikeId)
        {
            Bike[] bikes = GetBikes();

            return bikes.Single(bike => bike.Id.ToLower() == bikeId.ToLower()).Name;
        }
        public static BikePrices[] GetBikePrices()
        {
            string sql = "select * from BikePrices";

            BikePrices GetBikePricesFromReader(SqlDataReader reader)
            {
                BikePrices bikeprices = new BikePrices();

                bikeprices.ID = reader["id"].ToString();

                bikeprices.BikeId = reader["bikeid"].ToString();

                return bikeprices;
            }

            BikePrices[] bikePrices = GetItems(sql, GetBikePricesFromReader);

            return bikePrices;
        }
        public static string InsertOrUpdateBikePrices
            (string bikeName, string firstTwoHours, 
            string thirdAndFourthHour, string subsequentHours)
        {
            string bikeId = GetBikeIdFromBikeName(bikeName);

            List<string> sqls = new List<string>();

            BikePrices[] bikePrices = GetBikePrices();

            if (!bikePrices.Any(bikePrice => bikePrice.BikeId == bikeId))
            {
                sqls.Add($"insert into  bikeprices (id, bikeid) values ('{Guid.NewGuid()}', '{bikeId}')");
            }
            if (string.IsNullOrEmpty(firstTwoHours) == false)
            {
                sqls.Add($"update bikeprices set firsttwohours ='{firstTwoHours}' where bikeid ='{bikeId}'");
            }
            if (string.IsNullOrEmpty(thirdAndFourthHour) == false)
            {
                sqls.Add($"update bikeprices set thirdAndFourthHour ='{thirdAndFourthHour}' where bikeid ='{bikeId}'");
            }
            if (string.IsNullOrEmpty(subsequentHours) == false)
            {
                sqls.Add($"update bikeprices set subsequentHours ='{subsequentHours}' where bikeid ='{bikeId}'");
            }
            ExecuteNonQuery(sqls);

            return "ok";
        }
        public static System.Exception ExecuteNonQuery(string sql)
        {
            return ExecuteNonQuery(new List<string>() { sql });
        }
        private static System.Exception ExecuteNonQuery(List<string> sqls)
        {
            using (var conn = new SqlConnection(ConnectionString))
            {
                try
                {
                    conn.Open();

                    foreach (string sql in sqls)
                    {
                        using (var command = new SqlCommand(sql, conn))
                        {
                            command.ExecuteNonQuery();
                        }
                    }
                }
                catch (Exception e)
                {
                    return e;
                }
                finally
                {
                    conn.Close();
                }
            }
            return null;
        }

        private static InventoryGroup[] GetInventory()
        {
            string sql = InventorySelectSql;

            InventoryGroup GetInventoryGroupFromReader(SqlDataReader reader)
            {
                InventoryGroup inventoryGroup = new InventoryGroup();

                inventoryGroup.Available = Convert.ToInt16(reader["Count"]);
                 
                inventoryGroup.Name = reader["Name"].ToString();

                inventoryGroup.BikeId = reader["Id"].ToString();

                inventoryGroup.Model = reader["description"].ToString();

                if (reader["DisplayOrder"] != System.DBNull.Value)
                {
                    inventoryGroup.DisplayOrder = Convert.ToInt32(reader["DisplayOrder"].ToString());
                }

                inventoryGroup.ModelId = reader["modelid"].ToString();

                return inventoryGroup;
            }

            InventoryGroup[] inventoryGroupValues = GetItems(sql, GetInventoryGroupFromReader);

            Bike[] bikes = GetBikes();

            List<InventoryGroup> inventoryGroups = new List<InventoryGroup>();

            foreach (Bike bike in bikes)
            {
                InventoryGroup[] groups 
                    = inventoryGroupValues.Where(ig => ig.BikeId == bike.Id)
                    .OrderBy (ig=> ig.DisplayOrder)
                    
                    .ToArray();

                inventoryGroups.AddRange(groups);
            }

            return inventoryGroups.ToArray();
        }
        
        public static string GetCompanyEmailAddress()
        {
            return GetParameterValue("companyEmailAddress");
        }
        private static string GetParameterValue(string parameterName)
        {
            string sql = $"select value from parameters where name ='{parameterName}'";

            string[] values = GetItems(sql, (SqlDataReader reader) => { return reader["value"].ToString(); });

            return values.Single();
        }
        public static BillingCost GetPriceEstimateRental
            (InventoryGroup[] desiredBikes,
            DateSelection dateSelections)
        {
            
            double taxPercentage = Convert.ToDouble(GetParameterValue("taxPercentage"));

            BillingCost billingCost = new BillingCost();
             
            BikePrices[] bikeprices = DatabaseOperations.GetPrices();

            if (dateSelections != null && dateSelections.Date!=null)
            {
                bool isWeekend = dateSelections.DateDayOfTheWeek == DayOfWeek.Saturday ||
                        dateSelections.DateDayOfTheWeek == DayOfWeek.Sunday;

                foreach (InventoryGroup desiredBike in desiredBikes
                    .Where(desiredBike => desiredBike.Wanted > 0))
                {
                    BikePrices[] bikePricesValues
                        = bikeprices.Where(bike => bike.BikeId == desiredBike.BikeId).ToArray();

                    if (bikePricesValues.Count() != 1)
                    {
                        throw new System.Exception("Unable to get bikeprice");
                    }
                    BikePrices bikePrices = bikePricesValues.Single();

                    if (isWeekend == false)
                    {
                        billingCost.Price += desiredBike.Wanted * Convert.ToDouble(bikePrices.Evening.Replace("$", ""));
                    }
                    else if (dateSelections.DayPartEnum ==  DayPartSelection.DayPart.Day)
                    {
                        billingCost.Price += desiredBike.Wanted * Convert.ToDouble(bikePrices.DayWeekend.Replace("$", ""));
                    }
                    else if (dateSelections.DayPartEnum == DayPartSelection.DayPart.Evening)
                    {
                        billingCost.Price += desiredBike.Wanted * Convert.ToDouble(bikePrices.Evening.Replace("$", ""));
                    }
                    else
                    {
                        billingCost.Price += desiredBike.Wanted * Convert.ToDouble(bikePrices.HalfDayWeekend.Replace("$", ""));
                    }
                }
            }
            billingCost.Price = Math.Round(billingCost.Price, 2);
            billingCost.Tax = Math.Round( taxPercentage * billingCost.Price,2);

            return billingCost;
        }
        public static string MakeReservation(InventoryGroup[] inventoryGroups,
             string name,
            string email,
            string phoneNumber,
            DateSelection dateSelection)
        {
           
            string message = "An unexpected error occured";
              
            if (string.IsNullOrEmpty(name.Trim()))
            {
                message = "Please enter your name";
                return message;
            }
            else if (string.IsNullOrEmpty(email.Trim()))
            {
                message = "Please enter your email";
                return message;
            }
            else if (email.Trim().Count(c => c == '.') != 1 ||
                email.Trim().Count(c => c == '@') != 1)
            {
                message = "Please enter a valid email address";
                return message;
            }
            else if (string.IsNullOrEmpty(phoneNumber.Trim()))
            {
                message = "Please enter your phone number";
                return message;
            }
            else if (phoneNumber.Count(x => Char.IsDigit(x)) != 10 &&
                phoneNumber.Count(x => Char.IsDigit(x)) != 7)
            {
                message = "Please enter a valid phone number. The form excepts 7 (Fort Collins number) or 10 digits";
                return message;
            }
            else if (dateSelection == null)
            {
                message = "Please select at least one date";
                return message;
            }
            else if (inventoryGroups.All(g => g.Wanted == 0))
            {
                message = "Please select some bikes";
                return message;
            }
            string id = string.Empty;

            BillingCost billingCost = GetPriceEstimateRental(inventoryGroups, dateSelection);

            id = DatabaseOperations.InsertAppointment
                        (dateSelection, name.ToString(), email.ToString(), phoneNumber.ToString());

            

            DatabaseOperations.AddBikeBookings(id, inventoryGroups);

            message = "Booking was successful";

            List<string> messageLines = new List<string>();

            messageLines.Add($"Id: '{id}'");
            messageLines.Add($"name: {name}");
            messageLines.Add($"email: {email}");
            messageLines.Add($"phone: {phoneNumber}");
            messageLines.Add($"price (incl tax): {billingCost.Price+ billingCost.Tax}");
            messageLines.Add($"{dateSelection.Date} {dateSelection.DayPart}");

            messageLines.Add($"Bikes:");
            foreach (InventoryGroup inventoryGroup in inventoryGroups)
            {
                if (inventoryGroup.Wanted > 0)
                {
                    messageLines.Add($"{inventoryGroup.Name}: {inventoryGroup.Model}");
                }
            }

            string renderedFullMessage = messageLines.Aggregate((i, j) => i + "\n" + j);

            string companyEmail = GetCompanyEmailAddress();

            string msg1 = new EmailSender(companyEmail).SendToBikeadelics($"Reservation", renderedFullMessage);

            if (msg1 == EmailSender.MessageAtSuccessfullySentEmail)
            {
                message += $" Email successfully sent to bikeadelic";
            }
            else message += $" Unable to sent email to bikeadelic";

            if (string.IsNullOrEmpty(email.ToString()) == false)
            {
                string rentedBikesMessagePart =
                    inventoryGroups.Where(g => g.Wanted > 0)
                    .Select((kvpi, kvpj) => $"{ kvpi.Wanted}  { kvpi.Name}")
                    .Aggregate((i, j) => $"{i} and {j}");

                string daySelectionPartMessage = $"{dateSelection.Date}";
                 
                string GetDropOffTimeByDayPart(string dayPart)
                {
                    return new Dictionary<string, string>
                    {
                        {DayPartSelection.DayPart.Morning.ToString(), "9.00AM" },
                        {DayPartSelection.DayPart.Afternoon.ToString(), "2.00PM" },
                         {DayPartSelection.DayPart.Day.ToString(), "9.00AM" },
                          {DayPartSelection.DayPart.Evening.ToString(), "4.00PM" }
                    }[dayPart];
                }

                string dropOffTimePartMessage= $"{GetDropOffTimeByDayPart(dateSelection.DayPart)}";
                 
                string customerMessage = $"Dear {name} \n\n" +
                    $"Thank you for your reservation of {rentedBikesMessagePart}. \n\n" +
                    $"We have you down for {daySelectionPartMessage}. \n\n" +
                    $"We are looking forward to see you at {dropOffTimePartMessage} at Lee Martinez park. \n\n" +
                    $"Please have cash payment of ${billingCost.Price} + tax ${billingCost.Tax} = ${billingCost.Price + billingCost.Tax} ready when you meet us there \n\n"+
                    $"We will contact you at {email} or {phoneNumber} to confirm.\n\n" +
                    $"Thank you for your business and looking forward to meet you.\n\n" +
                    $"Arjan de Bruijn and Allison Shaw";

                string msg2 = EmailSender.Send(email.ToString(), $"Your reservation", customerMessage);

                if (msg2 == EmailSender.MessageAtSuccessfullySentEmail)
                {
                    message += $" Email successfully sent to {email.ToString()}";
                }
                else message += $" Unable to sent email to {email.ToString()}";
            }
            else
            {
                message += " no email sent to customer, no address provided";
            }
            return message;
        }
        public static BikesAvailability
          GetBikesAvailability(InventoryGroup[] inventoryGroups,
            string name,
            string email,
            string phone,
          DateTime startDate,
          DateTime endDate,
           DateSelection dateSelection)
        {
            BikesAvailability bikesAvailability 
                = new BikesAvailability(
                dateSelection,
                name,
                email,
                phone);
              
           
            List<DisplayTime> availableDates = new List<DisplayTime>();

            DateTime runningDate = new DateTime(startDate.Ticks);

            DateTime toDate = new DateTime(endDate.Ticks);
             
            bikesAvailability.Inventory = inventoryGroups?.ToArray() ?? GetInventory();

            Appointment[] appointments = DatabaseOperations.GetAppointments();
              
            while (runningDate <= toDate)
            {
                List<DayPartSelection.DayPart> availableDayParts =
                    new List<DayPartSelection.DayPart>(DayPartSelection.GetAvailableDayParts(runningDate));
                 
                foreach (DayPartSelection.DayPart dayPart in DayPartSelection.AllDayParts)
                {
                    Appointment[] appointmentsTodayAndDayPart =
                    appointments.Where(appointment => appointment.Date.Ticks == runningDate.Ticks &&
                     appointment.DayPartOverlaps(dayPart))
                      .ToArray();

                    BikeBooking[] bikeBookings
                        = appointmentsTodayAndDayPart.SelectMany(a => a.BikeBookings)
                        .ToArray();
                     
                    InventoryGroup[] newInventoryGroups = bikesAvailability.Inventory.Select(i => new InventoryGroup(i)).ToArray();
                     
                    foreach (InventoryGroup inventoryGroup in newInventoryGroups)
                    {
                        BikeBooking[] overlappingBikeBookings =
                            bikeBookings.Where(b => b.BikeId == inventoryGroup.BikeId &&
                                 b.ModelId == inventoryGroup.ModelId).ToArray();
                         
                        foreach (BikeBooking overlappingBikeBooking in overlappingBikeBookings)
                        {
                            inventoryGroup.Available--;

                            if (inventoryGroup.Wanted > inventoryGroup.Available)
                            {
                                availableDayParts.Remove(dayPart);
                            }

                        }
                    }
                }
                availableDates.Add(new DisplayTime(runningDate, availableDayParts.ToArray()));

                runningDate = runningDate.AddDays(1);
            }

            bikesAvailability.AvailableDates = availableDates.ToArray();

            if (availableDates.Any() == false)
            {
                bikesAvailability.Message = $"The bikes you want are not available in the timeframe you specified";
            }
            bikesAvailability.BillingCost
                    = GetPriceEstimateRental(bikesAvailability.Inventory, dateSelection);
            
            return bikesAvailability;
        }

        public static string[] GetTableNames()
        {
            string sql = "SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES";

            string GetTableFromReader(SqlDataReader reader)
            {
                return reader["TABLE_NAME"].ToString();
            }

            string[] tableNames = GetItems(sql, GetTableFromReader);

            return tableNames;
        }

        public static bool SavePhoto(string photoUrl, string photoLabel)
        {
            photoUrl = photoUrl.Replace("?dl=0", "?raw=1");

            photoLabel = "no label";

            //https://www.dropbox.com/s/fyw80u4lgmly8mu/loopstep-loopfiets-huren-1.jpg?dl=0
            using (var conn = new SqlConnection(ConnectionString))
            {
                string id = Guid.NewGuid().ToString();

                string sqlString = $"insert into dbo.PhotoLinks(id, link, caption) values('{id}','{photoUrl}', '{photoLabel}')";

                //sqlString = "CREATE TABLE[dbo].[PHOTOLINKS]([Id] VARCHAR(50) NOT NULL, [Link] VARCHAR(MAX) NOT NULL, [Caption] VARCHAR(MAX) NOT NULL,PRIMARY KEY CLUSTERED([Id] ASC));";

                using (var command = new SqlCommand(sqlString, conn))
                {
                    conn.Open();

                    command.ExecuteNonQuery();

                }
                return true;
            }
        }

        public static T[] GetItems<T>(string sqlString, Func<SqlDataReader, T> GetItemFromReader)
        {
            List<T> items = new List<T>();
             
            using (var conn = new SqlConnection(ConnectionString))
            {
                using (var command = new SqlCommand(sqlString, conn))
                {
                    conn.Open();

                    command.ExecuteNonQuery();

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            T item = GetItemFromReader(reader);

                            items.Add(item);
                        }
                    }

                }
                conn.Close();
                 
                return items.ToArray();
            }

        }
        public static BikePrices[] GetPrices()
        {
            string sql = $"select * from BikePrices";

            BikePrices GetBikePricesFromReader(SqlDataReader reader)
            {
                BikePrices bikePrices = new BikePrices();

                bikePrices.ID = reader["ID"].ToString();

                bikePrices.BikeId = reader["BikeId"].ToString();

                bikePrices.HalfDayWeekend = reader["HalfDayWeekend"].ToString();

                bikePrices.DayWeekend = reader["DayWeekend"].ToString();

                bikePrices.Evening = reader["Evening"].ToString();
                 
                return bikePrices;
            }

            BikePrices[] pricesValues = GetItems(sql, GetBikePricesFromReader);

            Bike[] bikes = GetBikes();

            foreach (BikePrices price in pricesValues)
            {
                price.BikeName =
                    bikes.Single(bike => bike.Id.ToLower() == price.BikeId.ToLower()).Name;
            }

            List<BikePrices> prices = new List<BikePrices>();

            foreach (Bike bike in bikes)
            {
                BikePrices price = pricesValues.SingleOrDefault(pv => pv.BikeId == bike.Id);

                if (price != null) {
                    prices.Add(price);
                }
            }

            InventoryGroup[] inventory = GetInventory();

            BikePrices[] pricesNoInventory
                = prices.Where(p => !inventory.Any(i => i.BikeId == p.BikeId)).ToArray();

            foreach (BikePrices bp in pricesNoInventory)
            {
                prices.Remove(bp);
            }

            return prices.ToArray();
        }
        public static Bike[] GetActiveBikes()
        {
            Bike[] bikes = GetBikes();

            InventoryGroup[] inventoryGroups = GetInventory();

            Bike[] activeBikes = bikes.Where(b => inventoryGroups.Any(g => g.BikeId == b.Id)).ToArray();

            return activeBikes;
        }
        public static Bike[] GetBikes()
        {
              
            string sqlString = $"select * from dbo.Bikes";

            Bike GetBikeFromReader(SqlDataReader reader)
            {
                Bike bike = new Bike();

                bike.Id = reader["id"].ToString();

                bike.Name = reader["name"].ToString();

                bike.PictureUrl = reader["PictureUrl"] != System.DBNull.Value ? reader["PictureUrl"].ToString():null;

                bike.Description = reader["Description"] != System.DBNull.Value? reader["Description"].ToString() :null;

                bike.VideoUrl = reader["VideoUrl"] != System.DBNull.Value ? reader["VideoUrl"].ToString() :null;

                bike.DisplayOrder = Convert.ToInt32(reader["DisplayOrder"]);

                return bike;
            }

            Bike[] bikes = 
                GetItems(sqlString, GetBikeFromReader)
                .OrderByDescending(b => b.DisplayOrder>0)
                .ThenBy(b=> b.DisplayOrder)
                 .ToArray();

            return bikes;

        }
        public static PhotoLink[] GetPhotoLinks()
        {
            List<PhotoLink> photos = new List<PhotoLink>();

            string sqlString = $"select id, link, caption from dbo.PhotoLinks";

            PhotoLink GetPhotoLinkFromReader(SqlDataReader reader)
            {
                PhotoLink photo = new PhotoLink();

                photo.Id = reader["id"].ToString();

                photo.Link = reader["Link"].ToString().Replace(" ", "");

                photo.Caption = reader["Caption"].ToString();

                return photo;
            }

            return GetItems(sqlString, GetPhotoLinkFromReader);
        }


        public static void AddBikeBookings
            (string AppointmentId, InventoryGroup[] inventoryGroups)
        {
            Bike[] bikes = GetBikes();

            using (var conn = new SqlConnection(ConnectionString))
            {
                conn.Open();

                foreach (InventoryGroup inventoryGroup in inventoryGroups)
                { 
                    for (int c = 0; c < inventoryGroup.Wanted; c++)
                    {
                        string id = Guid.NewGuid().ToString();

                        Bike bike = bikes.Single(i => i.Name == inventoryGroup.Name);

                        string bikeId = bike.Id;

                        string bikeModelID = inventoryGroup.ModelId;

                        string sql = $"insert into bikeBookings (id, bikeid, bikeModelID , appointmentid) values ('{id}', '{bikeId}', '{bikeModelID}','{AppointmentId}')";

                        using (var command = new SqlCommand(sql, conn))
                        {
                            command.ExecuteNonQuery();
                        }
                    }

                }


            }
        }
        public static string InsertAppointment(DateSelection dateSelectionInstance,
               string name, string email, string phone)
        {
            using (var conn = new SqlConnection(ConnectionString))
            {
                string id = Guid.NewGuid().ToString();

                string date = $"{dateSelectionInstance.CSharpDayTime.Month}/{dateSelectionInstance.CSharpDayTime.Day}/{dateSelectionInstance.CSharpDayTime.Year}";

                string sqlString = $"insert into [dbo].[APPOINTMENTS] (id,date, name, email, phone, daypart) values('{id}', '{date}','{name}', '{email}', '{phone}', '{dateSelectionInstance.DayPartEnum.ToString()}')";

                using (var command = new SqlCommand(sqlString, conn))
                {
                    conn.Open();

                    command.ExecuteNonQuery();

                }
                return id;
            }
        }


        public static void DeleteAppointment(string id)
        {
            using (var conn = new SqlConnection(ConnectionString))
            {

                string sqlString = $"delete  from [dbo].[APPOINTMENTS] where id = {id}";

                using (var command = new SqlCommand(sqlString, conn))
                {
                    conn.Open();

                    command.ExecuteNonQuery();

                }
            }
        }
        public static BikeBooking[] GetBikeBookings()
        {
            string sqlString = $"select * from dbo.bikeBookings";

            BikeBooking GetBikeBookingFromReader(SqlDataReader reader)
            {
                BikeBooking bikeBooking = new BikeBooking();

                bikeBooking.Id = reader["Id"].ToString();

                bikeBooking.AppointmentId = reader["AppointmentId"].ToString();

                bikeBooking.BikeId = reader["BikeId"].ToString();

                bikeBooking.ModelId = reader["bikeModelId"].ToString();

                return bikeBooking;
            }

            BikeBooking[] bikeBookings = GetItems(sqlString, GetBikeBookingFromReader);

            return bikeBookings;
        }

        public static Appointment[] GetAppointments()
        {
            DateTimeUtils dateTimeUtils = new DateTimeUtils();

            string sqlString = $"select * from dbo.Appointments";

            Appointment GetAppointmentFromReader(SqlDataReader reader)
            {
                try
                {
                    Appointment appointment = new Appointment();

                    appointment.Id = reader["Id"].ToString();

                    string dateString = null;
                    try
                    {
                        dateString = reader["date"].ToString();

                        appointment.Date = Convert.ToDateTime(dateString);
                    }
                    catch (System.Exception e)
                    {
                        throw e;
                    }

                    string dayPartRead = reader["DayPart"].ToString();

                    appointment.DayPart = 
                        DayPartSelection.AllDayParts
                        .SingleOrDefault(dayPart => dayPart.ToString().ToUpper() == dayPartRead.ToUpper());

                    return appointment;
                }
                catch (System.Exception e)
                {
                    throw e;
                }

            }

            Appointment[] appointments = GetItems(sqlString, GetAppointmentFromReader);

            List<BikeBooking> bikeBookings =
                new List<BikeBooking>(DatabaseOperations.GetBikeBookings());
             
            foreach (Appointment appointment in appointments) {
                appointment.BikeBookings
                    = bikeBookings.Where(bikeBooking => bikeBooking.AppointmentId == appointment.Id)
                    .ToList();
            }

            return appointments;
        }

        public static OpeningHours[] GetOpeningHours()
        {
            List<OpeningHours> openingHours = new List<OpeningHours>();

            DateTimeUtils dateTimeUtils = new DateTimeUtils();

            using (var conn = new SqlConnection(ConnectionString))
            {
                string sqlString = @"select * from dbo.OpeningHours";
                using (var command = new SqlCommand(sqlString, conn))
                {
                    conn.Open();

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            OpeningHours hours = new OpeningHours();

                            hours.Id = reader["Id"].ToString();
                            hours.DayOfWeek = Enum.GetValues(typeof(DayOfWeek)).Cast<DayOfWeek>().Single(dayOfWeek => dayOfWeek.ToString().ToLower() == reader["Day"].ToString().ToLower());
                            hours.From = dateTimeUtils.GetDateTimeFromTimeString(reader["FromTime"].ToString());
                            hours.To = dateTimeUtils.GetDateTimeFromTimeString(reader["ToTime"].ToString());

                            openingHours.Add(hours);
                        }
                    }

                }
                return openingHours.ToArray();
            }

        }

        public static int GetBikesCount()
        {
            using (var conn = new SqlConnection(ConnectionString))
            {
                string sqlString = @"select count(*) from dbo.BIKES";
                using (var command = new SqlCommand(sqlString, conn))
                {
                    conn.Open();

                    var result = command.ExecuteScalar();

                    return Convert.ToInt32(result);
                }
            }
        }

        public static string ConvertDataTableToHTML(DataTable dt)
        {
            string html = "<table>";
            //add header row
            html += "<tr>";
            for (int i = 0; i < dt.Columns.Count; i++)
                html += "<td>" + dt.Columns[i].ColumnName + "</td>";
            html += "</tr>";
            //add rows
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                html += "<tr>";
                for (int j = 0; j < dt.Columns.Count; j++)
                    html += "<td>" + dt.Rows[i][j].ToString() + "</td>";
                html += "</tr>";
            }
            html += "</table>";
            return html;
        }

        public static string InsertIntoTable(string qualifiedTableName, Dictionary<string, object> values)
        {
            string keys = values.Keys.Aggregate((i, j) => i + "," + j);

            string insertValues = values.Values.Select(v => $"'{v}'").Aggregate((i, j) => i.ToString() + "," + j.ToString()).ToString();

            string id = Guid.NewGuid().ToString();

            string sql = $"insert into {qualifiedTableName} (id, {keys} ) values ('{id}', {insertValues})";

            System.Exception e = ExecuteNonQuery(sql);

            return e.Message;
        }
        public static string GetTableDataHtml(string qualifiedTableName)
        {
            return ConvertDataTableToHTML(GetTableData($"select * from {qualifiedTableName}"));
        }

        public static DataTable GetTableData(string sqlString)
        {
            DataTable table = new DataTable();

            using (var conn = new SqlConnection(ConnectionString))
            {
                using (var command = new SqlCommand(sqlString, conn))
                {
                    conn.Open();

                    SqlDataAdapter da = new SqlDataAdapter(command);

                    da.Fill(table);

                    return table;
                }
            }
        }


    }
}
