class News < ActiveRecord::Base
  validates :headline, :published, :visible, presence: true
  validates :published, uniqueness: { scope: :headline }

  def self.latest
    n = News.order('published DESC').limit(1)
    return n[0] unless n.nil?
  end

end
