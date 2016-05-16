class Transaction < ActiveRecord::Base
  belongs_to :superior_organ
  belongs_to :subordinated_organ
  belongs_to :management_unit
  belongs_to :source
  belongs_to :person
  belongs_to :favored
  belongs_to :transaction_type
  has_many :suspect_report
  
  validates_presence_of :superior_organ, :subordinated_organ, :management_unit, :source, :person, :favored, :transaction_type, :value
  
  delegate :name, :to => :person, :prefix => true
  delegate :name, :to => :favored, :prefix => true
  delegate :name, :to => :management_unit, :prefix => true
  delegate :name, :to => :superior_organ, :prefix => true
  delegate :name, :to => :subordinated_organ, :prefix => true
  delegate :description, :to => :transaction_type, :prefix => true
  delegate :friendly_description, :to => :transaction_type, :prefix => true
end