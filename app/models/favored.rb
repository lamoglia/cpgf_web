class Favored < ActiveRecord::Base
  has_many :transactions

  scope :name_contains, -> (name) { where("name like ?", "%#{name}%")}
end
