# == Schema Information
#
# Table name: identities
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  provider   :string(255)
#  uid        :string(255)
#  token      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Identity < ActiveRecord::Base

  # Validations
  # ============================================================================
  validates_presence_of :uid, :provider
  validates_uniqueness_of :uid, scope: :provider

  # Relationships
  # ============================================================================
  belongs_to :user

  def self.find_for_oauth(auth)
    find_or_create_by(uid: auth.uid, provider: auth.provider) do |user|
      user.token = auth['credentials']['token']
    end
  end

end
