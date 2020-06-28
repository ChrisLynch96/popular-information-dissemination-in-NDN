# Notes

Notes and pointers about running and using this project

- In order to use a different UnsolicitedDataPolicy you **MUST** change the policy being used [here](https://github.com/named-data-ndnSIM/NFD/blob/e44f0297b2298d81b6b35546d388dcf984f2f2bb/daemon/fw/unsolicited-data-policy.hpp#L138) and recompile your installation of NDN using ```./waf``` followed by ```sudo./waf install```. This is necessary when changing from using either pure-ndn or proactive dissemination methods to unsolicited or proactive_and_unsolicited data dissemination methods.

- You need to compile both the NDN source and this repository in *debug* mode in order to use logs in the entire stack. Use the command ```./waf configure --debug``` to configure your installation to compile with logs enabled. Don't forget to compile back into optimized mode, ```./waf configure --optimized```, when running the simulations to gather the results.

## Plots

- The R file used to generate plots given the simulation data is called pdf_graphs.R and can be found under this path: [root_dir/graphs/pdf_graphs.R](../graphs/pdf_graphs.R).
- Top section is functions used to load data, manipulate data and plot graphs given data frames. The bottom section under ```R ## MAIN... ``` is the script section.
- all.packets is the cleaned and formatted rate-trace.txt data, all.delay is the cleaned and formatted app-delays-trace.txt, and all.cache is the cleaned and formatted cs-trace.txt.
- It takes a very long time to load and clean the rate-trace data. Optimizations may be required in how the data is loaded in order to also load the 100ms data when that becomes available.


