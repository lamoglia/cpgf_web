class FavoredController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
    @favored = Favored.by_transactions_value.paginate(:page => params[:page], :per_page => 15)
    
    @favored = @favored.name_contains(params[:name].upcase) if params[:name].present?

    @search_term = params[:name].upcase if params[:name].present?
  end

  def view
    @favored = Favored.find(params[:id])

    @transactions = @favored.transactions.paginate(:page => params[:page], :per_page => 15).order('date DESC')

    @first_transaction_date = @favored.transactions.order('date ASC').first.date
    @last_transaction_date = @favored.transactions.order('date DESC').first.date

    month_count = (@last_transaction_date.year * 12 + @last_transaction_date.month) - (@first_transaction_date.year * 12 + @first_transaction_date.month)

    @total_spent = @favored.transactions.map{|t| t.value}.reduce(0, :+)
    @monthly_average = @total_spent/month_count
    
  end
end
