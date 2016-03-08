class Source < ActiveRecord::Base
  validates_presence_of :file_name, :reference, :imported_at
  validates_uniqueness_of :file_name, case_sensitive: false
  validates_uniqueness_of :reference
  has_many :transactions
end
