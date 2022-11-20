class Admin::Base < ApplicationController
  before_action :authenticate_admin!
  layout 'admin'
end