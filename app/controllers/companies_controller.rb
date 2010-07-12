class CompaniesController < ApplicationController
  before_filter :find_person
  # GET /people/1/companies
  # GET /people/1/companies.xml
  def index
    @companies = @person.companies

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @companies }
    end
  end

  # GET /people/1/companies/1
  # GET /people/1/companies/1.xml
  def show
    @company = @person.companies.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @company }
    end
  end

  # GET /people/1/companies/new
  # GET /people/1/companies/new.xml
  def new
    @company = Company.new

    respond_to do |format|
      format.html # new.html.erb
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
    @company = Company.new(params[:company])

    respond_to do |format|
      if @person.companies << @company
        flash[:notice] = 'Company was successfully created.'
        format.html { redirect_to(person_companies_url(@person)) }
        format.xml  { render :xml => @company, :status => :created, :location => @company }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @company.errors, :status => :unprocessable_entity }
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
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @company.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1/companies/1
  # DELETE /people/1/companies/1.xml
  def destroy
    company = @person.companies.find(params[:id])
    @person.companies.destroy(company)

    respond_to do |format|
      format.html { redirect_to(person_companies_url(@person)) }
      format.xml  { head :ok }
    end
  end

end
