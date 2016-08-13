helom = User.create!(first_name: "Helom", last_name: "Itsme", email: "hello@adele.com", password: "password")
will = User.create!(first_name: "Willom", last_name: "Jung", email: "will@adele.com", password: "password")
dumitru = User.create!(first_name: "Dummy", last_name: "True", email: "d@gmail.com", password: "password")

Playlist.create!(name: "Paula", admin: dumitru, passcode: 111111, request_limit: 3, flag_minimum: 3, allow_explicit: true)
Playlist.create!(name: "Adele", admin: helom, passcode: 222222, request_limit: 5, flag_minimum: 5, allow_explicit: true)
Playlist.create!(name: "DMX", admin: dumitru, passcode: 333333, request_limit: 4, flag_minimum: 4, allow_explicit: true)
Playlist.create!(name: "Down with the Sickness", admin: will, passcode: 666666, request_limit: 6, flag_minimum: 6, allow_explicit: true)
Playlist.create!(name: "Celine's Greatest Hits", admin: helom, passcode: 7777777, request_limit: 7, flag_minimum: 1, allow_explicit: true)

25.times do
  Song.create(title: Faker::Hacker.noun, artist: Faker::Name.name, album: Faker::Hacker.noun, release_date: Date.today, album_art: nil)
end

50.times do
  Playlistsong.create(playlist_id: rand(1..5), song_id: rand(1..25))
end
