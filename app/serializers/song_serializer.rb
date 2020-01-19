class SongSerializer < Blueprinter::Base
  identifier :id

  fields :id, :title, :slug, :cover, :notes, :lyrics, :tabs, :author_name, :author_id
end
