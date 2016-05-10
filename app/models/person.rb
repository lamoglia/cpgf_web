class Person < ActiveRecord::Base
  include TransactionCalculators

  has_many :transactions, :extend => TransactionAssociationMethods

  def to_param
    "#{id}-#{name}".parameterize
  end
  
  def self.name_contains(name) 
    where("name like ?", "%#{name}%")
  end

  def self.cpf_contains(name) 
    where("masked_document like ?", "%#{name}%")
  end

  def self.filter_by_cpf(cpf)
    transliterated_cpf = I18n.transliterate(cpf);  
    if cpf.size == 11
      where('masked_document = ? or masked_document = ?',transliterated_cpf, "***#{transliterated_cpf[3...-3]}***")
    else
      cpf_contains(transliterated_cpf)
    end
  end

  def get_subordinated_organ
    subordinated_organs_ids = transactions.pluck(:subordinated_organ_id).uniq
    return SubordinatedOrgan.where(id: subordinated_organs_ids).collect(&:name).sort()
  end

  def get_management_unit
    management_units_ids = transactions.pluck(:management_unit_id).uniq
    return ManagementUnit.where(id: management_units_ids).sort()
  end

  def get_superior_organ
    superior_organs_ids = transactions.pluck(:superior_organ_id).uniq
    return SuperiorOrgan.where(id: superior_organs_ids).collect(&:name).sort()
  end
end
