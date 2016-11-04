class <%= plural_name.camelize %>Controller < ApplicationController
  def index
    @<%= plural_name.underscore %> = <%= class_name %>.all

    render("<%= plural_name.underscore %>/index.html.erb")
  end

  def show
    @<%= singular_name.underscore %> = <%= class_name %>.find(params[:id])

    render("<%= plural_name.underscore %>/show.html.erb")
  end

  def new
    @<%= singular_name.underscore %> = <%= class_name %>.new

    render("<%= plural_name.underscore %>/new.html.erb")
  end

  def create
    @<%= singular_name.underscore %> = <%= class_name %>.new

<% attributes.each do |attribute| -%>
    @<%= singular_name.underscore %>.<%= attribute.name %> = params[:<%= attribute.name %>]
<% end -%>

<% if named_routes? -%>
    if @<%= singular_name.underscore %>.save
      redirect_to :back, :notice => "<%= singular_name.humanize %> created successfully."
    else
      render("<%= plural_name.underscore %>/new.html.erb")
    end
<% else -%>
    save_status = @<%= singular_name.underscore %>.save

    if save_status == true
      redirect_to(:back, :notice => "<%= singular_name.humanize %> created successfully.")
    else
      render("<%= plural_name.underscore %>/new.html.erb")
    end
<% end -%>
  end

  def edit
    @<%= singular_name.underscore %> = <%= class_name %>.find(params[:id])

    render("<%= plural_name.underscore %>/edit.html.erb")
  end

  def update
    @<%= singular_name.underscore %> = <%= class_name %>.find(params[:id])

<% attributes.each do |attribute| -%>
    @<%= singular_name.underscore %>.<%= attribute.name %> = params[:<%= attribute.name %>]
<% end -%>

<% if named_routes? -%>
    if @<%= singular_name.underscore %>.save
      redirect_to <%= singular_name %>_url(@<%= singular_name %>.id), :notice => "<%= singular_name.humanize %> updated successfully."
    else
      render("<%= plural_name.underscore %>/edit.html.erb")
    end
<% else -%>
    save_status = @<%= singular_name.underscore %>.save

    if save_status == true
      redirect_to(:back, :notice => "<%= singular_name.humanize %> updated successfully.")
    else
      render("<%= plural_name.underscore %>/edit.html.erb")
    end
<% end -%>
  end

  def destroy
    @<%= singular_name.underscore %> = <%= class_name %>.find(params[:id])

    @<%= singular_name.underscore %>.destroy

    redirect_to(:back, :notice => "<%= singular_name.humanize %> deleted.")
  end
end
