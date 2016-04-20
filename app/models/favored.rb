class Favored < ActiveRecord::Base
  include TransactionCalculators
  
  has_many :transactions, :extend => TransactionAssociationMethods
  
  def self.name_contains(name) 
    where("name like ?", "%#{name}%")
  end
end
