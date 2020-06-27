#!/usr/bin/env bash
ranges=(300 500 700)
traceFiles=("111n-285v-30kmh" "111n-285v-60kmh" "111n-285v-100kmh" "371n-950v-30kmh" "371n-950v-60kmh" "371n-950v-100kmh" "464n-1900v-30kmh" "466n-1900v-60kmh" "465n-1900v-100kmh")
disseminationMethods=("misc" "pure-ndn_1s" "pure-ndn_100ms" "unsolicited_1s" "unsolicited_100ms" "proactive_1s" "proactive_100ms" "proactive_and_unsolicited_1s" "proactive_and_unsolicited_100ms")

function contains() {
    local n=$#
    local value=${!n}
    for ((i=1;i < $#;i++)) {
        if [ "${!i}" == "${value}" ]; then
            echo "y"
            return 0
        fi
    }
    echo "n"
    return 1
}

if [ $# -eq 1 ]; then
  if [ $(contains "${disseminationMethods[@]}" "$1") == "y" ]; then
    for i in ${traceFiles[@]}; do
      for j in ${ranges[@]}; do
        ./waf --run "glosa-with-freshness --traceFile=scenarios/trace-files/academic-paper/$i.tcl --disseminationMethod=$1 --range=$j"
      done
    done
  else
    echo "Invalid dissemination method passed: $1"
    echo "Methods: ${disseminationMethods[*]}"
  fi
  
else
  echo "Incorrect number of arguments..."
  echo "Suggested: $ ./run-scenarios.bash <dissemination method>"
  echo "Methods: ${disseminationMethods[*]}" 
fi