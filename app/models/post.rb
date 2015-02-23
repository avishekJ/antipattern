class Post < ActiveRecord::Base
	# => Model relations
	belongs_to :category
	belongs_to :author

	delegate	:name,
						:description,
						:to => :category,
						:prefix => true

  delegate  :email,
            :to => :author,
            :prefix => true			

	before_validation :add_default_permalink

	# => Model validations
	validates :title, :presence => true,
										:length => { :maximum => 200 }
	validates :content, :presence => true
	validates :permalink, :presence => true		
	validates_uniqueness_of :permalink						
	validates :author_id, :presence => true								
	validates :category_id, :presence => true

	scope :get_posts_by_author, lambda {|auth_id|where(["author_id=?", auth_id])}

	private

  def add_default_permalink
    if permalink.blank?
      self.permalink = "#{title.parameterize}-#{author_id}-#{Time.now.to_i}"
    end
  end

end
