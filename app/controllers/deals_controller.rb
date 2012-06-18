class DealsController < ApplicationController

  def index
    @deals = Deal.all
  end

  def total
    @total = Hash.new
    if params[:status].nil?
      %w(won pending lost).each do |status|
        @total[status] = Deal.total_for(status)
      end
    else
      status = params[:status]
      @total = Deal.total_for(status)
    end
  end
  
  def graph
    months = params[:months] || 12
    @graph = {
      :created => Deal.created_by_month(months),
      :won => Deal.won_by_month(months),
      :lost => Deal.lost_by_month(months)
    }
  end

end
