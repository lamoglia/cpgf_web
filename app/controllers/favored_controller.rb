class FavoredController < ApplicationController
  caches_action :index, :cache_path => Proc.new { |c| c.params }
  caches_action :view, :cache_path => Proc.new { |c| c.params }
  
  def index
    @favored = Favored.order(total_transactions: :desc).paginate(:page => params[:page], :per_page => 15)
    
    @favored = @favored.name_contains(I18n.transliterate(params[:name]).upcase) unless params[:name].nil?

    @search_term = params[:name] unless params[:name].nil?
  end

  def view
    @favored = Favored.find(params[:id])

    @transactions = @favored.transactions.paginate(:page => params[:page], :per_page => 15).order(date: :desc)
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
