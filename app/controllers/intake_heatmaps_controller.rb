class IntakeHeatmapsController < ApplicationController
#  def index
#    @map_data = Group.find(current_user.group_id)
#    respond_to do |format|
#      format.html 
#      format.json { render :json => @map_data }
#    end
#  end

  def index
#    @filterrific = initialize_filterrific(
#        Intake,
#        params[:filterrific],
#        select_options: {
#          animal_type: Intake.options_for_animal_type,
#          intake_type: Intake.options_for_intake_type,
#          gender_type: Intake.options_for_gender_type,
#          fy_type:     Intake.options_for_fy_type
#        },
#    ) or return
#    logger.info("params: #{params[:filterrific]}")
#    logger.info("Select options: #{@filterrific.select_options}")
    filters = params[:filterrific]
    unless filters.nil?
      @atype = filters["with_animal_type"]
      @itype = filters["with_intake_type"]
      @gtype = filters["with_gender_type"]
      @ftype = filters["with_fy_type"]
      @atype = nil if @atype.blank?
      @itype = nil if @itype.blank?
      @gtype = nil if @gtype.blank?
      @ftype = nil if @ftype.blank?
    else
      @atype = 'Dog'
      @itype = 'Stray'
    end
    logger.info("atype: #{@atype} itype: #{@itype} gtype: #{@gtype} ftype: #{@ftype}")

#    @group_id = Thread.current['current_group']
@group_id = 14
    logger.info(@group_id)
    @center_point = [ 30.25, -97.75 ]
    @max_intensity = 1.0
    @zoom = 12
    if (@group_id == 8) 
      @center_point = [30.152468, -97.353606]
      @max_intensity = 0.10
      @zoom = 11
    end
    
    @latlngs = Intake.where("valid_address and latitude != 0.0").group(["latitude", "longitude"]).group(["found_location", "latitude", "longitude"]).count
    @hotspots = Hotspot.select("found_location, latitude,longitude").where("group_id = #{@group_id}")

    @hs_detail = Hotspot.select("found_location, latitude, longitude, animal_type, fiscal_year").group(["found_location", "latitude", "longitude", "animal_type", "fiscal_year"]).order(["found_location", "latitude", "longitude", "fiscal_year","animal_type"]).sum("total").to_a

    respond_to do |format|
      format.html
      format.js
    end
  rescue ActiveRecord::RecordNotFound => e
    # There is an issue with the persisted param_set. Reset it.
    puts "Had to reset filterrific params: #{ e.message }"
    redirect_to(reset_filterrific_url(format: :html)) and return
  end

end
