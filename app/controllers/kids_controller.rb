class KidsController < ApplicationController
  # GET /kids
  # GET /kids.json
  def index
    @kids = Kid.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @kids }
    end
  end

  # GET /kids/1
  # GET /kids/1.json
  def show
    @kid = Kid.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @kid }
    end
  end

  # GET /kids/new
  # GET /kids/new.json
  def new
    @kid = Kid.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @kid }
    end
  end

  # GET /kids/1/edit
  def edit
    @kid = Kid.find(params[:id])
  end

  # POST /kids
  # POST /kids.json
  def create
    @kid = Kid.new(params[:kid])

    respond_to do |format|
      if @kid.save
        format.html { redirect_to @kid, notice: 'Kid was successfully created.' }
        format.json { render json: @kid, status: :created, location: @kid }
      else
        format.html { render action: "new" }
        format.json { render json: @kid.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /kids/1
  # PUT /kids/1.json
  def update
    @kid = Kid.find(params[:id])

    respond_to do |format|
      if @kid.update_attributes(params[:kid])
        format.html { redirect_to @kid, notice: 'Kid was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @kid.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /kids/1
  # DELETE /kids/1.json
  def destroy
    @kid = Kid.find(params[:id])
    @kid.destroy

    respond_to do |format|
      format.html { redirect_to kids_url }
      format.json { head :no_content }
    end
  end

  def list_courses
    @kid = Kid.find(params[:id])
    @courses = @kid.courses
  end
end
