class PeopleController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

	def index
    @people = Person.joins("left join transactions on transactions.person_id = people.id")
                  .select("people.*, sum(transactions.value) as total")
                  .group("people.id")
                  .paginate(:page => params[:page], :per_page => 15)
                  .order('total desc')

    
    @people = @people.name_contains(params[:name].upcase) if params[:name].present?

    @search_term = params[:name].upcase if params[:name].present?
	end

  def view
    @person = Person.find(params[:id])

    @transactions = @person.transactions.paginate(:page => params[:page], :per_page => 15).order('date DESC')
  end

end
