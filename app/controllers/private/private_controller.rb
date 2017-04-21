class Private::PrivateController < ApplicationController
  layout 'cim'
  before_action :authenticate_user!
end
