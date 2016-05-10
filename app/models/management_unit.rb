class ManagementUnit < ActiveRecord::Base
  has_many :transactions

  def self.top_transaction_proportions(limit = 5)
    management_units_total = Array.new

    total = Transaction.sum('value');
    Transaction.select("management_unit_id, sum(value) as total").group("management_unit_id").order("total DESC").limit(limit).each do | rec |
      management_unit = ManagementUnit.find(rec.management_unit_id)
      management_units_total << {name: management_unit.name , percentage: (rec.total.to_f/total) * 100}
    end

    return management_units_total
  end
end
