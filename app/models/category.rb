class Category < ActiveRecord::Base
	# => Model relations
	belongs_to :subject
	has_many :posts

  delegate  :name,
            :permalink,
            :to => :subject,
            :prefix => true
  after_destroy :delete_related_posts
	before_validation :add_default_permalink

	# => Model validations
	validates :name, :presence => true,
										:length => { :maximum => 24 }
	validates :subject_id, :presence => true

	private

  def delete_related_posts
    self.posts.each do |post|
      post.destroy
    end
  end

  def add_default_permalink
    if permalink.blank?
      self.permalink = "#{name.parameterize}"
    end
  end
end
