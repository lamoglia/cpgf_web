module TransactionAssociationMethods
  def earliest
    order(date: :asc).first
  end    

  def latest
    order(date: :desc).first
  end    

  def month_span
    first_date = self.earliest.date
    last_date = self.latest.date

    month_count = (last_date.year * 12 + last_date.month) - (first_date.year * 12 + first_date.month)
    
    if month_count == 0
      month_count = 1
    end

    return month_count
  end
end