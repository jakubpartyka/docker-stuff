#!/bin/bash

### CONFIG ###
MAX_LOG_CNT=10		           # max number of monitoring log entries that will be kept
LOG_FILE=/var/simple-mon/logs      # file where memory and cpu usage will be logged to
OUTPUT=/var/www/html/index.html    # file to which an usage graph will be written to
##############

### CHECK LOG FILE LENGTH ###
MEM=$( free |  awk '$1 == "Mem:" {x= $7/($3+$7)*100} $2 == "buffers/cache:" {x= $4/($3+$4)*100} $1 == "Swap:" {print (100-x)}')
CPU=$(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage}')

#check current number of lines in log file and remove least recent if greater or equal to MAX_LOG_CNT

LNS=$(wc -l $LOG_FILE | cut --delimiter=' ' -f1)
if [[ $LNS -ge $MAX_LOG_CNT ]] ; then
        tail -n +2 "$LOG_FILE" > "$LOG_FILE"".tmp" && mv "$LOG_FILE"".tmp" "$LOG_FILE"
fi

### LOG CURRENT USAGE ###

TIMESTAMP=$(date '+%d.%m.%y %H:%M')
echo "['$TIMESTAMP',$MEM,$CPU]," >> "$LOG_FILE"


### UPDATE OUTPUT FILE ###

echo "<html>
  <head>
    <script type=\"text/javascript\" src=\"https://www.gstatic.com/charts/loader.js\"></script>
    <script type=\"text/javascript\">
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawChart);

      function drawChart() {
        var data = google.visualization.arrayToDataTable([
        ['Time', 'Memory usage (%)', 'CPU usage (%)']," > "$OUTPUT"".tmp"

        cat $LOG_FILE >> "$OUTPUT"".tmp"
echo "        ]);

        var options = {
          title: 'Memory usage',
          hAxis: {title: 'Time',  titleTextStyle: {color: '#333'}},
          vAxis: {minValue: 0, maxValue: 100}
        };

        var chart = new google.visualization.AreaChart(document.getElementById('chart_div'));
        chart.draw(data, options);
      }
    </script>
  </head>
  <body>
    <div id=\"chart_div\" style=\"width: 100%; height: 100%;\"></div>
  </body>
</html>" >> "$OUTPUT"".tmp"

mv "$OUTPUT"".tmp" $OUTPUT

###########################
