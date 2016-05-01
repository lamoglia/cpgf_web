class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include ActionController::Caching::Pages

  include MetaTagsHelper
  include ChartsHelper

  before_action :prepare_meta_tags, if: "request.get?"

  
end