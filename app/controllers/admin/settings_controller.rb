class Admin::SettingsController < ApplicationController

  def index
    @admin_settings = Admin::Setting.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admin_settings }
    end
  end


  def show
    @setting = Admin::Setting.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @setting }
    end
  end

  # GET /admin_settings/new
  # GET /admin_settings/new.xml
  def new
    @setting = Admin::Setting.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @setting }
    end
  end

  # GET /admin_settings/1/edit
  def edit
    @setting = Admin::Setting.find(params[:id])
  end

  # POST /admin_settings
  # POST /admin_settings.xml
  def create
    @setting = Admin::Setting.new(params[:setting])

    respond_to do |format|
      if @setting.save
        flash[:notice] = 'Admin::Setting was successfully created.'
        format.html { redirect_to(@setting) }
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
    @setting = Admin::Setting.find(params[:id])

    respond_to do |format|
      if @setting.update_attributes(params[:setting])
        flash[:notice] = 'Admin::Setting was successfully updated.'
        format.html { redirect_to(@setting) }
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
    @setting = Admin::Setting.find(params[:id])
    @setting.destroy

    respond_to do |format|
      format.html { redirect_to(admin_settings_url) }
      format.xml  { head :ok }
    end
  end
end
