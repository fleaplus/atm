module KnowsTheUserInterface
  class UserInterface
    include Capybara::DSL

    def withdraw_from(account, amount)
      Sinatra::Application.account = account
      visit '/'
      click_button ['Withdraw $', amount].join
    end
    
    def check_balance(account)
      Sinatra::Application.account = account
      visit '/'
      click_button "Check Balance"
    end
  end

  def my_account
    @my_account ||= Account.new
  end

  def cash_slot
    Sinatra::Application.cash_slot
  end

  def teller
    @teller ||= UserInterface.new
  end
  
  def screen
    Sinatra::Application.screen
  end
end

World(KnowsTheUserInterface)
