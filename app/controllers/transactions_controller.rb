class TransactionsController < ApplicationController
  caches_action :index, :cache_path => Proc.new { |c| c.params }
  caches_page :view
  

  def index
    page_size = 15

    if !params[:page].present? 
      last_page = (Transaction.all.count / page_size.to_f).ceil
      redirect_to transacoes_path page: last_page unless params[:page].present?
    end

    @transactions = Transaction.paginate(:page => params[:page], :per_page => page_size).order(date: :asc)
  end

  def view
    @transaction = Transaction.find(params[:id])
  end
end
