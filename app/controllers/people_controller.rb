class PeopleController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

	def index
    @people = Person.order(total_transactions: :desc).paginate(:page => params[:page], :per_page => 15)
    
    @people = @people.name_contains(params[:name].upcase) unless params[:name].nil?

    @search_term = params[:name] unless params[:name].nil?
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
