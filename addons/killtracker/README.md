ace_killtracker
============

Tracks deaths/kills and logs to the end mission disaplay. Attemps to log kills from Medical by using `ace_medical_lastDamageSource`.

Note: Requires config setup in a mission, see `killtracker.inc` - has no effect if mission is not setup correctly.

## ACEX Conversion - things still using acex prefix
- Global Var `acex_killTracker_outputText`
- `acex_killTracker` classname for `CfgDebriefingSections`
