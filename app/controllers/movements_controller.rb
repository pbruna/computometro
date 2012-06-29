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
    @total[:fondos_mutuos] = Movement.fondos_mutuos
    @total[:income] = Movement.income_total
    @total[:outcome] = Movement.outcome_total
  end
  
  def graph
    months = params[:months] || 12
    @graph = {
      :income => Movement.income_by_month(months),
      :outcome => Movement.outcome_by_month(months)
    }
  end
  
end
