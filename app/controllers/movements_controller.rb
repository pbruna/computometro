class MovementsController < ApplicationController
  def index
    @movements = Movement.all
  end
  
  def balance
    @balance = Movement.balance
  end
  
  def total
    @total = Hash.new
    @total[:balance] = Movement.balance
    @total[:income] = Movement.income_total
    @total[:outcome] = Movement.outcome_total
  end
  
end
