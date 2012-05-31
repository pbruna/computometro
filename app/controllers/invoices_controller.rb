class InvoicesController < ApplicationController
  
  def total
    @total = Invoice.get_folio_totals
  end
  
end
