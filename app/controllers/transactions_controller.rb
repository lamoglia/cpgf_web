

class TransactionsController < ApplicationController
  caches_action :index, :cache_path => Proc.new { |c| c.params }
  
  def index
    @transactions = Transaction.paginate(:page => params[:page], :per_page => 15).order(date: :desc)
  end

  def view
    @transaction = Transaction.find(params[:id])
  end

  def report
    @suspect_report = SuspectReport.new(suspect_report_params)

    if @suspect_report.save
      flash[:success] = 'Sua mensagem foi enviada e será analisada em breve.'
    else
      flash[:danger] = 'Ocorreu um erro ao enviar sua mensagem.'
    end

    redirect_to Transaction.find(params[:id])
  end

  private

    def suspect_report_params
      params.require(:suspect_report).permit(:name, :email, :description, :transaction_id)
    end
end