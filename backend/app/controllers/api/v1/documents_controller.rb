# app/controllers/api/v1/documents_controller.rb
class Api::V1::DocumentsController < ApplicationController
  before_action :authenticate!

  def create
    doc = current_user.documents.create!(document_params.merge(status: :uploaded))
    OcrParseJob.perform_later(doc.id)
    
    render json: serialize(doc), status: :created
  end

  def show
    doc = current_user.documents.find(params[:id])
    render json: serialize(doc)
  end

  private

  def document_params
    params.require(:document).permit(
      :kind, :original_filename, :content_type, :size_bytes, :storage_key,
      metadata: {}, parsed_payload: {}
    )
  end

  def serialize(doc)
    {
      id: doc.id,
      kind: doc.kind,
      status: doc.status,
      original_filename: doc.original_filename,
      metadata: doc.metadata,
      parsed_payload: doc.parsed_payload
    }
  end
end
