class Animal < ActiveRecord::Base
  include MultiTenant

  validates :anumber, :animal_type_id, :intake_type_id, presence: true
  validates :anumber, uniqueness: { scope: :group_id }
  
  searchable do
    text    :name, :anumber, :breed, :coloring, :description, :microchip_number, :animal_type,
:intake_type, :gender, :kennel

    string  :name
    string  :kennel
    string  :breed
    string  :coloring
    string  :gender
    string  :anumber
    string  :microchip_number
    integer :age
    integer :days_under_care
    integer :group_id
    integer :weight
    integer :animal_type_id
    integer :intake_type_id
    integer :gender_id
    integer :kennel_id
    date    :dob 
    date    :intake_date

  end

  has_many :animal_galleries

  def primary_photo
    unless animal_galleries.nil?
      animal_galleries.each do |g|
        if (g.primary_image)
          return g.photo.url(:small)
        end
      end
    end
    return AnimalGallery::DEFAULT_URL
  end

  def notes(to_html: true)
    format_notes(self.description, to_html)
  end

  def animal_type
    AnimalType.find(self.animal_type_id).name
  end

  def intake_type
    IntakeType.find(self.intake_type_id).name
  end

  def gender
    unless self.gender_id.nil?
      g = Gender.find(self.gender_id) 
      g.description unless g.nil?
    end
  end

  def kennel
    unless self.kennel_id.nil?
      k = Kennel.find(self.kennel_id)
      unless k.nil?
        k.kennel_name
      end
    end
  end

  def age
    return if self.dob.nil?
    now = Time.zone.now
    now.year - self.dob.year - ((now.month > self.dob.month || (now.month == self.dob.month && now.day >= dob.day)) ? 0 : 1)
  end 

  def days_under_care
    return if self.intake_date.nil?
    ((Time.zone.now - self.intake_date)/(24*60*60)).floor
  end

  private
  def format_notes(notes, html)
    descr = ""
    eol = html ? "<br/>" : "\n"
    small = html ? "<small>" : ""
    em = html ? "<em>" : ""
    small_end = html ? "</em>" : ""
    em_end = html ? "</small>" : ""

    unless notes.nil?
      if html
        descr += notes.gsub("\r\n", "<br/>")
        descr += notes.gsub("\n", "<br/>")
      else
        descr += notes
      end
    end

    return descr
  end

end
