require 'rails_helper'

RSpec.describe Articles::UpdateInteractor, type: :interactor do
  let(:article) { Article.create!(title: "Original Title", content: "Original Content") }

  let(:image_blob) do
    ActiveStorage::Blob.create_and_upload!(
      io: StringIO.new("fake-image"),
      filename: "test.png",
      content_type: "image/png"
    )
  end

  let(:pdf_blob) do
    ActiveStorage::Blob.create_and_upload!(
      io: StringIO.new("fake-pdf"),
      filename: "test.pdf",
      content_type: "application/pdf"
    )
  end

  describe "#call" do
    context "when parameters are valid" do
      it "updates the article attributes" do
        params = { title: "New Title", content: "New Content" }
        interactor = described_class.new(article, params)

        expect(interactor.call).to be true
        article.reload
        expect(article.title).to eq("New Title")
        expect(article.content).to eq("New Content")
      end

      it "attaches new files" do
        params = { title: "Original Title", files: [ image_blob, pdf_blob ] }
        interactor = described_class.new(article, params)

        expect(interactor.call).to be true
        article.reload
        expect(article.files.count).to eq(2)
      end
    end

    context "when params contain files to purge" do
      before do
        article.files.attach(image_blob)
        article.files.attach(pdf_blob)
      end

      it "purges the specified files" do
        expect(article.files.count).to eq(2)
        purge_ids = [ article.files.first.id ]

        params = { title: "Original Title" }
        interactor = described_class.new(article, params, purge_file_ids: purge_ids)

        expect(interactor.call).to be true
        article.reload
        expect(article.files.count).to eq(1)
        expect(article.files.map(&:id)).not_to include(purge_ids.first)
      end
    end

    context "when update fails" do
      it "returns false and rolls back changes" do
        params = { title: "", content: "New Content" } # validation fails (blank title)
        interactor = described_class.new(article, params)

        expect(interactor.call).to be false
        article.reload
        expect(article.title).to eq("Original Title")
      end
    end
  end
end
