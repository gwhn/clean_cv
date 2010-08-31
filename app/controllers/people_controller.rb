class PeopleController < ApplicationController
  skip_before_filter :require_user, :only => [:index, :show]

  before_filter :load_person, :only => [:show, :edit, :update, :delete, :destroy]
  before_filter :new_person_from_params, :only => [:new, :create]
  filter_access_to :all, :attribute_check => true
  filter_access_to :index, :attribute_check => false

  caches_action :index, :show

  # GET /people
  # GET /people.xml
  def index
    sort_by = %w{  name email  }.detect { |f| f == params[:order] } || 'id'
    direction = params[:direction] =~ %r(desc)i ? 'DESC' : 'ASC'
    @people = Person.paginate :page => params[:page], :per_page => 1, :order => "#{sort_by} #{direction}"

    respond_to do |format|
      format.html # index.html.haml
      format.xml { render :xml => @people }
    end
  end

  # GET /people/1
  # GET /people/1.xml
  def show
    respond_to do |format|
      format.html # show.html.haml
      format.xml { render :xml => @person }
    end
  end

  # GET /people/new
  # GET /people/new.xml
  def new
    respond_to do |format|
      format.html # new.html.haml
      format.xml { render :xml => @person }
    end
  end

  # GET /people/1/edit
  def edit
  end

  # POST /people
  # POST /people.xml
  def create
    respond_to do |format|
      if @person.save
        flash[:notice] = 'Person was successfully created.'
        format.html { redirect_to(@person) }
        format.xml { render :xml => @person, :status => :created, :location => @person }
        format.js do
          responds_to_parent { render :action => :show }
        end
      else
        format.html { render :action => :new }
        format.xml { render :xml => @person.errors, :status => :unprocessable_entity }
        format.js do
          responds_to_parent { render :template => 'people/invalid', :layout => false,
                                      :locals => {:person => @person,
                                                  :url => people_path(:format => :js)} }
        end
      end
    end
  end

  # PUT /people/1
  # PUT /people/1.xml
  def update
    respond_to do |format|
      if @person.update_attributes(params[:person])
        flash[:notice] = 'Person was successfully updated.'
        format.html { redirect_to(@person) }
        format.xml { head :ok }
        format.js do
          responds_to_parent { render :action => :show }
        end
      else
        format.html { render :action => :edit }
        format.xml { render :xml => @person.errors, :status => :unprocessable_entity }
        format.js do
          responds_to_parent { render :template => 'people/invalid', :layout => false,
                                      :locals => {:person => @person,
                                                  :url => person_path(@person, :format => :js)} }
        end
      end
    end
  end

  # GET /people/1/delete
  def delete
    respond_to do |format|
      format.html # delete.html.haml
    end
  end

  # DELETE /people/1
  # DELETE /people/1.xml
  def destroy
    redirect_to(@person) and return if params[:cancel]
    @person.destroy

    respond_to do |format|
      format.html { redirect_to people_url }
      format.xml { head :ok }
      format.js { render :action => :index }
    end
  end

  protected
  def new_person_from_params
    @person = Person.new params[:person]
    @person.user = current_user
  end

  def load_person
    @person = Person.find params[:id]
  end
end
