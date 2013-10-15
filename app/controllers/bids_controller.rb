class BidsController < ApplicationController
  before_filter :authenticate_user!

  def new
  	puts "NEW"
  end

  def create
  	puts "NEW"
  end
end
