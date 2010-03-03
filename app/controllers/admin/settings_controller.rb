class Admin::SettingsController < ApplicationController
  layout 'administrator'

  def index
    @admin_settings = Admin::Setting.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admin_settings }
    end
  end


  def show
    @setting = Setting.find(params[:id])
    send_file @setting.setting_pdf.path, :type => @setting.setting_pdf_content_type, :disposition => 'attachment', :x_sendfile => true
  end


  # GET /admin_settings/new
  # GET /admin_settings/new.xml
  def new
    @setting = Setting.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @setting }
    end
  end

  # GET /admin_settings/1/edit
  def edit
    @setting = Setting.find(params[:id])
  end

  # POST /admin_settings
  # POST /admin_settings.xml
  def create
    @setting = Setting.new(params[:setting])

    respond_to do |format|
      if @setting.save
        flash[:notice] = 'Admin::Setting was successfully created.'
        format.html { redirect_to(admin_orders_path ) }
        format.xml  { render :xml => @setting, :status => :created, :location => @setting }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @setting.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin_settings/1
  # PUT /admin_settings/1.xml
  def update
    @setting = Setting.find(params[:id])

    respond_to do |format|
      if @setting.update_attributes(params[:setting])
        flash[:notice] = 'Admin::Setting was successfully updated.'
        format.html { redirect_to(admin_orders_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @setting.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_settings/1
  # DELETE /admin_settings/1.xml
  def destroy
    @setting = Setting.find(params[:id])
    @setting.destroy

    respond_to do |format|
      format.html { redirect_to(admin_settings_url) }
      format.xml  { head :ok }
    end
  end
end

