Prerequisites
=============
The visualiser is extremely unstable. Here are some issues I faced with possible solutions if encountered:

- Try using `from __future__ import print_function` where you get compilation issues due to the incorrect print function being used.
- The above version of ns-3-dev seems to have an infinite [loop issue in the visualizer](https://github.com/named-data-ndnSIM/ndnSIM/issues/93). Outputting an error like such: `RuntimeError: maximum recursion depth exceeded while calling a Python object`. Quick fix is to change `from . import core` to `import core` in ns-3/src/visualizer/visualizer/hud.py

All steps detailed below are for setup with macOS
```
    brew install boost pkg-config openssl libxml2
    export PKG_CONFIG_PATH="/usr/local/opt/libxml2/lib/pkgconfig"   # put this line in ~/.bashrc or manually type before ./waf configure

    # In order to run the Visualiser
    brew install cairo goocanvas gtk+3 graphviz gobject-introspection castxml
    export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:/usr/local/opt/libffi/lib/pkgconfig"  # only for running the next line
    pip install pygraphviz pycairo PyGObject pygccxml

    mkdir ndnSIM
    cd ndnSIM

    git clone --recurse-submodules https://github.com/ChrisLynch96/ns-3.git
    git clone https://github.com/named-data-ndnSIM/pybindgen.git pybindgen

    # Build and install NS-3 and ndnSIM
    cd ns-3
    ./waf configure -d optimized
    ./waf
    sudo ./waf install

    # When using Linux, run
    # sudo ldconfig

    # When using Freebsd, run
    # sudo ldconfig -a

    cd ..
    git clone https://github.com/ChrisLynch96/transient-periodic-information-dissemination-in-VNDN.git
    cd transient-periodic-information-dissemination-in-VNDN

    ./waf configure
    ./waf --run <scenario>
```

Generally followed steps detailed [here](https://ndnsim.net/current/getting-started.html) to get set up correctly. 

For more information how to install NS-3 and ndnSIM, please refer to http://ndnsim.net website.

Compiling
=========

To configure in optimized mode without logging **(default)**:

    ./waf configure

To configure in optimized mode with scenario logging enabled (logging in NS-3 and ndnSIM modules will still be disabled,
but you can see output from NS_LOG* calls from your scenarios and extensions):

    ./waf configure --logging

To configure in debug mode with all logging enabled

    ./waf configure --debug

If you have installed NS-3 in a non-standard location, you may need to set up ``PKG_CONFIG_PATH`` variable.

Running
=======

Normally, you can run scenarios either directly

    ./build/<scenario_name>

or using waf

    ./waf --run <scenario_name>

If NS-3 is installed in a non-standard location, on some platforms (e.g., Linux) you need to specify ``LD_LIBRARY_PATH`` variable:

    LD_LIBRARY_PATH=/usr/local/lib ./build/<scenario_name>

or

    LD_LIBRARY_PATH=/usr/local/lib ./waf --run <scenario_name>

To run scenario using debugger, use the following command:

    gdb --args ./build/<scenario_name>

Running with visualizer
-----------------------

There are several tricks to run scenarios in visualizer.  Before you can do it, you need to set up environment variables for python to find visualizer module.  The easiest way to do it using the following commands:

    cd ns-dev/ns-3
    ./waf shell

After these command, you will have complete environment to run the vizualizer.

The following will run scenario with visualizer:

    ./waf --run <scenario_name> --vis

or

    PKG_LIBRARY_PATH=/usr/local/lib ./waf --run <scenario_name> --vis

If you want to request automatic node placement, set up additional environment variable:

    NS_VIS_ASSIGN=1 ./waf --run <scenario_name> --vis

or

    PKG_LIBRARY_PATH=/usr/local/lib NS_VIS_ASSIGN=1 ./waf --run <scenario_name> --vis

Simulations
=====================

### glosa-with-freshness

- Replicates an intersection with a traffic light emanating the communication pattern of a GLOSA system.
- Requirements to run: Trace files defining the path taken by nodes in the network. Found [here](./scenarios/trace-files)
- Attributes
    - traceFile: relative path to trace file which will be used in the simulation.
    - disseminationMethod: The dissemination method to be used in the simulation. Used for placing resultant data in the correct directory and choosing update frequency.
    - range: The range of communication for nodes in the network.
- Resultant data will be output into ```graphs/data/<data_dissemination_method_here>/``` folder.
- NB: The NFD submodule needs to be altered to use the the correct ```UnsolicitedDataPolicy``` derivative. For *Unsolicited data* and *pure NDN* use ```DropAllUnsolicitedDataPolicy```. For the `proactive pushing` use either ```AdmitAllUnsolicitedDataPolicy``` or ```AdmitNetworkUnsolicitedDataPolicy```.
- example: ```./waf --run "glosa-with-freshness --traceFile=scenarios/trace-files/academic-paper/111n-285v-100kmh.tcl --disseminationMethod=pure-ndn_1s --range=300"```
- To run batches of simulations at once make use of the *run-scenarios.bash* script. It takes as input a valid dissemination method and runs all possible cominations of vehicle density, vehicle speed and transmission range for the procided dissemination method.
- Valid dissemination methods: "pure-ndn_1s" "pure-ndn_100ms" "unsolicited_1s" "unsolicited_100ms" "proactive_1s" "proactive_100ms" "proactive_and_unsolicited_1s" "proactive_and_unsolicited_100ms" "misc"
