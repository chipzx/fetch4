class AnimalServices311HeatmapsController < ApplicationController
  def index
    @filterrific = initialize_filterrific(
        AnimalServices311Heatmap,
        params[:filterrific],
        select_options: {
          sr_type: AnimalServices311Heatmap.options_for_sr_type,
          sr_status_type: AnimalServices311Heatmap.options_for_sr_status_type,
          fy_type:     AnimalServices311Heatmap.options_for_fy_type
        },
        default_filter_params: {}
    ) or return
    logger.info("params: #{params[:filterrific]}")
    logger.info("Select options: #{@filterrific.select_options}")
    filters = params[:filterrific]
    unless filters.nil?
      @rtype = filters["with_sr_type"]
      @stype = filters["with_sr_status_type"]
      @ftype = filters["with_fy_type"]
      @rtype = nil if @rtype.blank?
      @stype = nil if @stype.blank?
      @ftype = nil if @ftype.blank?
    else
      @rtype = 'Loose Dog'
      @stype = 'Closed'
      @ftype = 2015
    end
    logger.info("rtype: #{@rtype} stype: #{@stype} gtype: #{@gtype} ftype: #{@ftype}")

    @map_data = Group.find(current_user.group_id)
    @detail_maps = DetailMap.all

    @latlngs = @filterrific.find()
logger.info("Found #{@latlngs.size} records for 311 calls");
    
    if (@latlngs.size > 1000)
      # @max_intensity = @latlngs.size * @map_data.max_intensity
      @max_intensity = 1.0
    else
      @max_intensity = 0.05
    end
@hotspots = AnimalServices311Hotspot.select("group_id, found_location, latitude,longitude").where("latitude IS NOT NULL and latitude != 0.0") 
    @hs_detail = AnimalServices311HotspotDetail.all

    logger.info("Found #{@hotspots.size} hotspots with #{@hs_detail.length} detail records")
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
    @animal_services311_calls = AnimalServices311Call.within_radius(@detail_map.center_point, @detail_map.radius)
    logger.info("311 Calls: Found #{@animal_services311_calls.size}")
  end
end
