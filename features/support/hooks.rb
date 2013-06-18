# After do |scenario|
  # save_and_open_page if scenario.failed?
# end

After do |scenario|
  Sinatra::Application.cash_slot = CashSlot.new
  Sinatra::Application.screen = Screen.new
end
