class ImportsController < ApplicationController

  def index
    @group = Group.find(current_user.group_id)
    @to_import = []
    imports = DataLoad.order("data_load_type_id")
    imports.to_a.each do |import|
      files = get_files(import)
      @to_import << get_import_record(import, files)
    end
  end

  def show
  end

  def import
  end

  private
  def get_files(import)
    files = []
    # see if there are any files waiting to be imported
    data_path = "#{Rails.root.to_s}/#{import.data_path}"
    Dir.mkdir(data_path) unless Dir.exist?(data_path)
    Dir.chdir(data_path)
    #TO_DO: sort files by date asc
    filenames = Dir.glob("*.*")
    filenames.each do |f|
      path = data_path + "/" + f
      file = File.new(path)
      files << file
    end
    files.sort! { |x,y| x.mtime <=> y.mtime }
  end

  def get_import_record(import, files)
    entry = Hash.new
    entry["path"] = import.data_path
    entry["loader"] = import.load_class
    entry["files"] = files
    return entry
  end
end

