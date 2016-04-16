class Favored < ActiveRecord::Base
  has_many :transactions

  scope :name_contains, -> (name) { where("name like ?", "%#{name}%")}

  scope :with_total_transactions, -> { joins("left join transactions on transactions.favored_id = favored.id")
                  .select("favored.*, sum(transactions.value) as total")
                  .group("favored.id")
                  .order('total desc') }
end
