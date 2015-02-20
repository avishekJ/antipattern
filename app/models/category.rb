class Category < ActiveRecord::Base
	# => Model relations
	belongs_to :subject
	has_many :posts
	
  after_destroy :delete_related_posts

	# => Model validations
	validates :title, :presence => true,
										:length => { :maximum => 24 }
	validates :subject_id, :presence => true

	private

  def delete_related_posts
    self.posts.each do |post|
      post.destroy
    end
  end

end
