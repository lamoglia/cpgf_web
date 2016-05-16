class SuspectReport < ActiveRecord::Base
  before_save { self.email = email.downcase }
  validates :email,  length: { maximum: 64 }
  validates :name,  length: { maximum: 64 }
  validates :description,  presence: true, length: { maximum: 500 }
  validates :transactions,  presence: true, length: { maximum: 200 }
end
