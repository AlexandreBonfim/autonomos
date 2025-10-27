class OcrParseJob < ApplicationJob
  queue_as :default

  def perform(document_id)
    doc = Document.find(document_id)
    doc.update!(status: :parsing)

    # In real life: call OCR engine, fill parsed_payload
    parsed = Domains::Ocr::SimpleParser.call(doc)
    doc.update!(parsed_payload: parsed)

    expense = Expenses::OcrToExpense.call(doc.user, parsed)
    doc.update!(status: :parsed)

    expense
  rescue => e
    doc.update!(status: :failed, parsed_payload: { error: e.message }) rescue nil
    Rails.logger.error("[OcrParseJob] #{e.class}: #{e.message}")
  end
end
