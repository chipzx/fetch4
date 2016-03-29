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

  def short_description(max_length=500)
    return self.description if self.description.nil? || 
                               self.description.length < max_length

    d = description.slice(0, max_length) 
    return d.slice(0, d.rindex(/\s/)).strip + "..."
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
    return 'NA' if self.dob.nil?
    now = Time.zone.now
    today_in_months = now.year*12 + now.month
    dob_in_months = self.dob.year*12 + dob.month
    age_in_months = today_in_months - dob_in_months 
    years = age_in_months/12
    months = age_in_months % 12
    age_str = ""
    age_str = "#{years} yr" if (years > 0)
    age_str += "s" if years > 1
    age_str += " " if (years > 0 && months > 0)
    age_str += "#{months} mon" if (months > 0)
    age_str += "s" if months > 1
    age_str = "Under 1 month" if (years == 0 && months == 0)
    return age_str
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
