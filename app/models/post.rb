class Post < ActiveRecord::Base
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :comments
  has_many :users, through: :comments

  def categories_attributes=(categories_hashes)                              #need this for the new categories which
    categories_hashes.each do |i, category_attributes|                         #becomes a hash when you use field_for
      if category_attributes[:name].present?                                      #the activerecord category= won't work
        category = Category.find_or_create_by(name: category_attributes[:name])    #It's set for an array
        if !self.categories.include?(category)                                      #This hash acts like an array bc the key is
          self.post_categories.build(:category => category)                         #basically the index
        end
      end
    end
  end
end
