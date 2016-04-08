class TransactionsController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
    @transactions = Transaction.paginate(:page => params[:page], :per_page => 15).order('date DESC')
  end
end
