module TransactionCalculators
  def earliest_transaction
    transactions.earliest
  end

  def latest_transaction
    transactions.latest
  end

  def monthly_transactions_avg
    total_transactions / transactions.month_span
  end
end