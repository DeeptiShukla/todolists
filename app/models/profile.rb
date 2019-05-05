class Profile < ActiveRecord::Base
  belongs_to :user
  validates :gender, inclusion: { in: %w(male female) }

  validate :name_not_null, :male_and_sue

  def name_not_null
    if first_name.nil? && last_name.nil?
      errors.add(:profile, "is not valid")
    end
  end

  def male_and_sue
    if gender == "male" && first_name == "Sue"
      errors.add(:profile, "is not valid")
    end
  end

  def self.get_all_profiles(min_year, max_year)
    Profile.where("birth_year BETWEEN :minimum and :maximum", minimum: min_year, maximum: max_year).order(:birth_year)
  end
end
