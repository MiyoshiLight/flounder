class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]

  # GET /articles or /articles.json
  def index
    @articles = Article.all
  end

  # GET /articles/1 or /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles or /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: "Article was successfully created." }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @article.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    respond_to do |format|
      saved = false
      ActiveRecord::Base.transaction do
        # 1. 削除予定として送られたファイルの物理削除（パージ）
        if params[:purge_file_ids].present?
          params[:purge_file_ids].each do |file_id|
            file = @article.files.find_by(id: file_id)
            file&.purge
          end
        end

        # 2. 記事の更新。ファイルの追加アタッチのため、更新時には :files パラメータを除外する
        update_params = article_params.except(:files)

        if @article.update(update_params)
          # 3. 新規にアタッチされたファイルを追加
          if article_params[:files].present?
            @article.files.attach(article_params[:files])
          end
          saved = true
        else
          raise ActiveRecord::Rollback
        end
      end

      if saved
        format.html { redirect_to @article, notice: "記事を更新しました。", status: :see_other }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @article.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    @article.destroy!

    respond_to do |format|
      format.html { redirect_to articles_path, notice: "Article was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.expect(article: [ :title, :content, files: [] ])
    end
end
