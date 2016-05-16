class SuspectReport < ActiveRecord::Base
  belongs_to :cpgf_transaction, class_name: "Transaction", foreign_key: 'transaction_id'

  before_save { 
    self.email = email.strip.downcase 
    self.name = name.strip
    self.description = description.strip
  }
  validates :email,  length: { maximum: 64 }
  validates :name,  length: { maximum: 64 }
  validates :description,  presence: true, length: { maximum: 500 }

  validates_presence_of :cpgf_transaction
end
