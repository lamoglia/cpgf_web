class TransactionsController < ApplicationController
  caches_action :index, :cache_path => Proc.new { |c| c.params }
  caches_page :view
  
  def index
    @transactions = Transaction.paginate(:page => params[:page], :per_page => 15).order(date: :desc)
  end

  def view
    @transaction = Transaction.find(params[:id])
  end

  def report
    @suspect_report = SuspectReport.new(suspect_report_params)
    
    @suspect_report.transactions.remove(' ').split(',').uniq do |id|
      if !Transaction.find_by id: id
        flash[:danger] = "A transação informada (código \"#{id}\") não existe.";
        redirect_to Transaction.find(params[:id])
        return
      end
    end

    if @suspect_report.save
      flash[:success] = 'Sua mensagem foi enviada e será analisada em breve. Obrigado.'
    else
      flash[:danger] = 'Ocorreu um erro ao enviar sua mensagem. Tente novamente mais tarde.'
    end

    redirect_to Transaction.find(params[:id])
  end

  private

    def suspect_report_params
      params.require(:suspect_report).permit(:name, :email, :description, :transactions)
    end
end
