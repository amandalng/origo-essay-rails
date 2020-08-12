class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @show_banner = true
    @show_footer = true
  end
end
