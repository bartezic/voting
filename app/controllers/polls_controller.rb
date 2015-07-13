class PollsController < ApplicationController
  before_action :authenticate_user!, except: [:public, :show, :answer]
  before_action :set_poll, only: [:edit, :update, :destroy]

  # GET /polls
  # GET /polls.json
  def public
    @polls = Poll.opened.order(id: :desc)
  end

  # GET /polls
  # GET /polls.json
  def index
    @polls = current_user.polls.order(id: :desc)
  end

  # GET /polls/1
  # GET /polls/1.json
  def show
    @poll = Poll.find_by_token(params[:id])
  end

  # GET /polls/new
  def new
    @poll = current_user.polls.new
    @poll.options.build
  end

  # GET /polls/1/edit
  def edit
  end

  # POST /polls
  # POST /polls.json
  def create
    @poll = current_user.polls.new(poll_params)

    respond_to do |format|
      if @poll.save
        format.html { redirect_to polls_url, notice: 'Poll was successfully created.' }
        format.json { render :show, status: :created, location: @poll }
      else
        format.html { render :new }
        format.json { render json: @poll.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /polls/1
  # PATCH/PUT /polls/1.json
  def update
    respond_to do |format|
      if @poll.update(poll_params)
        format.html { redirect_to polls_url, notice: 'Poll was successfully updated.' }
        format.json { render :show, status: :ok, location: @poll }
      else
        format.html { render :edit }
        format.json { render json: @poll.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /polls/1
  # DELETE /polls/1.json
  def destroy
    @poll.destroy
    respond_to do |format|
      format.html { redirect_to polls_url, notice: 'Poll was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def answer
    @poll = Poll.find_by_token(params[:id])
    @poll.options.where(id: params[:answer]).each do |option|
      option.answers << Answer.create({
        user_id: current_user.try(:id),
        ip: request.remote_ip
      })
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_poll
      @poll = current_user.polls.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def poll_params
      params.require(:poll).permit(:user_id, :question, :token, :multi, :public, 
        options_attributes: [:id, :name, :_destroy])
    end
end
