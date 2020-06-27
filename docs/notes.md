# Notes

Notes and pointers about running and using this project

- In order to use a different UnsolicitedDataPolicy you **MUST** change the policy being used [here](https://github.com/named-data-ndnSIM/NFD/blob/e44f0297b2298d81b6b35546d388dcf984f2f2bb/daemon/fw/unsolicited-data-policy.hpp#L138) and recompile your installation of NDN using ```./waf``` followed by ```sudo./waf install```. This is necessary when changing from using either pure-ndn or proactive dissemination methods to unsolicited or proactive_and_unsolicited data dissemination methods.

- You need to compile both the NDN source and this repository in *debug* mode in order to use logs in the entire stack. Use the command ```./waf configure --debug``` to configure your installation to compile with logs enabled. Don't forget to compile back into optimized mode, ```./waf configure --optimized```, when running the simulations to gather the results.
