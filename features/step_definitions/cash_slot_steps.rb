Then(/^(#{CAPTURE_CASH_AMOUNT}) should be dispensed$/) do |amount|
  expect(cash_slot.contents).to eq(amount)
end

Then(/^nothing should be dispensed$/) do
  expect{ cash_slot.contents }.to raise_error("I'm Empty!")
end
