class MovementsController < ApplicationController
  def index
    @movements = Movement.all
  end
  
  def balance
    @balance = Movement.balance
  end
  
end
