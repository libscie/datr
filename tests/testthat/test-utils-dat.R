context('Proper utils')

test_that('Verification fails', {
  expect_error(verify_dat('123'))
  expect_error(verify_dat('x://123'))
  expect_error(verify_dat('dat:///123'))
  expect_error(verify_dat('dat://123'))
  expect_error(verify_dat('dat://123+'))
  expect_error(verify_dat('dat://123++'))
  expect_error(verify_dat('dat://123+x'))
  expect_error(verify_dat('dat://123++x'))
  expect_error(verify_dat('dat://123'))
  expect_error(verify_dat('dat://123+x'))
})