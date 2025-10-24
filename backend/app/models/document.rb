# == Schema Information
#
# Table name: documents
#
#  id                :integer          not null, primary key
#  user_id           :integer          not null
#  kind              :string
#  status            :string
#  original_filename :string
#  content_type      :string
#  size_bytes        :integer
#  storage_key       :string
#  metadata          :jsonb
#  parsed_payload    :jsonb
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_documents_on_user_id  (user_id)
#

class Document < ApplicationRecord
  belongs_to :user
end
