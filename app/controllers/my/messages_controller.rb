class My::MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  def index
     if params[:sent] == 'true'
       @messages = current_user.messages.order(created_at: :desc).page(params[:page]).per(10)
     elsif params[:all] == 'true'
       @messages = current_user.all_messages.order(created_at: :desc).page(params[:page]).per(10)
     elsif params[:opened] == 'true'
       @messages = current_user.received_messages.opened.page(params[:page]).per(10)
     elsif params[:opened] == 'false'
       @messages = current_user.received_messages.unopened.page(params[:page]).per(10)
     else
       @messages = current_user.all_messages.order(created_at: :desc).page(params[:page]).per(10)
     end
  end

  def show
    @message.open!
  end

  def new
    @message = current_user.messages.new(recipient_id: params[:recipient_id], thread_id: params[:thread_id]  )
    @recipient = User.find(params[:recipient_id])
  end

  def edit
  end

  def create
    @message = current_user.messages.new(message_params)
    respond_to do |format|
      if @message.save
        @message.update_attributes(thread_id: @message.id) if @message.thread_id.blank?
        format.html { redirect_to my_messages_path, notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to my_messages_path, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to my_messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def open
    @message.open!
    respond_to do |format|
      format.html { redirect_back(fallback_location: my_messages_url) }
      format.js
    end
  end

  private

  def set_message
    @message = Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:recipient_id, :thread_id, :subject, :body)
  end

end
