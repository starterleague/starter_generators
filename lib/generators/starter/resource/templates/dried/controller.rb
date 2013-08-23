class <%= plural_name.camelize %>Controller < ApplicationController

  before_action :set_<%= singular_name.underscore %>, only: [:show, :edit, :update, :destroy]

  def index
    @<%= plural_name.underscore %> = <%= class_name %>.all
  end

  def show
  end

  def new
    @<%= singular_name.underscore %> = <%= class_name %>.new
  end

  def create
    @<%= singular_name.underscore %> = <%= class_name %>.new
    <% attributes.each do |attribute| -%>
@<%= singular_name.underscore %>.<%= attribute.name %> = params[:<%= singular_name.underscore %>][:<%= attribute.name %>]
    <% end %>
<% if named_routes? -%>
    if @<%= singular_name.underscore %>.save
      redirect_to <%= plural_name %>_url
    else
      render 'new'
    end
<% else -%>
    if @<%= singular_name.underscore %>.save
      redirect_to "/<%= plural_name %>"
    else
      render 'new'
    end
<% end -%>
  end

  def edit
  end

  def update
    <% attributes.each do |attribute| -%>
@<%= singular_name.underscore %>.<%= attribute.name %> = params[:<%= singular_name.underscore %>][:<%= attribute.name %>]
    <% end %>
<% if named_routes? -%>
    if @<%= singular_name.underscore %>.save
      redirect_to <%= plural_name %>_url
    else
      render 'new'
    end
<% else -%>
    if @<%= singular_name.underscore %>.save
      redirect_to "/<%= plural_name %>"
    else
      render 'new'
    end
<% end -%>
  end

  def destroy
    @<%= singular_name.underscore %>.destroy
<% if named_routes? -%>
    redirect_to <%= plural_name %>_url
<% else -%>
    redirect_to "/<%= plural_name %>"
<% end -%>
  end

private

  def set_<%= singular_name.underscore %>
    @<%= singular_name.underscore %> = <%= class_name %>.find(params[:id])
  end
end
