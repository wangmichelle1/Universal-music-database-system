import pymysql
import db
import cryptography
# Creates a connection to the music database with a username and password
# received from the standard input. If the username and password are invalid,
# the user is re-prompted.
# Returns the connection to the database.

def noneIfWhitespace(string: str):
    if string.isspace():
        return None
    else:
        return string

def decide(decision: str, options: dict):
    if decision in options:
        options[decision]()
    else:
        print('Invalid option. Please try again.')

# App exposes methods which represent all the states our app could be in,
# as well as its substates. However, it does not directly control
# the main application flow, which is done by index.

class App:
    def __init__(self, db: db.MusicDb):
        self.db = db
        self.user_id = None

    # User signs up/logs in to the database
    def login_or_signup(self):
        user_status = input(
            'Have you used our database before? Answer Y for yes and N for no.\n')
        while True:
            try:
                if user_status == 'Y':
                    print('Welcome back!!')
                    existing_user_id = input('What is your userId then?\n')
                    while True:
                        try:
                            self.db.check_user(existing_user_id)
                            self.user_id = existing_user_id
                            break
                        except pymysql.Error:
                            print('UserId '+existing_user_id+' was not found.')
                            existing_user_id = input(
                                'Please try another userId: ')
                    break
                elif user_status == 'N':
                    desired_user = input(
                        'Please input your desired username.\n')
                    row = self.db.add_user(desired_user)
                    print('This is your userId for our database:', row)
                    self.user_id = row
                    break
                else:
                    user_status = input(
                        'Invalid response. Answer Y for yes and N for no.\n')

            except pymysql.Error:
                print('Sorry, username was already taken in our system. Please enter in another username.')
    
    # Update user's streaming service 
    def update_ss(self):
        while True:
            ss = input('If you are an existing user, please enter '
                       'N for no new streaming services or Y if you have new streaming services you are using that'
                       ' you would like to add to our database.\nFor new users, please enter in Y.\n')
            try:
                if ss == 'N':
                    print('You are all set! All the streaming service(s) you use are recorded in our database!\n')
                elif ss == 'Y':
                    ss_used = input('What streaming service do you use? If you use multiple, please enter one for now '
                                    '(and every time until you put in each of the streaming services you use.)\n'
                                    'Once you no longer want to input any more streaming services, '
                                    'leave the input blank by pressing the space bar and then '
                                    'press ENTER.\n')
                    self.db.add_ss(self.user_id, ss_used)
                    while True:
                        ss_used = input(
                            'Streaming service recorded. Enter another service or press space bar then '
                            'ENTER to continue.')
                        if ss_used.isspace():
                            break
                        else:
                            self.db.add_ss(self.user_id, ss_used)
                break
            except pymysql.Error:
                print('This streaming service you have entered has previously already been recorded in our database '
                      'under your userId.\n')

    # Prompt the user to choose what type of action they want
    def prompt_action(self):
        decision = input('Do you want to search, add, delete, update, check for stats, or exit the program?'
                         '\nPlease enter one of the following, considering it is case '
                         'sensitive: SEARCH, ADD, DELETE, UPDATE, CHECK, EXIT.\n')
        if decision == 'SEARCH':
            self.search()
        elif decision == 'ADD':
            self.add()
        elif decision == 'DELETE':
            self.delete()
        elif decision == 'UPDATE':
            self.update()
        elif decision == 'CHECK':
            self.check()
        elif decision == 'EXIT':
            return True
        else:
            print('Invalid option. Please try again.')
        return False

    # Prompt the user to choose what type of search they want
    def search(self):
        decision = input('Do you want to search for artist, album, song, artist review, album review,'
                         ' or song review? Please enter one of the following, considering it is case'
                         ' sensitive: ARTIST, ALBUM, SONG, ARTIST REVIEW, ALBUM REVIEW, SONG REVIEW.\n')
        decide(decision, {
            'ARTIST': self.search_artist,
            'ALBUM': self.search_album,
            'SONG': self.search_song,
            'ARTIST REVIEW': self.search_artist_review,
            'ALBUM REVIEW': self.search_album_review,
            'SONG REVIEW': self.search_song_review
        })

    # User searches artist of choice
    def search_artist(self):
        try:
            artist_interest = input('You have selected to search an artist, essentially checking if they'
                                    ' are in our database. Please enter their name, case sensitive.\n')

            self.db.search_artist_exist(self.user_id, artist_interest)
            print('Yes the artist you searched exists in our database.')


        except pymysql.Error as e:
            print(e.args[1])

    # User searches album of choice
    def search_album(self):
        try:
            search_interest = input('Are you interested in simply searching if an album is in our database'
                                    ' or are you interested in searching for an album based on our two'
                                    ' filters, release year and album genre.\nIf you are interested in'
                                    ' the first option, enter FIRST. If you are interested in the'
                                    ' second option, enter SECOND.\n')
            if search_interest == 'FIRST':
                print('You have selected to search an album, essentially checking if it is in our database. Please'
                      ' enter the album name.')
                album_interest = input('\nAlbum name (please capitalize the first letter of each word(s)): ')

                rows = self.db.search_album_exist(self.user_id, album_interest)
                print('Yes the album you searched exists in our database.')

                for row in rows:
                    for item in row:
                        print(item, ':', row[item])

            elif search_interest == 'SECOND':
                print('You have selected to search an album by the two filters'
                      ' we have in our database: release year and album genre name.'
                      '\nYou may choose to input both filters, or just one of them. However,'
                      ' at least one filter must be inputted.')
                release_year = input('\nRelease year of album (YYYY; optional, press the space bar then press ENTER'
                                     ' to skip): ')
                album_g_name = input('\nAlbum genre name (please capitalize the first letter of the word(s); optional, '
                                     'press the space bar then press ENTER to skip): ')

                rows = self.db.search_album(
                    self.user_id,
                    noneIfWhitespace(release_year),
                    noneIfWhitespace(album_g_name))

                for row in rows:
                    for item in row:
                        print(item, ':', row[item])
            else:
                print('Invalid option.')
        except pymysql.Error as e:
            print(e.args[1])

    # User searches for song of choice
    def search_song(self):
        try:
            song_interest = input('Are you interested in simply searching if a song is in our database'
                                  ' or are you interested in searching for a song based on our'
                                  ' filters: musical key, song length, song language, song genre name.\n'
                                  'If you are interested in the first option, enter FIRST. If you are interested in the'
                                  ' second option, enter SECOND.\n')
            if song_interest == 'FIRST':
                print('You have selected to search a song, essentially checking if it is in our database. Please enter'
                      ' the song name.')
                song_name = input('\nSong name (please capitalize the first letter): ')

                self.db.search_song_exist(self.user_id, song_name)
                print('Yes the song you inputted exists in our database.')

            elif song_interest == 'SECOND':
                print('You have selected to search an album by the filters '
                      ' we have in our database. You may not want to put an input'
                      ' for each of our filters.\nHowever, you must at least input one filter in.')
                musical_key = input('\nMusical key (please capitalize the first letter; optional, '
                                    'press the space bar then press ENTER to skip): ')
                song_length = input('\nSong length (formatted hr:mm:ss; optional, '
                                    'press the space bar then press ENTER to skip): ')
                song_language = input('\nSong language (please capitalize first letter, optional, '
                                      'press the space bar then press ENTER to skip): ')
                song_genre = input('\nSong genre (please capitalize first letter of the first word'
                                   ' (if the genre includes two words); optional, '
                                   'press the space bar then press ENTER to skip): ')

                rows = self.db.search_song(
                    self.user_id,
                    noneIfWhitespace(musical_key),
                    noneIfWhitespace(song_length),
                    noneIfWhitespace(song_language),
                    noneIfWhitespace(song_genre))

                for row in rows:
                    for item in row:
                        print(item, ':', row[item])
            else:
                print('Invalid option.')

        except pymysql.Error as e:
            print(e.args[1])

    # User searches for artist review
    def search_artist_review(self):
        try:
            print('You have selected to search an artist review. You can search'
                  ' based on two filters that we have: artist rating and artist name.\n'
                  ' You may choose to input both filters, or just one of them. However,'
                  ' at least one filter must be inputted.\n')
            artist_rating = input('\nArtist rating (0 to 9.9 either inputting an integer or a decimal with one decimal '
                                  'point; 0 being the lowest and 9.9 being the highest; optional, '
                                  'press the space bar then press ENTER to skip): ')
            artist_name = input('\nArtist name (please capitalize the first letter of each part of the name and enter '
                                'both first and last name unless an Artist'
                                ' is generally referred by another name, such as Drake; optional, '
                                'press the space bar then press ENTER to skip): ')

            rows = self.db.find_artist_review(
                self.user_id, artist_rating, artist_name)

            rows = self.db.find_artist_review(
                self.user_id,
                noneIfWhitespace(artist_rating),
                noneIfWhitespace(artist_name))

            for row in rows:
                for item in row:
                    print(item, ':', row[item])

        except pymysql.Error as e:
            print(e.args[1])

    # User searches for album review
    def search_album_review(self):
        try:
            print('You have selected to search an album review. You can search'
                  ' based on two filters that we have: album rating and album name.\n'
                  ' You may choose to input both filters, or just one of them. However,'
                  ' at least one filter must be inputted.\n')
            album_rating = input('\nAlbum rating (0 to 9.9 either inputting an integer or a decimal with one decimal '
                                 'point; 0 being the lowest and 9.9 being the highest; optional, '
                                 'press the space bar then press ENTER to skip): ')
            album_name = input('\nAlbum name (please capitalize the first letter of each word(s); optional, '
                               'press the space bar then press ENTER to skip): ')

            rows = self.db.find_album_review(
                self.user_id,
                noneIfWhitespace(album_rating),
                noneIfWhitespace(album_name))

            for row in rows:
                for item in row:
                    print(item, ':', row[item])

        except pymysql.Error as e:
            print(e.args[1])

    # User searches for song review
    def search_song_review(self):
        try:
            print('You have selected to search an song review. You can search'
                  ' based on two filters that we have: song rating and song name.'
                  '\nYou may choose to input both filters, or just one of them. However,'
                  ' at least one filter must be inputted.\n')
            song_rating = input('\nSong rating (0 to 9.9 either inputting an integer or a decimal with one decimal '
                                'point; 0 being the lowest and 9.9 being the highest; optional, press the space bar '
                                'then press ENTER to skip): ')
            song_name = input('\nSong name (please capitalize the first letter; optional, '
                              'press the space bar then press ENTER to skip): ')

            rows = self.db.find_song_review(
                self.user_id,
                noneIfWhitespace(song_rating),
                noneIfWhitespace(song_name))

            for row in rows:
                for item in row:
                    print(item, ':', row[item])

        except pymysql.Error as e:
            print(e.args[1])

    # Prompts user to choose what they want to add
    def add(self):
        decision = input('Do you want to add an artist review, album review, song review, or song? '
                         'Please enter one of the following, considering it is case sensitive: ARTIST REVIEW, '
                         'ALBUM REVIEW, SONG REVIEW, SONG.\n')

        decide(decision, {
            'SONG': self.add_song,
            'ARTIST REVIEW': self.add_artist_review,
            'ALBUM REVIEW': self.add_album_review,
            'SONG REVIEW': self.add_song_review
        })

    # User adds song
    def add_song(self):
        try:
            print('You have chosen to enter a song to the database. You will need to enter the name,'
                  'musical key, length, language, and genre of the song, as well as the album the song'
                  'is a part of and the year the album was released.\nFinally, you will need to enter the name '
                  'of the song\'s artist. You must enter information in each field.\n')

            name = input('\nSong name (please capitalize the first letter): ')
            key = input('\nMusical key (please capitalize the first letter): ')
            length = input('\nSong length (formatted hr:mm:ss): ')
            language = input('\nSong language (please capitalize first letter): ')
            genre = input('\nSong genre (please capitalize first letter): ')
            album = input('\nAlbum name (please capitalize the first letter of each word(s)): ')
            album_year = input('\nRelease year of album (YYYY): ')
            artist = input('\nArtist name (please capitalize the first letter of each part of the name and enter '
                           'both first and last name unless an Artist is generally referred '
                           'by another name, such as Drake): ')

            self.db.add_song(
                name,
                key,
                length,
                language,
                genre,
                album,
                album_year,
                artist)

            print('Your song has been added to our database.')

        except pymysql.Error as e:
            print(e.args[1])

    # User adds artist review
    def add_artist_review(self):
        try:
            print('You have chosen to add an artist review. You will need to provide the artist\'s name'
                  'which you must provide as well as a rating and/or a description of your '
                  'review (please provide at least one.)')

            artist_name = input('\nArtist name (please capitalize the first letter of each part of the name and enter '
                                'both first and last name unless an Artist'
                                ' is generally referred by another name, such as Drake): ')
            rating = input('\nArtist rating (0 to 9.9 either inputting an integer or a decimal with one decimal'
                           ' point; 0 being the lowest and 9.9 being the highest; optional, '
                           'press the space bar then press ENTER to skip): ')
            review_desc = input('\nReview description (optional, max 400 characters, press the space bar then '
                                'press ENTER to skip): ')

            rating = noneIfWhitespace(rating)
            review_desc = noneIfWhitespace(review_desc)

            self.db.add_artist_review(
                self.user_id,
                artist_name,
                rating,
                review_desc)

            print('Your artist review has been added to our database.')

        except pymysql.Error as e:
            print(e.args[1])

    # User adds album review
    def add_album_review(self):
        try:
            print('You have chosen to review an album. You will need to provide the name of the album, which '
                  'is required as well as a rating and/or a review description (please provide at least one.)')

            name = input('\nAlbum name (please capitalize the first letter of each word(s)): ')
            rating = input('\nAlbum rating (0 to 9.9 either inputting an integer or a decimal with one decimal '
                           'point; 0 being the lowest and 9.9 being the highest; optional, '
                           'press the space bar then press ENTER to skip): ')
            desc = input('\nReview description (optional, max 400 characters, press the space bar then press '
                         'ENTER to skip): ')

            rating = noneIfWhitespace(rating)
            desc = noneIfWhitespace(desc)

            self.db.add_album_review(
                self.user_id,
                name,
                rating,
                desc
            )

            print('Your album review has been added to our database.')

        except pymysql.Error as e:
            print(e.args[1])

    # User adds song review
    def add_song_review(self):
        try:
            print('You have chosen to review a song. You will need to provide the name of the song, which is required'
                  ' as well as a rating and/or a review description (please provide at least one.)')

            name = input('\nSong name (please capitalize the first letter): ')
            rating = input('\nSong rating (0 to 9.9 either inputting an integer or a decimal with one decimal '
                           'point; 0 being the lowest and 9.9 being the highest; optional, '
                           'press the space bar then press ENTER to skip): ')
            desc = input('\nReview description (optional, max 400 characters, press the space bar then press '
                         'ENTER to skip): ')

            rating = noneIfWhitespace(rating)
            desc = noneIfWhitespace(desc)

            self.db.add_song_review(
                self.user_id,
                name,
                rating,
                desc
            )

            print('Your song review has been added to our database.')

        except pymysql.Error as e:
            print(e.args[1])

    # Prompts user to choose what they want to delete
    def delete(self):
        decision = input('Do you want to delete an artist review, album review, song review, or song? '
                         'Please enter one of the following, considering it is case sensitive: ARTIST REVIEW, '
                         'ALBUM REVIEW, SONG REVIEW, SONG.\n')

        decide(decision, {
            'SONG': self.delete_song,
            'ARTIST REVIEW': self.delete_artist_review,
            'ALBUM REVIEW': self.delete_album_review,
            'SONG REVIEW': self.delete_song_review
        })

    # User deletes song
    def delete_song(self):
        try:
            print('You have chosen to delete a song. Please enter the name of the song you would like to delete.')

            name = input('\nSong name (please capitalize the first letter): ')

            self.db.delete_song(name)

            print('The song has been delete from our database.')

        except pymysql.Error as e:
            print(e.args[1])

    # User deletes artist review
    def delete_artist_review(self):
        try:
            print('You have chosen to delete an artist review. Please enter'
                  'the name of the artist whose review you would like to delete.')

            name = input('\nArtist name (please capitalize the first letter of each part of the name and enter '
                         'both first and last name unless an Artist is generally referred by another name, '
                         'such as Drake): ')

            self.db.delete_artist_review(name, self.user_id)

            print('The artist review has been deleted from our database.')

        except pymysql.Error as e:
            print(e.args[1])

    # User deletes album review
    def delete_album_review(self):
        try:
            print('You have chosen to delete an album review. Please enter'
                  ' the name of the album whose review you would like to delete.')

            name = input('\nAlbum name (please capitalize the first letter of each word(s)): ')

            self.db.delete_album_review(name, self.user_id)

            print('The album review has been deleted from our database.')

        except pymysql.Error as e:
            print(e.args[1])

    # User deletes song review
    def delete_song_review(self):
        try:
            print('You have chosen to delete a song review. Please enter the name of the song whose review you '
                  'would like to delete.')

            name = input('\nSong name (please capitalize the first letter): ')

            self.db.delete_song_review(name, self.user_id)

            print('The song review has been deleted from our database.')

        except pymysql.Error as e:
            print(e.args[1])

    # Prompts user to choose what to update
    def update(self):
        print('You have chosen to update a review. Would you like to update an artist, album, or song review?')
        decision = input('\nPlease enter ARTIST, ALBUM, or SONG: ')

        decide(decision,
               {
                   'ARTIST': self.update_artist_review,
                   'ALBUM': self.update_album_review,
                   'SONG': self.update_song_review
               })

    # User updates artist review
    def update_artist_review(self):
        try:
            print('You have chosen to update an artist review. You will need to provide the artist\'s name, which is '
                  'required as well as a rating and/or a description of your review (please provide at least one.)')

            name = input('\nArtist name (please capitalize the first letter of each part of the name and enter '
                         'both first and last name unless an Artist is generally referred by another name, '
                         'such as Drake): ')
            rating = input('\nUpdated rating (0 to 9.9 either inputting an integer or a decimal with one decimal '
                           'point; 0 being the lowest and 9.9 being the highest; optional, press the space bar then '
                           'press ENTER to skip): ')
            review_desc = input('\nUpdated description (optional, max 400 characters, press the space bar then press '
                                'ENTER to skip): ')

            rating = noneIfWhitespace(rating)
            review_desc = noneIfWhitespace(review_desc)

            self.db.update_artist_review(
                self.user_id,
                name,
                rating,
                review_desc)

            print('The artist review has been updated in our database.')

        except pymysql.Error as e:
            print(e.args[1])

    # User updates album review
    def update_album_review(self):
        try:
            print('You have chosen to update an album review. You will need to provide the album\'s name, '
                  'which is required as well as a rating and/or a description of your review '
                  '(please provide at least one.)')

            name = input('\nAlbum name (please capitalize the first letter of each word(s)): ')
            rating = input('\nUpdated rating (0 to 9.9 either inputting an integer or a decimal with one decimal '
                           'point; 0 being the lowest and 9.9 being the highest; optional, press the space bar then '
                           'press ENTER to skip): ')
            review_desc = input('\nUpdated description (optional, max 400 characters, press the space bar then press '
                                'ENTER to skip): ')

            rating = noneIfWhitespace(rating)
            review_desc = noneIfWhitespace(review_desc)

            self.db.update_album_review(
                self.user_id,
                name,
                rating,
                review_desc)

            print('The album review has been updated in our database.')

        except pymysql.Error as e:
            print(e.args[1])

    # User updates song review
    def update_song_review(self):
        try:
            print('You have chosen to update a song review. You will need to provide the song\'s name'
                  'as well as a rating and/or a description of your review (please provide at least one.)')

            name = input('\nSong name (please capitalize the first letter): ')
            rating = input('\nUpdated rating (0 to 9.9 either inputting an integer or a decimal with one decimal '
                           'point; 0 being the lowest and 9.9 being the highest; optional, '
                           'press the space bar then press ENTER to skip): ')
            review_desc = input('\nUpdated description (optional, max 400 characters, press the space bar then press '
                                'ENTER to skip): ')

            rating = noneIfWhitespace(rating)
            review_desc = noneIfWhitespace(review_desc)

            self.db.update_song_review(
                self.user_id,
                name,
                rating,
                review_desc)

            print('The song review has been updated in our database.')

        except pymysql.Error as e:
            print(e.args[1])

    # User can check stats for their profile
    def check(self):
        print('All stats are for your profile except users per streaming service.')

        print('Number of artist searches: ' +
              str(self.db.num_artist_searches(self.user_id)))
        print('Number of album searches: ' +
              str(self.db.num_album_searches(self.user_id)))
        print('Number of song searches: ' +
              str(self.db.num_song_searches(self.user_id)))
        print('Number of artist review searches: ' +
              str(self.db.num_artist_r_searches(self.user_id)))
        print('Number of album review searches: ' +
              str(self.db.num_album_r_searches(self.user_id)))
        print('Number of song review searches: ' +
              str(self.db.num_song_r_searches(self.user_id)))
        print('Total reviews: ' + str(self.db.total_reviews(self.user_id)))

        rows = self.db.pop_ss()
        print('Users per streaming service: ')
        for row in rows:
            for item in row:
                print(item, ':', row[item])

    # Close the application
    def close(self):
        self.db.close()

# Name - database that is to be connected
# Prompt user for username and password, set the cursor that is to be used, and make connection

def init_app():
    while True:
        try:
            username = input('Enter MySQL username\n')
            pword = input('Enter MySQL password\n')

            music_db = db.connect_to_db(username, pword)

            return App(music_db)

        except pymysql.err.OperationalError:
            print(
                'You did not enter in a valid MySQL username and password. Please try again')
