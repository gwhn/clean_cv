class PeopleController < ApplicationController
  skip_before_filter :authorize, :only => [:index, :show]

  caches_action :index, :show

  # GET /people
  # GET /people.xml
  def index
    sort_by = %w(   name job_title email   ).detect { |f| f == params[:order] } || 'id'
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
    @person = Person.find(params[:id])

    respond_to do |format|
      format.html # show.html.haml
      format.xml { render :xml => @person }
    end
  end

  # GET /people/new
  # GET /people/new.xml
  def new
    @person = Person.new

    respond_to do |format|
      format.html # new.html.haml
      format.xml { render :xml => @person }
    end
  end

  # GET /people/1/edit
  def edit
    @person = Person.find(params[:id])
  end

  # POST /people
  # POST /people.xml
  def create
    @person = Person.new(params[:person])

    respond_to do |format|
      if @person.save
        flash[:notice] = 'Person was successfully created.'
        format.html { redirect_to(@person) }
        format.xml { render :xml => @person, :status => :created, :location => @person }
        format.js do
          responds_to_parent { render :layout => false }
        end
      else
        format.html { render :action => :new }
        format.xml { render :xml => @person.errors, :status => :unprocessable_entity }
        format.js do
          @url = people_url(:format => :js)
          responds_to_parent { render :action => :invalid, :layout => false }
        end
      end
    end
  end

  # PUT /people/1
  # PUT /people/1.xml
  def update
    @person = Person.find(params[:id])

    respond_to do |format|
      if @person.update_attributes(params[:person])
        flash[:notice] = 'Person was successfully updated.'
        format.html { redirect_to(@person) }
        format.xml { head :ok }
        format.js do
          responds_to_parent { render :layout => false }
        end
      else
        format.html { render :action => :edit }
        format.xml { render :xml => @person.errors, :status => :unprocessable_entity }
        format.js do
          @url = person_path(@person, :format => :js)
          responds_to_parent { render :action => :invalid, :layout => false }
        end
      end
    end
  end

  # GET /people/1/delete
  def delete
    @person = Person.find(params[:id])

    respond_to do |format|
      format.html # delete.html.haml
    end
  end

  # DELETE /people/1
  # DELETE /people/1.xml
  def destroy
    @person = Person.find(params[:id])
    redirect_to(@person) and return if params[:cancel]
    @person.destroy

    respond_to do |format|
      format.html { redirect_to people_url }
      format.xml { head :ok }
      format.js { render :action => :redirect }
    end
  end

end
