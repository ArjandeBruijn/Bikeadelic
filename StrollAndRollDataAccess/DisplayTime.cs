﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StrollAndRollDataAccess
{
    public class DisplayTime
    {
        public int year { get; private set; }

        public string DayOfWeek { get; private set; }

        public string date { get; private set; }

        public string month { get; private set; }

        public int day { get; private set; }

        public DayPart AvailableDayPart { get; private set; }

        public string AvailableDayPartString => AvailableDayPart.ToString();

        public bool IsOtherMonth { get; set; } = false;

        public DisplayTime(DateTime inDate)
        {
            DateTimeUtils dateTimeUtils = new DateTimeUtils();

            month = dateTimeUtils.MonthName(inDate);

            date = dateTimeUtils.GetDateString(inDate);

            DayOfWeek = inDate.DayOfWeek.ToString();

            day = inDate.Day;

            year = inDate.Year;

        }


        public DisplayTime(DateTime inDate, DayPart availableDayPart)
            : this(inDate)
        {
            AvailableDayPart = availableDayPart;
        }
    }
}
