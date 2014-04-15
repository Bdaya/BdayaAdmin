class Admin::CommitteesController < ApplicationController
  
  before_filter :authenticate_admin!

  before_filter :init_committee, except: [:index, :new]

  def new
  end

  def edit
  end

  def destroy
  end

  def update
    @committee.update_attributes params[:committee]
    redirect_to [:admin, @committee], notice: 'Successfully updated'
  end

  def create
  end

  def show
  end

  def index
    @committees = Committee.all
  end

  def batch_invite
    emails = params[:emails].split(/[;,]/).map(&:strip)

    if emails.empty?
      redirect_to :back, alert: "You did not enter any emails"
      return
    end

    emails.map(&:downcase).each do |email|
      hypothetical_user = User.where(email: email).first
      unless hypothetical_user.try(:confirmed?)
        User.invite!({ email: email }) do |s|
          s.member_of_committee = @committee
          s.name = email.split('@')[0]
        end
      else
        redirect_to admin_committee_path(@committee.id), alert: "User '#{hypothetical_user.email}' already exists."
        return
      end
    end
    redirect_to admin_committee_path(@committee.id), notice: 'User invited.'
  end

  private

  def init_committee
    @committee = Committee.find params[:id]
  end
end
