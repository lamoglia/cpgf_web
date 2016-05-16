class FavoredController < ApplicationController
  caches_action :index, :cache_path => Proc.new { |c| c.params }
  caches_action :view, :cache_path => Proc.new { |c| c.params }
  
  def index
    @favored = Favored.order(total_transactions: :desc).paginate(:page => params[:page], :per_page => 15)
    
    unless params[:name].nil?
      @search_term = params[:name].strip
      @favored = @favored.name_contains(I18n.transliterate(@search_term).upcase)
    end
  end

  def view
    page_size = 15
    @favored = Favored.find(params[:id])

    if !params[:page].present? 
      last_page = (@favored.transactions.count / page_size.to_f).ceil
      redirect_to favored_path_url id: params[:id], page: last_page unless params[:page].present?
    end

    @transactions = @favored.transactions.paginate(:page => params[:page], :per_page => page_size).order(date: :asc)
    @formatted_document = format_document(@favored.masked_document)

    @first_transaction_date = @favored.earliest_transaction.date
    @last_transaction_date = @favored.latest_transaction.date

    @monthly_average = @favored.monthly_transactions_avg
  end

  private
    def format_document(doc)
      if (doc.present?) && (!doc.include? '*')
        CNPJ.new(doc).formatted
      else
        doc
      end
    end
end
