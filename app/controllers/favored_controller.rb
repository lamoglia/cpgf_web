class FavoredController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
    @favored = Favored.joins("left join transactions on transactions.favored_id = favored.id")
                  .select("favored.*, sum(transactions.value) as total")
                  .group("favored.id")
                  .paginate(:page => params[:page], :per_page => 15)
                  .order('total desc')
  end
end
