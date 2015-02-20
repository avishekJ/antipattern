class Subject < ActiveRecord::Base
	# => Model relations
	has_many :categories
	
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
end
