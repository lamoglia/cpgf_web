class Person < ActiveRecord::Base
  include TransactionCalculators

  has_many :transactions, :extend => TransactionAssociationMethods

  def to_param
    "#{id}-#{name}".parameterize
  end
  
  def self.name_contains(name) 
    where("name like ?", "%#{name}%")
  end

  def get_subordinated_organ
    subordinated_organs_ids = transactions.pluck('DISTINCT subordinated_organ_id')
    return SubordinatedOrgan.find(subordinated_organs_ids).collect(&:name).sort()
  end

  def get_management_unit
    management_units_ids = transactions.pluck('DISTINCT management_unit_id')
    return ManagementUnit.find(management_units_ids).collect(&:name).sort()
  end

  def get_superior_organ
    superior_organs_ids = transactions.pluck('DISTINCT superior_organ_id')
    return SuperiorOrgan.find(superior_organs_ids).collect(&:name).sort()
  end
end
