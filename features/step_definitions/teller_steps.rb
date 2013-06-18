When(/^I withdraw (#{CAPTURE_CASH_AMOUNT})$/) do |amount|
  teller.withdraw_from(my_account, amount)
end

Then(/^I should be told that I have insufficient funds in my account$/) do
  expect(page).to have_content("Insufficient funds. Transaction cancelled.")
end

When(/^I check my balance$/) do
  teller.check_balance(my_account)
end

Then(/^I should see that my balance is \$(\d+)$/) do |amount|
  expect(page).to have_content(["Your account balance is $", amount].join)
end
