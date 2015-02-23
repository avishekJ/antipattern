class Subject < ActiveRecord::Base
	# => Model relations
	has_many :categories
	
	before_validation :add_default_permalink
  after_destroy :delete_related_categories

	# => Model validations
	validates :name, :presence => true,
										:length => { :maximum => 24 }

	private

  def delete_related_categories
    self.categories.each do |category|
      category.destroy
    end
  end
  
  def add_default_permalink
    if permalink.blank?
      self.permalink = "#{name.parameterize}"
    end
  end
end
