# mockery sample
Example code for testthat and mockery you can run this by copy-and-pasting to https://rdrr.io/snippets/

First identify the steps of your script: this will be the names of the functions
Then create the do_work function: this will be the flow
Add another file that has the parameter values and calls the do_work function:


`source('script_with_functions.R')`

`connection <- odbcDriverConnect(connectionstring = '...')`

`year <- 2016`

`do_work(connection, year)`

`odbcClose(connection)`
