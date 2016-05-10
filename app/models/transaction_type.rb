class TransactionType < ActiveRecord::Base
  has_many :transactions

  def self.top_transaction_proportions(limit = 5)
    transaction_types_total = Array.new

    total = Transaction.sum('value');
    Transaction.select("transaction_type_id, sum(value) as total").group("transaction_type_id").order("total DESC").limit(limit).each do | rec |
      transaction_type = TransactionType.find(rec.transaction_type_id)
      transaction_types_total << {name: transaction_type.friendly_description || transaction_type.description , percentage: (rec.total.to_f/total) * 100}
    end

    return transaction_types_total
  end
end
