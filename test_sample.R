library(iterators)
library(foreach)
setup <- function() {  }
read_data <- function(db, param) {  }
process_data <- function(data) { data.table(mean_price = mean(data$price))  }
write_data <- function(db, data) {  }
report <- function(db, param) {  }
do_work <- function(db, param) {
   setup()
   unprocessed_data <- read_data(db, param)
   iterator <- iter(unprocessed_data$data)
   foreach (row = iterator) %do% {
      processed_row <- process_data(row)
      write_data(db, processed_row)
   }
   report(db, param)
}

library(testthat)
library(mockery)
library(data.table)
library(tibble)

describe('process_data', {
   it('calculates_mean_price', {
      # data table with 4 rows with price 10
      four_rows_price_10 <- data.table(price = rep(10, 4))
      result <- process_data(four_rows_price_10)
      expect_equal(result$mean_price, 10)
   })
})
describe('do_work', {
   it('calls setup', {
      # create mock object for setup function
      fake_setup = mock()
      # replace setup function with mock for calls to do_work
      stub(do_work, 'setup', fake_setup)
      # call the 'flow' function
      fake_db = mock()
      do_work(fake_db, 2016)
      # verify setup was called
      expect_called(fake_setup, 1)
   })
   it('calls process_data 4 times', {
      # create mock object for setup function
      fake_process_data = mock()
      # replace process_data function with mock for calls to do_work
      stub(do_work, 'process_data', fake_process_data)
      # return 4 sets of data to process
      four_sets_of_data <- tibble(g=1:4, data=list(data.table(price=1:3)))
      stub(do_work, 'read_data', four_sets_of_data)
      # call the 'flow' function
      fake_db = mock()
      do_work(fake_db, 2016)
      # verify process_data was called 4 times
      expect_called(fake_process_data, 4)
   })
})           
cat('done')
