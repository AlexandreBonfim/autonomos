# == Schema Information
#
# Table name: clients
#
#  id              :integer          not null, primary key
#  user_id         :integer          not null
#  name            :string
#  email           :string
#  tax_id          :string
#  billing_address :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_clients_on_user_id  (user_id)
#

require 'rails_helper'

RSpec.describe Client, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
