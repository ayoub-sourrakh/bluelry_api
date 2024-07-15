class HomeController < ApplicationController
  def index
    Rails.logger.info("Home controller index action");
    Rails.logger.info("It's me mario.");
  end
end
