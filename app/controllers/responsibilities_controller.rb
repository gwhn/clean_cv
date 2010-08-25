class ResponsibilitiesController < ApplicationController
  before_filter :load_person_company
  before_filter :load_responsibility, :only => [:show, :edit, :update, :destroy,
                                                :move_top, :move_up, :move_down, :move_bottom]
  before_filter :new_responsibility, :only => [:new, :create, :index]
  filter_access_to :all, :attribute_check => true
  filter_access_to [:reposition, :move_top, :move_up, :move_down, :move_bottom], :require => :update

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

  # GET /people/1/company/1/responsibility/1/move_top
  def move_top
    @responsibility.move_to_top
    @responsibility.save

    respond_to do |format|
      format.html { redirect_to(@person) }
      format.xml { head :ok }
    end
  end

  # GET /people/1/company/1/responsibility/1/move_up
  def move_up
    @responsibility.move_higher
    @responsibility.save

    respond_to do |format|
      format.html { redirect_to(@person) }
      format.xml { head :ok }
    end
  end

  # GET /people/1/company/1/responsibility/1/move_down
  def move_down
    @responsibility.move_lower
    @responsibility.save

    respond_to do |format|
      format.html { redirect_to(@person) }
      format.xml { head :ok }
    end
  end

  # GET /people/1/company/1/responsibility/1/move_bottom
  def move_bottom
    @responsibility.move_to_bottom
    @responsibility.save

    respond_to do |format|
      format.html { redirect_to(@person) }
      format.xml { head :ok }
    end
  end

  protected
  def load_responsibility
    @responsibility = @company.responsibilities.find params[:id]
  end

  def new_responsibility
    @responsibility = @company.responsibilities.new params[:responsibility]
  end
end
