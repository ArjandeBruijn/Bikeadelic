
const monthNames = ["January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"
];

const monthNamesAbbr = ["Jan", "Feb", "Mar", "Apr", "May", "Jun",
    "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
];

const dayNames = ["Sunday","Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];

const dayNamesAbbr = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];

var InitializeCalendar = function (id) {

    var calendar = document.getElementById(id);

    calendar.currentMonth = new Date().getMonth();

    calendar.currentYear = new Date().getFullYear();

    SetCurrentMonth(calendar);

    MakeCalendar(calendar);
}

var SetCurrentMonth = function (calendar) {
     
    document.getElementById("month").innerHTML = monthNamesAbbr[calendar.currentMonth] + " " + calendar.currentYear;
        
}
 
var ChangeMonth = function (id, direction) {
     
    var calendar = document.getElementById(id);
     
    if (direction == 'next') {
       
        calendar.currentMonth++;

        if (calendar.currentMonth == 11) {
            calendar.currentMonth = 0;
            calendar.currentYear++;
        }

    }
    else {
        calendar.currentMonth--;

        if (calendar.currentMonth == -1) {
            calendar.currentMonth = 0;
            calendar.currentYear--;
        }
    }
    SetCurrentMonth(calendar);

    MakeCalendar(calendar);
}
var MakeCalendar = function (calendar) {
     
    while (calendar.firstChild) {
        calendar.removeChild(calendar.firstChild);
    }
     
    calendar.dayCells = [];
     
    calendar.insertRow(-1);
     
    var dayHdrRow = calendar.insertRow(-1);

    for (var d = 0; d < dayNamesAbbr.length; d++) {

        var dayHdr = dayHdrRow.insertCell(-1);

        dayHdr.innerHTML = dayNamesAbbr[d];
    }

    var date = new Date(calendar.currentYear, calendar.currentMonth);
     
    while (date.getDay() > 0) {
        date.setDate(date.getDate() - 1);
    }
     
     
    calendar.firstDay = new Date( date);

    while (true) {

        var weekRow = calendar.insertRow(-1);

        for (d = 0; d < 7; d++) {
             
            var dayCell = weekRow.insertCell(-1);

            calendar.dayCells.push(dayCell);

            dayCell.date = date;

            dayCell.DayOfTheWeek = dayNamesAbbr[date.getDay()];
             
            var padToTwo = function (str) {
                while (str.length < 2) {
                    str = '0' + str;
                }
                return str;
            }

            dayCell.id = padToTwo((date.getMonth()+1).toString()) + '/' + padToTwo(date.getDate().toString()) + '/' + date.getFullYear();
             
            dayCell.classList.add("calendarCell");

            var span = document.createElement('span');

            dayCell.appendChild(span);

            span.innerHTML = dayCell.date.getDate();

            if (calendar.currentMonth != date.getMonth()) {

                span.style.color = "lightgray";
            }
            
            calendar.lastDay = new Date(date);

            if (dayNamesAbbr[date.getDay()] == "Sat" && date.getMonth() > calendar.currentMonth) {

                return;
            }
            else {
                date.setDate(date.getDate() + 1);
            }
             
        }

    };

}