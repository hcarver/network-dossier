class EventsController < ApplicationController
  before_action :set_event, only: [:show, :update_notes]

  # GET /events
  # GET /events.json
  def index
    @events = current_user.events.order('time DESC').all
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  def update_notes
    params[:notes_attributes].keys.each do |attendee_id|
      note = (current_user.notes.where(about_id: attendee_id).first() or current_user.notes.new(about_id: attendee_id))
      note.note_text = params[:notes_attributes][attendee_id][:note_text]
      note.save!
      note.delete unless note.note_text
    end
    redirect_to @event, notice: 'Notes updated'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = current_user.events.find(params[:id])
    end
end
