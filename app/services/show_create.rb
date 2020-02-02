class ShowCreate
  prepend SimpleCommand

  attr_reader :params, :tracks

  def initialize(params, tracks)
    @params = params
    @tracks = tracks
  end

  def call
    show = Show.new(params.except(:tracks))
    show.band_id = '4cccc925-8cd3-40a3-9ec1-5b9fd14dd040'

    ActiveRecord::Base.transaction do
      errors.merge!(show.errors) if show.invalid?
      show.save!

      tracks.each do |t|
        t.permit!
        annotations = t[:annotations] || []
        track = Track.new(t.except(:annotations).merge(show_id: show.id))

        errors.merge!(track.errors) if track.invalid?
        track.save!

        annotations.compact.each do |a|
          annotation = Annotation.new(desc: a, track: track)
          annotation.save!
        end
      end
    end

    return show

  rescue ActiveRecord::RecordInvalid => e
    return show
  end

end