class <%= plural_name.camelize %>Controller < ApplicationController

  def index
    @<%= plural_name.underscore %> = <%= class_name %>.all
  end

  def show
    @<%= singular_name.underscore %> = <%= class_name %>.find_by(id: params[:id])
  end

  def new
  end

  def create
    @<%= singular_name.underscore %> = <%= class_name %>.new
<% attributes.each do |attribute| -%>
    @<%= singular_name.underscore %>.<%= attribute.name %> = params[:<%= attribute.name %>]
<% end -%>

<% if named_routes? -%>
    if @<%= singular_name.underscore %>.save
      redirect_to <%= plural_name %>_url, notice: "<%= singular_name.humanize %> created successfully."
    else
      render 'new'
    end
<% else -%>
    if @<%= singular_name.underscore %>.save
      redirect_to "/<%= plural_name %>", notice: "<%= singular_name.humanize %> created successfully."
    else
      render 'new'
    end
<% end -%>
  end

  def edit
    @<%= singular_name.underscore %> = <%= class_name %>.find_by(id: params[:id])
  end

  def update
    @<%= singular_name.underscore %> = <%= class_name %>.find_by(id: params[:id])
<% attributes.each do |attribute| -%>
    @<%= singular_name.underscore %>.<%= attribute.name %> = params[:<%= attribute.name %>]
<% end -%>

<% if named_routes? -%>
    if @<%= singular_name.underscore %>.save
      redirect_to <%= plural_name %>_url, notice: "<%= singular_name.humanize %> updated successfully."
    else
      render 'edit'
    end
<% else -%>
    if @<%= singular_name.underscore %>.save
      redirect_to "/<%= plural_name %>", notice: "<%= singular_name.humanize %> updated successfully."
    else
      render 'edit'
    end
<% end -%>
  end

  def destroy
    @<%= singular_name.underscore %> = <%= class_name %>.find_by(id: params[:id])
    @<%= singular_name.underscore %>.destroy

<% if named_routes? -%>
    redirect_to <%= plural_name %>_url, notice: "<%= singular_name.humanize %> deleted."
<% else -%>
    redirect_to "/<%= plural_name %>", notice: "<%= singular_name.humanize %> deleted."
<% end -%>
  end
end
