class CompaniesController < ApplicationController
  before_filter :find_person
  # GET /people/1/companies
  # GET /people/1/companies.xml
  def index
    @companies = @person.companies

    respond_to do |format|
      format.html # index.html.haml
      format.xml  { render :xml => @companies }
    end
  end

  # GET /people/1/companies/1
  # GET /people/1/companies/1.xml
  def show
    @company = @person.companies.find(params[:id])

    respond_to do |format|
      format.html # show.html.haml
      format.xml  { render :xml => @company }
    end
  end

  # GET /people/1/companies/new
  # GET /people/1/companies/new.xml
  def new
    @company = Company.new

    respond_to do |format|
      format.html # new.html.haml
      format.xml  { render :xml => @company }
    end
  end

  # GET /people/1/companies/1/edit
  def edit
    @company = @person.companies.find(params[:id])
  end

  # POST /people/1/companies
  # POST /people/1/companies.xml
  def create
    @company = @person.companies.new(params[:company])

    respond_to do |format|
      if @company.save
        flash[:notice] = 'Company was successfully created.'
        format.html { redirect_to(person_companies_url(@person)) }
        format.xml  { render :xml => @company, :status => :created, :location => @company }
        format.js   { render :layout => false }
      else
        format.html { render :action => :new }
        format.xml  { render :xml => @company.errors, :status => :unprocessable_entity }
        format.js   { render :action => :invalid, :layout => false }
      end
    end
  end

  # PUT /people/1/companies/1
  # PUT /people/1/companies/1.xml
  def update
    @company = @person.companies.find(params[:id])

    respond_to do |format|
      if @company.update_attributes(params[:company])
        flash[:notice] = 'Company was successfully updated.'
        format.html { redirect_to(person_companies_url(@person)) }
        format.xml  { head :ok }
        format.js   { render :layout => false }
      else
        format.html { render :action => :edit }
        format.xml  { render :xml => @company.errors, :status => :unprocessable_entity }
        format.js   { render :action => :invalid, :layout => false }
      end
    end
  end

  # GET /people/1/companies/1/delete
  def delete
    @company = @person.companies.find(params[:id])

    respond_to do |format|
      format.html # delete.html.haml
    end
  end

  # DELETE /people/1/companies/1
  # DELETE /people/1/companies/1.xml
  def destroy
    @company = @person.companies.find(params[:id])
    redirect_to(person_company_url(@person, @company)) and return if params[:cancel]
    @company.destroy

    respond_to do |format|
      format.html { redirect_to(person_companies_url(@person)) }
      format.xml  { head :ok }
      format.js
    end
  end

end
