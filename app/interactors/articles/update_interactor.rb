module Articles
  class UpdateInteractor
    def initialize(article, params, purge_file_ids: nil)
      @article = article
      @params = params
      @purge_file_ids = purge_file_ids || []
    end

    def call
      result = false
      ActiveRecord::Base.transaction do
        purge_files if @purge_file_ids.present?

        update_params = @params.except(:files)

        if @article.update(update_params)
          if @params[:files].present?
            @article.files.attach(@params[:files])
          end
          result = true
        else
          raise ActiveRecord::Rollback
        end
      end
      result
    end

    private

    def purge_files
      @purge_file_ids.each do |file_id|
        file = @article.files.find_by(id: file_id)
        file&.purge
      end
    end
  end
end
