class SiteController < ApplicationController

  caches_page :index, :about

  def index
    @yearly_total_chart = build_yearly_total_chart;

    @summary_by_favored = get_summary_by_favored
    @summary_by_person = get_summary_by_person

    @total_by_superior_organ_chart = build_total_by_superior_organ_chart;

    @last_source = Source.order("created_at").last;
  end

  def about
  end

  private 
    def get_summary_by_person
      summary_by_person = Person.order(total_transactions: :desc).limit(10)
    end

    def get_summary_by_favored
      summary_by_favored = Favored.order(total_transactions: :desc).limit(10)
    end

end
