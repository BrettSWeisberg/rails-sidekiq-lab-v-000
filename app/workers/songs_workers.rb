class SongsWorker
  require 'csv'
  include Sidekiq::Worker

  def perform(songs_file)
    binding.pry
     CSV.foreach(songs_file, headers: true) do |song|
       @artist = Artist.find_or_create_by(name: song[1])
       @song = Song.create(title: song[0], artist_id: @artist.id)
    end
  end
end
