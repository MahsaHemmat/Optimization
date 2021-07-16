# Optimization
It contains 2 projects:\
1.Thermo-economic Optimization of Gas Turbine Power Plant using GRG and Lagrange method\
2.Multi-objective Optimization of Rankine Cycle Steam Power Plant with Reheating Technique Enhanced with Open Feed Water Heater and Closed Feed Water Heater
\
## Thermo-economic Optimization of Gas Turbine Power Plant
One of the ways to increase thermodynamic efficiency of the gas-turbine power plant is using a pre-cooling system. This system is usually used in order to cool the compressor inlet air.This precooling system is considered to be an absorbing refrigeration unit which is fed by a steam cycle as shown in the schematic.\
This system will increase the overall cost so the goal of this project is to optimize the cost of this system while the functionality is optimized.\
This optimization is done using two individual methods in order to compare results:\
1.Lagrange method\
2. GRG method\
## Multi-objective Optimization of Rankine Cycle Steam Power Plant with Reheating Technique Enhanced with Open Feed Water Heater and Closed Feed Water Heater
It is sometimes necessary to use multiple turbines with heat recovery projections in order to improve thermodynamic efficiency in Rankine cycles as shown in the schematic.\
In order to have an economically optimal cycle, the fuel consumption must be minimized. As a result, cycle output power and thermal efficiency will decrease.\ Hence, multi-objective optimization should be pursued with the following goals:

**1. Minimum fuel consumption**\
**2. Maximum thermal efficiency**

During the optimization, extraction pressures are very important and they must be determined.\
This optimization is done in three steps:

**1. fuel consumption optimization with Golden section method**\
**2. Thermal efficiency optimization with Steepest descent method**\
**3. Multi-objective optimization using gamultiobj matlab toolbox**
