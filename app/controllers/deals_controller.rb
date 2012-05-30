class DealsController < ApplicationController
  
  def index
    @deals = Deal.all
  end
  
  def total
    status = params[:status]
    @total = Deal.total_for(status)
  end
  
end
