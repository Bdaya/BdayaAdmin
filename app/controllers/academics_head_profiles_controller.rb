class AcademicsHeadProfilesController < ApplicationController
  # GET /academics_head_profiles
  # GET /academics_head_profiles.json

  def index
    
    @academics_head_profiles = AcademicsHeadProfile.all
    @all = Committee.where(title: "Academics").first.members
    @all_courses = Course.all
    @maxc = 0
    @maxm = 0
    @majors = Array.new
  

    for c in @all_courses 
       if c.tutors.size > @maxc 
         @maxc = c.tutors.size
        end 
      end

    for m in @all
        if @majors.include?(m.major) 

        else
          @majors.push(m.major)
        end  
    end  
   
   for i in 0..@majors.size-1
     
     if @all.where(major: @majors[i]).size > @maxm
      @maxm = @all.where(major: @majors[i]).size
        end 
   end 

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @academics_head_profiles }
    end
  end

  # GET /academics_head_profiles/1
  # GET /academics_head_profiles/1.json
  def show
    @academics_head_profile = AcademicsHeadProfile.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @academics_head_profile }
    end
  end

  # GET /academics_head_profiles/new
  # GET /academics_head_profiles/new.json
  def new
    @academics_head_profile = AcademicsHeadProfile.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @academics_head_profile }
    end
  end

  # GET /academics_head_profiles/1/edit
  def edit
    @academics_head_profile = AcademicsHeadProfile.find(params[:id])
  end

  # POST /academics_head_profiles
  # POST /academics_head_profiles.json
  def create
    @academics_head_profile = AcademicsHeadProfile.new(params[:academics_head_profile])

    respond_to do |format|
      if @academics_head_profile.save
        format.html { redirect_to @academics_head_profile, notice: 'Academics head profile was successfully created.' }
        format.json { render json: @academics_head_profile, status: :created, location: @academics_head_profile }
      else
        format.html { render action: "new" }
        format.json { render json: @academics_head_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /academics_head_profiles/1
  # PUT /academics_head_profiles/1.json
  def update
    @academics_head_profile = AcademicsHeadProfile.find(params[:id])

    respond_to do |format|
      if @academics_head_profile.update_attributes(params[:academics_head_profile])
        format.html { redirect_to @academics_head_profile, notice: 'Academics head profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @academics_head_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /academics_head_profiles/1
  # DELETE /academics_head_profiles/1.json
  def destroy
    @academics_head_profile = AcademicsHeadProfile.find(params[:id])
    @academics_head_profile.destroy

    respond_to do |format|
      format.html { redirect_to academics_head_profiles_url }
      format.json { head :no_content }
    end
  end
end