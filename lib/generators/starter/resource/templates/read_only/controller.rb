class <%= plural_name.camelize %>Controller < ApplicationController
  def index
    @<%= plural_name.underscore %> = <%= class_name %>.all
  end

  def show
    @<%= singular_name.underscore %> = <%= class_name %>.find(params[:id])
  end
end
