class License < ApplicationRecord
  belongs_to :user
  validates_presence_of :user

  def delegate_authority_to(other_user:, obj:)
    other_user.license!(obj)
  end

  def revoke_authority_from(other_user:, obj:)
    other_user.unlicense!(obj)
  end

  def number_of_delegates_remaining(obj:)
    maximum_number_of_users - users.with_role(:license, obj)
  end

  def within_limit?(obj:)
    number_of_delegates_remaining(obj: obj)  > 0
  end

end
