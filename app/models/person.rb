class Person < ActiveRecord::Base
  has_many :transactions

  scope :name_contains, -> (name) { where("name like ?", "%#{name}%")}

  scope :with_total_transactions, -> { joins("left join transactions on transactions.person_id = people.id")
                  .select("people.*, sum(transactions.value) as total")
                  .group("people.id")
                  .order('total desc') }
end
