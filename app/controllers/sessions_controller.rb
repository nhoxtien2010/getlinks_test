class SessionsController < ActiveAdmin::Devise::SessionsController
  # we will override some methods here

  def create
    p params
    super
  end

end
