class ManagementUnit < ActiveRecord::Base
  include TransactionCalculators

  has_many :transactions, :extend => TransactionAssociationMethods

  def total_transactions
    Transaction.where(:management_unit_id => id).sum(:value)
  end

  def to_param
    "#{id}-#{name}".parameterize
  end

  def self.name_contains(name) 
    where("name like ?", "%#{name}%")
  end
  
  def self.top_transaction_proportions(limit = 5)
    management_units_total = Array.new

    total = Transaction.sum('value');
    Transaction.select("*, sum(value) as total").group("management_unit_id").order("total DESC").limit(limit).each do | rec |
      management_unit = ManagementUnit.find(rec.management_unit_id)
      management_units_total << {id: management_unit.id, name: management_unit.name , percentage: (rec.total.to_f/total) * 100}
    end

    return management_units_total
  end
end
