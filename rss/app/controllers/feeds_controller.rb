class FeedsController < ApplicationController
  require 'rss'
  require 'open-uri'

  before_action :set_feed, only: [:show, :edit, :update, :destroy]

  # GET /feeds
  # GET /feeds.json
  def index
    @feeds = Feed.all
    @url = 'http://rss.cnn.com/rss/cnn_travel.rss'
    open(@url) do |rss|
      @feed_found = RSS::Parser.parse(rss)
    end
  end

  # GET /feeds/1
  # GET /feeds/1.json
  def show
  end

  # GET /feeds/new
  def new
    @feed = Feed.new
  end

  # GET /feeds/1/edit
  def edit
  end

  # POST /feeds
  # POST /feeds.json
  def create
    open(feed_params[:link]) do |rss|
      feed= RSS::Parser.parse(rss)
      @feed = Feed.new(link: feed_params[:link], title: feed.channel.title, description: feed.channel.description)
    end
    respond_to do |format|
      if @feed.save
        format.html { redirect_to @feed, notice: 'Feed was successfully created.' }
        format.json { render :show, status: :created, location: @feed }
      else
        format.html { render :new }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /feeds/1
  # PATCH/PUT /feeds/1.json
  def update
    respond_to do |format|
      if @feed.update(feed_params)
        format.html { redirect_to @feed, notice: 'Feed was successfully updated.' }
        format.json { render :show, status: :ok, location: @feed }
      else
        format.html { render :edit }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feeds/1
  # DELETE /feeds/1.json
  def destroy
    @feed.destroy
    respond_to do |format|
      format.html { redirect_to feeds_url, notice: 'Feed was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def update_feeds
    Feed.all.each do |feed|
      url = feed.link
      open(url) do |rss|
        rss = RSS::Parser.parse(rss)
        puts "Title: #{rss.channel.title}"
        rss.items.each do |item|
          puts "Item: #{item.title}"
          item = Item.create(feed_id: feed.id, title: item.title, description: item.description, link: item.link)
          item.save
        end
      end
    end
    respond_to do |format|
      format.js { flash.now[:notice] = "Feeds were updated." }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_feed
    @feed = Feed.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def feed_params
    params.require(:feed).permit(:title, :description, :link)
  end
end
