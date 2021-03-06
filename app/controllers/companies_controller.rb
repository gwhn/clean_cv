class CompaniesController < ApplicationController
  before_filter :load_person
  before_filter :load_company, :only => [:show, :edit, :update, :delete, :destroy]
  before_filter :new_company, :only => [:new, :create, :index]
  filter_access_to :all, :attribute_check => true

  # GET /people/1/companies
  # GET /people/1/companies.xml
  def index
    @companies = @person.companies

    respond_to do |format|
      format.html # index.html.haml
      format.xml { render :xml => @companies }
    end
  end

  # GET /people/1/companies/1
  # GET /people/1/companies/1.xml
  def show
    respond_to do |format|
      format.html # show.html.haml
      format.xml { render :xml => @company }
    end
  end

  # GET /people/1/companies/new
  # GET /people/1/companies/new.xml
  def new
    respond_to do |format|
      format.html # new.html.haml
      format.xml { render :xml => @company }
    end
  end

  # GET /people/1/companies/1/edit
  def edit
  end

  # POST /people/1/companies
  # POST /people/1/companies.xml
  def create
    respond_to do |format|
      if @company.save
        flash[:notice] = "#{@company.name} was successfully created."
        format.html { redirect_to @person }
        format.xml { render :xml => @company, :status => :created, :location => @company }
        format.js { render :layout => false }
      else
        format.html { render :action => :new }
        format.xml { render :xml => @company.errors, :status => :unprocessable_entity }
        format.js { render :action => :invalid, :layout => false }
      end
    end
  end

  # PUT /people/1/companies/1
  # PUT /people/1/companies/1.xml
  def update
    respond_to do |format|
      if @company.update_attributes(params[:company])
        flash[:notice] = "#{@company.name} was successfully updated."
        format.html { redirect_to @person }
        format.xml { head :ok }
        format.js { @company.reload and render :layout => false }
      else
        format.html { render :action => :edit }
        format.xml { render :xml => @company.errors, :status => :unprocessable_entity }
        format.js { render :action => :invalid, :layout => false }
      end
    end
  end

  # GET /people/1/companies/1/delete
  def delete
    respond_to do |format|
      format.html # delete.html.haml
    end
  end

  # DELETE /people/1/companies/1
  # DELETE /people/1/companies/1.xml
  def destroy
    redirect_to @person and return if params[:cancel]
    
    flash[:notice] = "#{@company.name} was successfully deleted." if @company.destroy

    respond_to do |format|
      format.html { redirect_to @person }
      format.xml { head :ok }
      format.js
    end
  end

  protected
  def load_company
    @company = @person.companies.find params[:id]
  end

  def new_company
    @company = @person.companies.new params[:company]
  end
end
