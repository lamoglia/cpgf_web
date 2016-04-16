class PeopleController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

	def index
    @people = Person.by_transactions_value.paginate(:page => params[:page], :per_page => 15)
    
    @people = @people.name_contains(params[:name].upcase) if params[:name].present?

    @search_term = params[:name].upcase if params[:name].present?
	end

  def view
    @person = Person.find(params[:id])
    @formatted_document = format_document(@person.masked_document)

    @transactions = @person.transactions.paginate(:page => params[:page], :per_page => 15).order('date DESC')

    @subordinated_organ = get_person_subordinated_organ(@person)
    @superior_organ = get_person_superior_organ(@person)
    @management_unit = get_person_management_unit(@person)

    @first_transaction_date = @person.transactions.order('date ASC').first.date
    @last_transaction_date = @person.transactions.order('date DESC').first.date

    month_count = (@last_transaction_date.year * 12 + @last_transaction_date.month) - (@first_transaction_date.year * 12 + @first_transaction_date.month)
    
    if month_count == 0
      month_count = 1
    end
    
    @total_spent = @person.transactions.map{|t| t.value}.reduce(0, :+)
    @monthly_average = @total_spent/month_count
  end

  private

    def format_document(doc)
      if (doc.present?) && (!doc.include? '*')
        CPF.new(doc).formatted
      else
        doc
      end
    end

    def get_person_subordinated_organ(person)
      subordinated_organs = person.transactions.pluck('DISTINCT subordinated_organ_id')

      if subordinated_organs.size == 1
        return SubordinatedOrgan.find(subordinated_organs.first).name
      end
      return nil
    end

    def get_person_management_unit(person)
      management_units = person.transactions.pluck('DISTINCT management_unit_id')

      if management_units.size == 1
        return ManagementUnit.find(management_units.first).name
      end
      return nil
    end

    def get_person_superior_organ(person)
      superior_organs = @person.transactions.pluck('DISTINCT superior_organ_id')

      if superior_organs.size == 1
        return SuperiorOrgan.find(superior_organs.first).name
      end
      return nil
    end
end
