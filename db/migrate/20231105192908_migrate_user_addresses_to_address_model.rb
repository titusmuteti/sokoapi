class MigrateUserAddressesToAddressModel < ActiveRecord::Migration[7.0]
  def up
    User.find_each do |user|
      Address.create(
        user_id: user.id,
        first_name: user.first_name,
        last_name: user.last_name,
        address: user.address,
        city: user.city,
        region: user.region,
        postal_code: user.postal_code,
        country: user.country,
        phone_number: user.phone_number
      )
    end
  end

  def down
    Address.destroy_all
  end
end