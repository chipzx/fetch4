class AnimalGalleriesController < ApplicationController

  def index
    @animals = Animal.all
    respond_to do |format|
      format.html
      format.json { render :json => @animals,
        :methods => [ :animal_galleries ] }
    end
  end

  def show
  end

  def new
    @pic = AnimalGallery.new()
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pic }
    end
  end

  def create
    @pic = AnimalGallery.new(animal_gallery_params)
logger.debug(animal_gallery_params["file"].nil? ? "File assignment failed" : "File assignment worked")
logger.debug(animal_gallery_params["photo"].nil? ? "Photo assignment failed" : "Photo assignment worked")
logger.debug(animal_gallery_params)
logger.debug("File assigned: #{@pic.photo.file?}")
logger.debug("Blank?: #{@pic.photo.blank?}")
logger.debug(@pic.photo.content_type)
logger.debug("Convert options: #{@pic.photo.convert_options}")
logger.debug("Default style: #{@pic.photo.default_style}")
logger.debug("Interpolator: #{@pic.photo.interpolator}")
logger.debug("Options: #{@pic.photo.options}")
logger.debug(@pic.photo.default_options)
logger.debug(@pic.photo.errors)
logger.debug(@pic.photo.original_filename)
logger.debug(@pic.photo.path)
logger.debug(@pic.photo.size)
logger.debug("URL: #{@pic.photo.url}")
    if @pic.save
      render json: { success: true}
      flash[:notice] = "#{@pic.photo_file_name} saved"
    else
      render json: @pic.errors
      flash[:alert] = "Alert: #{@pic.errors.full_messages}"
    end
  end

  private
  def animal_gallery_params
    params.require(:animal_galleries).permit(:animal_id, :photo)
  end
end
