require 'rails_helper'

RSpec.describe Article, type: :model do
  describe "validations" do
    it "requires a title" do
      article = Article.new(title: nil)
      expect(article).not_to be_valid
      expect(article.errors[:title]).to include("を入力してください")
    end
  end

  describe "attachment helper methods" do
    let(:article) { Article.create!(title: "Test Article", content: "Body text") }

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

    context "with no attachments" do
      it "returns empty or zero values" do
        expect(article.attached_images).to be_empty
        expect(article.attached_documents).to be_empty
        expect(article.thumbnail_image).to be_nil
        expect(article.files_count).to eq(0)
      end
    end

    context "with attachments" do
      before do
        article.files.attach(image_blob)
        article.files.attach(pdf_blob)
      end

      it "correctly classifies images" do
        expect(article.attached_images.size).to eq(1)
        expect(article.attached_images.first.filename.to_s).to eq("test.png")
      end

      it "correctly classifies documents" do
        expect(article.attached_documents.size).to eq(1)
        expect(article.attached_documents.first.filename.to_s).to eq("test.pdf")
      end

      it "returns the first image as thumbnail" do
        expect(article.thumbnail_image.filename.to_s).to eq("test.png")
      end

      it "returns the correct file count" do
        expect(article.files_count).to eq(2)
      end
    end
  end
end
