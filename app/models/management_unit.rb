class ManagementUnit < ActiveRecord::Base
  has_many :transactions
end
