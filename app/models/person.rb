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
    subordinated_organs_ids = transactions.pluck(:subordinated_organ_id).uniq
    return SubordinatedOrgan.where(id: subordinated_organs_ids).collect(&:name).sort()
  end

  def get_management_unit
    management_units_ids = transactions.pluck(:management_unit_id).uniq
    return ManagementUnit.where(id: management_units_ids).collect(&:name).sort()
  end

  def get_superior_organ
    superior_organs_ids = transactions.pluck(:superior_organ_id).uniq
    return SuperiorOrgan.where(id: superior_organs_ids).collect(&:name).sort()
  end
end
