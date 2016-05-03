class TransactionsController < ApplicationController
  
  def index
    @transactions = Transaction.paginate(:page => params[:page], :per_page => 15).order('date DESC')
  end

  def view
    @transaction = Transaction.find(params[:id])
  end
end
