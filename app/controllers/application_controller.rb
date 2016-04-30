class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include MetaTagsHelper
  include ChartsHelper

  before_action :prepare_meta_tags, if: "request.get?"

  def index
    @yearly_total_chart = build_yearly_total_chart();

    @summary_by_favored = Favored.order(total_transactions: :desc).limit(10)
    @summary_by_person = Person.order(total_transactions: :desc).limit(10)
    @total_by_superior_organ_chart = build_total_by_superior_organ_chart();
  end

  def about
  end

end