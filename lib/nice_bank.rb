class Account
  def credit(amount)
    @balance = amount
  end

  def balance
    @balance
  end

  def debit(amount)
     if @balance >= amount
      @balance -= amount
    end
  end
end

class Teller
  def initialize(cash_slot, screen)
    @cash_slot = cash_slot
    @screen = screen
  end

  def withdraw_from(account, amount)
    if account.debit(amount)
      @cash_slot.dispense(amount)
    else
      @screen.write("Insufficient funds. Transaction cancelled.")
    end
  end
  
  def check_balance(account)
    @screen.write(['Your account balance is $', account.balance].join)
  end
end

class CashSlot
  def contents
    @contents or raise("I'm Empty!")
  end

  def dispense(amount)
    @contents = amount
  end
end

class Screen
  def write(text)
    @contents = text
  end
  
  def contents
    @contents
  end
end

require 'sinatra'
get '/' do
  %{
    <html>
    <body>
    <form action="/withdraw" method="post">
      <input type="hidden" id="amount" name="amount" value="20">
      <button type="submit">Withdraw $20</button>
    </form>
        <form action="/withdraw" method="post">
      <input type="hidden" id="amount" name="amount" value="40">
      <button type="submit">Withdraw $40</button>
    </form>
        <form action="/withdraw" method="post">
      <input type="hidden" id="amount" name="amount" value="60">
      <button type="submit">Withdraw $60</button>
    </form>
        <form action="/withdraw" method="post">
      <input type="hidden" id="amount" name="amount" value="80">
      <button type="submit">Withdraw $80</button>
    </form>
    <form action="/withdraw" method="post">
      <input type="hidden" id="amount" name="amount" value="100">
      <button type="submit">Withdraw $100</button>
    </form>
    <form action="/check_balance" method="post">
      <button type="submit">Check Balance</button>
    </form>
    </body>
    </html>
  }
end

set :cash_slot, CashSlot.new
set :screen, Screen.new
set :account do
  fail 'account has not been set'
end

post '/withdraw' do
  teller = Teller.new(settings.cash_slot, settings.screen)
  teller.withdraw_from(settings.account, params[:amount].to_i)
  settings.screen.contents
end

post '/check_balance' do
  teller = Teller.new(settings.cash_slot, settings.screen)
  teller.check_balance(settings.account)
  settings.screen.contents
end
