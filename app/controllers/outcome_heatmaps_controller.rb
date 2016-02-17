class OutcomeHeatmapsController < ApplicationController
  layout "maps"

  def index
    @filterrific = initialize_filterrific(
        OutcomeHeatmap,
        params[:filterrific],
        select_options: {
          animal_type: OutcomeHeatmap.options_for_animal_type,
          outcome_type: OutcomeHeatmap.options_for_outcome_type,
          gender_type: OutcomeHeatmap.options_for_gender_type,
          fy_type:     OutcomeHeatmap.options_for_fy_type
        },
        default_filter_params: {}
    ) or return
    logger.info("params: #{params[:filterrific]}")
    logger.info("Select options: #{@filterrific.select_options}")
    filters = params[:filterrific]
    unless filters.nil?
      @atype = filters["with_animal_type"]
      @otype = filters["with_outcome_type"]
      @gtype = filters["with_gender_type"]
      @ftype = filters["with_fy_type"]
      @atype = nil if @atype.blank?
      @otype = nil if @otype.blank?
      @gtype = nil if @gtype.blank?
      @ftype = nil if @ftype.blank?
    else
      @otype = 'Adoption'
      @ftype = 2015
    end
    logger.info("atype: #{@atype} itype: #{@otype} gtype: #{@gtype} ftype: #{@ftype}")

    @map_data = Group.find(current_user.group_id)
    @latlngs = @filterrific.find()
    
    if (@latlngs.size > 1000)
      @max_intensity = @latlngs.size * @map_data.max_intensity
    else
      @max_intensity = 0.05
    end

    @detail_maps = DetailMap.all

    #@hotspots = Hotspot.select("group_id, found_location, latitude,longitude").where("latitude IS NOT NULL and latitude != 0.0")

#    @hs_detail = Hotspot.select("found_location, latitude, longitude, animal_type, fiscal_year").group(["found_location", "latitude", "longitude", "animal_type", "fiscal_year"]).order(["found_location", "latitude", "longitude", "fiscal_year","animal_type"]).sum("total").to_a
    #@hs_detail = HotspotDetail.all

    respond_to do |format|
      format.html
      format.js
    end
  rescue ActiveRecord::RecordNotFound => e
    # There is an issue with the persisted param_set. Reset it.
    puts "Had to reset filterrific params: #{ e.message }"
    redirect_to(reset_filterrific_url(format: :html)) and return
  end

  def show
    get_detail_map_data(params[:map_name])
    respond_to do |format|
      format.html
      format.js
    end
  end

  private
  def get_detail_map_data(map_name)
    @detail_map = DetailMap.find_by_map_name(map_name)
    @map_id = @detail_map.map_id
    @outcomes = Outcome.within_radius(@detail_map.center_point, @detail_map.radius)
  end
end
