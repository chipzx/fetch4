class IntakeHeatmapsController < ApplicationController
  def index
    init_filters()
    get_map_data()
    get_detail_map_data()
    respond_to do |format|
      format.html
      format.js
    end
  rescue ActiveRecord::RecordNotFound => e
    # There is an issue with the persisted param_set. Reset it.
    puts "Had to reset filterrific params: #{ e.message }"
    redirect_to(reset_filterrific_url(format: :html)) and return
  end

  private
  def init_filters
    @filterrific = initialize_filterrific(
        IntakeHeatmap,
        params[:filterrific],
        select_options: {
          animal_type: IntakeHeatmap.options_for_animal_type,
          intake_type: IntakeHeatmap.options_for_intake_type,
          gender_type: IntakeHeatmap.options_for_gender_type,
          fy_type:     IntakeHeatmap.options_for_fy_type
        },
        default_filter_params: {}
    ) or return
    logger.info("params: #{params[:filterrific]}")
    logger.info("Select options: #{@filterrific.select_options}")
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
      @ftype = 2015
    end
    logger.info("atype: #{@atype} itype: #{@itype} gtype: #{@gtype} ftype: #{@ftype}")
  end

  def get_map_data
    @map_data = Group.find(current_user.group_id)
    @latlngs = @filterrific.find()
    
    if (@latlngs.size > 1000)
      @max_intensity = @latlngs.size * @map_data.max_intensity
    else
      @max_intensity = 0.05
    end

    @hotspots = Hotspot.select("group_id, found_location, latitude,longitude").where("latitude IS NOT NULL and latitude != 0.0")

#    @hs_detail = Hotspot.select("found_location, latitude, longitude, animal_type, fiscal_year").group(["found_location", "latitude", "longitude", "animal_type", "fiscal_year"]).order(["found_location", "latitude", "longitude", "fiscal_year","animal_type"]).sum("total").to_a
    @hs_detail = HotspotDetail.all

    logger.info("Found #{@hotspots.size} hotspots with #{@hs_detail.length} detail records")
  end

  def get_detail_map_data
    @detail_maps = DetailMap.all
  end
end
