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

end
