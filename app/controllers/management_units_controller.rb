class ManagementUnitsController < ApplicationController
  caches_action :index, :cache_path => Proc.new { |c| c.params }
  caches_action :view, :cache_path => Proc.new { |c| c.params }
  
	def index
    @management_units = ManagementUnit.joins(:transactions).select('*, sum(value) as total').group('management_unit_id').order('total DESC').paginate(:page => params[:page], :per_page => 15)
    
    unless params[:name].nil?
      @search_term = params[:name].strip
      @management_units = @management_units.name_contains(I18n.transliterate(@search_term).upcase) unless params[:name].nil?
    end
	end

  def view
    @management_unit = ManagementUnit.find(params[:id])
    @transactions = @management_unit.transactions.paginate(:page => params[:page], :per_page => 15).order(date: :desc)

    @first_transaction_date = @management_unit.earliest_transaction.date
    @last_transaction_date = @management_unit.latest_transaction.date

    @monthly_average = @management_unit.monthly_transactions_avg
  end
end
