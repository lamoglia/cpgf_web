class TransactionsController < ApplicationController
  caches_page :index
  
  def index
    @transactions = Transaction.paginate(:page => params[:page], :per_page => 15).order('date DESC')
  end
end
