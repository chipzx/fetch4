class AnimalsController < ApplicationController
  before_action :set_animal, only: [:show, :edit, :update, :destroy]

  # GET /animals
  # GET /animals.json
  def index
    logger.debug("params are #{params}")
    logger.debug("Group id is #{current_user.group_id}")
    @keywords = (params["keywords"]) || ''
    @page = (params["page"] || 0).to_i
    @pagesize = params["pagesize"]
    @sortby = params["sortby"] || "kennel"
    @sortOrder = params["sortOrder"] || "false"
    @animals = search(@keywords, @page, @pagesize, @sortby, @sortOrder)
    respond_to do |format|
      format.html 
      format.json { render :json => @animals, 
        :methods => [ :kennel, :age, :days_under_care, :animal_type, :intake_type, :gender ] }
    end
  end

  def search(searchOn, page, pagesize, sortBy, sortOrder)
    sortAs = sortOrder.eql?("true") ? :desc : :asc
    logger.debug("Invoked search on #{searchOn} #{page+1} #{pagesize} sorted by #{sortBy} #{sortOrder} #{sortAs}")
    page += 1
    srch = Animal.search do
      with(:group_id, current_user.group_id)
      keywords(searchOn)
      paginate :page => page, :per_page => pagesize
      order_by(sortBy.to_sym, sortAs)
      # always do secondary ordering by anumber
      order_by(:anumber)
    end
    logger.debug("Search returned #{srch.results.size} records")
    srch.results
  end

  # GET /animals/1
  # GET /animals/1.json
  def show
    @animal = Animal.find(params[:id])
    logger.debug("Description is #{@animal.description}")
    logger.debug("Found #{@animal.animal_galleries.size} photos for #{@animal.name}")
    respond_to do |format|
      format.html 
      format.json { render :json => @animal, 
        :methods => [ :kennel, :age, :days_under_care, :animal_type, :intake_type, :gender, :notes, :animal_galleries ] }
    end
  end

  # GET /animals/new
  def new
    @animal = Animal.new
  end

  # GET /animals/1/edit
  def edit
  end

  # POST /animals
  # POST /animals.json
  def create
    @animal = Animal.new(animal_params)

    respond_to do |format|
      if @animal.save
        format.html { redirect_to @animal, notice: 'Animal was successfully created.' }
        format.json { render :show, status: :created, location: @animal }
      else
        format.html { render :new }
        format.json { render json: @animal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /animals/1
  # PATCH/PUT /animals/1.json
  def update
    respond_to do |format|
      if @animal.update(animal_params)
        format.html { redirect_to @animal, notice: 'Animal was successfully updated.' }
        format.json { render :show, status: :ok, location: @animal }
      else
        format.html { render :edit }
        format.json { render json: @animal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /animals/1
  # DELETE /animals/1.json
  def destroy
    @animal.destroy
    respond_to do |format|
      format.html { redirect_to animals_url, notice: 'Animal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_animal
      @animal = Animal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def animal_params
      params[:animal]
    end
end
