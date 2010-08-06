class ResponsibilitiesController < ApplicationController
  filter_resource_access :nested_in => :companies,
                         :additional_collection => {:reposition => :update}

  # GET /people/1/company/1/responsibilities
  # GET /people/1/company/1/responsibilities.xml
  def index
    @responsibilities = @company.responsibilities

    respond_to do |format|
      format.html # index.html.haml
      format.xml { render :xml => @responsibilities }
    end
  end

  # GET /people/1/company/1/responsibilities/1
  # GET /people/1/company/1/responsibilities/1.xml
  def show
    respond_to do |format|
      format.html # show.html.haml
      format.xml { render :xml => @responsibility }
    end
  end

  # GET /people/1/company/1/responsibilities/new
  # GET /people/1/company/1/responsibilities/new.xml
  def new
    respond_to do |format|
      format.html # new.html.haml
      format.xml { render :xml => @responsibility }
    end
  end

  # GET /people/1/company/1/responsibilities/1/edit
  def edit
  end

  # POST /people/1/company/1/responsibilities
  # POST /people/1/company/1/responsibilities.xml
  def create
    respond_to do |format|
      if @responsibility.save
        flash[:notice] = 'Responsibility was successfully created.'
        format.html { redirect_to(person_company_responsibility_url(@person, @company, @responsibility)) }
        format.xml { render :xml => @responsibility, :status => :created, :location => @responsibility }
      else
        format.html { render :action => :new }
        format.xml { render :xml => @responsibility.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /people/1/company/1/responsibilities/1
  # PUT /people/1/company/1/responsibilities/1.xml
  def update
    respond_to do |format|
      if @responsibility.update_attributes(params[:responsibility])
        flash[:notice] = 'Responsibility was successfully updated.'
        format.html { redirect_to(person_company_responsibility_url(@person, @company, @responsibility)) }
        format.xml { head :ok }
      else
        format.html { render :action => :edit }
        format.xml { render :xml => @responsibility.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1/company/1/responsibilities/1
  # DELETE /people/1/company/1/responsibilities/1.xml
  def destroy
    @responsibility.destroy

    respond_to do |format|
      format.html { redirect_to(person_company_responsibilities_url(@person, @company)) }
      format.xml { head :ok }
    end
  end

  # PUT /people/1/company/1/responsibilities/reposition
  def reposition
    @company.responsibilities.each do |resp|
      resp.position = params[:responsibility].index(resp.id.to_s) + 1
      resp.save
    end

    render :nothing => true
  end

end
