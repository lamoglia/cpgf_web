class PeopleController < ApplicationController
  caches_action :index, :cache_path => Proc.new { |c| c.params }
  caches_action :view, :cache_path => Proc.new { |c| c.params }
  
	def index
    @people = Person.order(total_transactions: :desc).paginate(:page => params[:page], :per_page => 15)
    
    unless params[:name].nil?
      @search_term = params[:name].strip
      transliterated_search_term = I18n.transliterate(@search_term);
      if @search_term.numeric?
        @people = @people.filter_by_cpf(transliterated_search_term)
      else        
        @people = @people.name_contains(transliterated_search_term.upcase)
      end
    end
	end

  def view
    @person = Person.find(params[:id])
    @formatted_document = format_document(@person.masked_document)

    @transactions = @person.transactions.paginate(:page => params[:page], :per_page => 15).order(date: :desc)

    @subordinated_organ = @person.get_subordinated_organ
    @superior_organ = @person.get_superior_organ
    @management_unit = @person.get_management_unit

    @first_transaction_date = @person.earliest_transaction.date
    @last_transaction_date = @person.latest_transaction.date

    @monthly_average = @person.monthly_transactions_avg
  end

  private

    def format_document(doc)
      if (doc.present?) && (!doc.include? '*')
        CPF.new(doc).formatted
      else
        doc
      end
    end
end
