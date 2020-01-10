class SongSerializer < Blueprinter::Base
  identifier :id

  fields :id, :title, :slug, :cover, :notes, :lyrics, :tabs, :legacy_author
end
