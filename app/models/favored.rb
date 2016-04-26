class Favored < ActiveRecord::Base
  include TransactionCalculators
  
  has_many :transactions, :extend => TransactionAssociationMethods
  
  def to_param
    "#{id}-#{name}".parameterize
  end
  
  def self.name_contains(name) 
    where("name like ?", "%#{name}%")
  end
end
