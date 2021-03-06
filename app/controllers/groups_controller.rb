class GroupsController < ApplicationController
  
  before_filter 'check_credentials(:user)',
    only: [:update, :create]
    
  before_filter :get_group,
    only: [:destroy, :show, :update]
  
  def show
    @group_stories = @group.stories
  end

  def update
    e = Email.get(params[:users][:email])
    u = e.user
    unless @group.users.include? u
      @group.users << u
      @group.save
    end
    redirect_to "/groups/#{@group.id}"
  end

  def new

  end

  def create
    group_hash = params.only('name', 'description')
    g = Group.create(group_hash) 

    g.users << @user
    g.save!
    redirect_to "/groups/#{ g.id }"
  end

  def destroy
    
  end

  def get_group
    @group = Group.get params[:id]
  end

end
