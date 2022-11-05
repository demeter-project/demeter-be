class Plant < ApplicationRecord  
  has_many :plot_plants
  has_many :plots, through: :plot_plants
  
  def self.native_to(state_code)
    where('states ilike ?', "%#{state_code}%")
  end

  def self.search_name(name)
    where('common_name ilike ? OR scientific_name ilike ?', "%#{name}%", "%#{name}%")
  end

  def self.sort_by_attr(attribute)
    if Plant.column_names.include?(attribute)
      attribute = sanitize_sql_for_order(attribute)
      order(attribute)
    end
  end
end
