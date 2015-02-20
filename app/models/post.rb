class Post < ActiveRecord::Base
	# => Model relations
	belongs_to :category
	belongs_to :author

	before_validation :add_default_permalink

  after_destroy :delete_related_posts

	# => Model validations
	validates :title, :presence => true,
										:length => { :maximum => 200 }
	validates :content, :presence => true
	validates :permalink, :presence => true		
	validates_uniqueness_of :permalink						
	validates :author_id, :presence => true								
	validates :category_id, :presence => true

	private

  def add_default_permalink
    if permalink.blank?
      self.permalink = "#{author_id}-#{title.parameterize}"
    end
  end

end
