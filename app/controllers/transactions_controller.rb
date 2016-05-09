class TransactionsController < ApplicationController
  caches_action :index, :cache_path => Proc.new { |c| c.params }
  caches_page :view
  
  def index
    @transactions = Transaction.paginate(:page => params[:page], :per_page => 15).order('date DESC')
  end

  def view
    @transaction = Transaction.find(params[:id])
  end
end
