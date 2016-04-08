class Transaction < ActiveRecord::Base
  belongs_to :superior_organ
  belongs_to :subordinated_organ
  belongs_to :management_unit
  belongs_to :source
  belongs_to :person
  belongs_to :favored
  belongs_to :transaction_type
  
  validates_presence_of :superior_organ, :subordinated_organ, :management_unit, :source, :person, :favored, :transaction_type

  delegate :name, :to => :person, :prefix => true
  delegate :name, :to => :favored, :prefix => true

end