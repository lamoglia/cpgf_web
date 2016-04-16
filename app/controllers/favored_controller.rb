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
  end
end
