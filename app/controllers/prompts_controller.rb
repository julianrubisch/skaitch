class PromptsController < ApplicationController
  before_action :set_prompt, only: %i[ show edit update destroy ]

  # GET /prompts or /prompts.json
  def index
    @prompts = Prompt.all
  end

  # GET /prompts/1 or /prompts/1.json
  def show
  end

  # GET /prompts/new
  def new
    @prompt = Prompt.new
  end

  # GET /prompts/1/edit
  def edit
  end

  # POST /prompts or /prompts.json
  def create
    @prompt = Prompt.new(prompt_params)
    @prompt.account = Current.account

    model = Replicate.client.retrieve_model("stability-ai/stable-diffusion-img2img")
    version = model.latest_version
    version.predict({prompt: prompt_params[:title], image: prompt_image_data_url}, replicate_rails_url)

    # TODO scale down image to max 768 width or height before proceeding

    respond_to do |format|
      if @prompt.save
        format.html { redirect_to prompt_url(@prompt), notice: "Prompt was successfully created." }
        format.json { render :show, status: :created, location: @prompt }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @prompt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /prompts/1 or /prompts/1.json
  def update
    respond_to do |format|
      if @prompt.update(prompt_params)
        format.html { redirect_to prompt_url(@prompt), notice: "Prompt was successfully updated." }
        format.json { render :show, status: :ok, location: @prompt }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @prompt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /prompts/1 or /prompts/1.json
  def destroy
    @prompt.destroy

    respond_to do |format|
      format.html { redirect_to prompts_url, notice: "Prompt was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prompt
      @prompt = Prompt.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def prompt_params
      params.require(:prompt).permit(:title, :description, :prompt_image, :account_id)
    end

    def prompt_image_data_url
      encoded_data = Base64.strict_encode64(prompt_image.read)

      "data:image/#{prompt_image.content_type};base64,#{encoded_data}"
    end

    def prompt_image
      @prompt_image ||= prompt_params[:prompt_image]
    end
end
