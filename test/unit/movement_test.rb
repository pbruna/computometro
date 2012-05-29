require 'test_helper'

class MovementTest < ActiveSupport::TestCase
  fixtures :movements

  test "income must be auto-filled" do
    movement = Movement.new(:total => 98292, :subject => "test", :date => Date.today)
    movement.save
    assert_not_nil(movement.income)
  end

  test "income is set based on total" do
    movement1 = Movement.new(:total => 98292, :subject => "test", :date => Date.today)
    movement2 = Movement.new(:total => -98292, :subject => "test", :date => Date.today)
    movement1.save && movement2.save
    assert(movement1.income?, "Deberia ser verdadero")
    assert(!movement2.income?, "Deberia ser falso")
  end

  test "calculate and save cheksum for every new redcord" do
    movement = Movement.new(:total => 98292, :subject => "test", :date => Date.today)
    movement.save
    assert_not_nil(movement.checksum)
  end

  test "records should be uniq based on checksum" do
    movement1 = Movement.new(:total => 98292, :subject => "test", :date => Date.today)
    movement2 = Movement.new(:total => 98292, :subject => "test", :date => Date.today)
    assert(movement1.save, "No se guardo")
    assert(!movement2.save, "Se guardo igual")
  end

  # test "that the data is synced from the bank" do
  #   bank_credentials = {
  #     :user => APP_CONFIG['user_rut'],
  #     :password => APP_CONFIG['user_password'],
  #     :company_rut => APP_CONFIG['company_rut'],
  #     :number => APP_CONFIG['company_account']
  #   }
  #   bank = Bank.new("CHILEEMPRESAS", bank_credentials)
  #   transactions = bank.transactions.reverse
  #   Movement.sync_with_bank!
  #   assert_equal(Movement.last.total, transactions.last.total)
  # end
  
  test "balance should get the last balance" do
    last_movement = Movement.last
    assert_equal(last_movement.balance, Movement.balance)
  end

end
