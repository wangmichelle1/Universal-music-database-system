import pymysql
from pymysql.cursors import Cursor
from pymysql.connections import Connection


# MusicDb acts as a layer between the python and SQL code,
# removing repeated code and handling cursors automatically.
class MusicDb:
    # can't get Connection[Cursor] typing to work
    def __init__(self, connection: Connection):
        self.connection = connection

    # A wrapper for Cursor.callproc(). Removes a lot of repeated code
    # where we get a cursor, call a procedure, fetch the rows, and close the
    # cursor.
    # Returns all rows returned by the first selected table of a procedure.
    def __callproc(self, procname: str, args):
        cursor = self.connection.cursor()
        cursor.callproc(procname, args)

        rows = cursor.fetchall()

        cursor.close()

        return rows

    def __execute(self, query: str, args):
        cursor = self.connection.cursor()
        cursor.execute(query, args)

        rows = cursor.fetchall()

        cursor.close()

        return rows

    # CLIENT METHODS
    def add_user(self, user_name_p: str) -> int:

        rows = self.__callproc('add_user', [user_name_p])

        return rows[0]['userId']

    def add_ss(self, userId_p: int, service_name_p: str) -> None:

        self.__callproc('add_ss', [userId_p, service_name_p])

    def check_user(self, userId_p: int):

        self.__callproc('check_user', [userId_p])

    def close(self):
        self.connection.close()

    # ARTIST 
    def search_artist_exist(self, userId_p: int, artist_name_p: str):

        return self.__callproc('search_artist_exist', [userId_p, artist_name_p])

    # ALBUM 
    def search_album_exist(self, userId_p: int, album_name_p: str):

        return self.__callproc('search_album_exist', [userId_p, album_name_p])

    def search_album(self, userId_p: int, release_year_p: str, album_genre_name_p: str):

        return self.__callproc('search_album', [userId_p, release_year_p, album_genre_name_p])

    # SONG
    def add_song(self, song_name_p: str, musical_key_p: str, song_length_p: pymysql.Time,
                 song_language_p: str, song_genre_name_p: str, album_name_p: str,
                 album_release_year_p: str, artist_name_p: str):

        self.__callproc('add_song', [song_name_p, musical_key_p, song_length_p, song_language_p,
                        song_genre_name_p, album_name_p, album_release_year_p, artist_name_p])

    def search_song_exist(self, userId_p: int, song_name_p: str):

        return self.__callproc('search_song_exist', [userId_p, song_name_p])

    def search_song(self, userId_p: int, musical_key_p: str, song_length_p: pymysql.Time, song_language_p: str, 
                    song_genre_name_p: str):

        return self.__callproc('search_song', [userId_p, musical_key_p, song_length_p, song_language_p, 
                                               song_genre_name_p])

    def delete_song(self, songId_p: int):

        self.__callproc('delete_song', [songId_p])

    # ARTIST REVIEW 
    def add_artist_review(self, userId_p: int, artist_name_p: str, artist_rating_p: float, artist_review_desc_p: str):

        self.__callproc('add_artist_review', [
                        userId_p, artist_name_p, artist_rating_p, artist_review_desc_p])

    def find_artist_review(self, userId_p: int, artist_rating_p: float, artist_name_p: str):

        return self.__callproc('find_artist_review', [userId_p, artist_rating_p, artist_name_p])

    def update_artist_review(self, userId_p: int, artist_name_p: str, artist_rating_p: float, artist_review_desc_p: str):

        self.__callproc('update_artist_review', [
                        userId_p, artist_name_p, artist_rating_p, artist_review_desc_p])

    def delete_artist_review(self, artist_name_p: str, userId_p: int):

        self.__callproc('delete_artist_review', [artist_name_p, userId_p])

    # ALBUM REVIEW 
    def add_album_review(self, userId_p: int, album_name_p: str, album_rating_p: float, album_review_desc_p: str):

        self.__callproc('add_album_review', [
                        userId_p, album_name_p, album_rating_p, album_review_desc_p])

    def find_album_review(self, userId_p: int, album_rating_p: float, album_name_p: str):

        return self.__callproc('find_album_review', [userId_p, album_rating_p, album_name_p])

    def update_album_review(self, userId_p: int, album_name_p: str, album_rating_p: float, album_review_desc_p: str):

        self.__callproc('update_album_review', [
                        userId_p, album_name_p, album_rating_p, album_review_desc_p])

    def delete_album_review(self, album_name_p: str, userId_p: int):

        self.__callproc('delete_album_review', [album_name_p, userId_p])

    # SONG REVIEW 
    def add_song_review(self, userId_p: int, song_name_p: str, song_rating_p: float, song_review_desc_p: str):

        self.__callproc('add_song_review', [
                        userId_p, song_name_p, song_rating_p, song_review_desc_p])

    def find_song_review(self, userId_p: int, song_rating_p: float, song_name_p: str):

        return self.__callproc('find_song_review', [userId_p, song_rating_p, song_name_p])

    def update_song_review(self, userId_p: int, song_name_p: str, song_rating_p: float, song_review_desc_p: str):

        self.__callproc('update_song_review', [
                        userId_p, song_name_p, song_rating_p, song_review_desc_p])

    def delete_song_review(self, song_name_p: str, userId_p: int):

        self.__callproc('delete_song_review', [song_name_p, userId_p])

    # STATS
    def total_reviews(self, userId_p: int) -> int:

        rows = self.__execute(
            'SELECT total_reviews(%s) AS total_reviews_v', [userId_p])

        return rows[0]['total_reviews_v']

    def pop_ss(self):

        return self.__callproc('pop_ss', [])

    def num_album_r_searches(self, userId_p: int):

        rows = self.__execute(
            'SELECT num_album_r_searches(%s) AS num_searches_v', [userId_p])

        return rows[0]['num_searches_v']

    def num_artist_r_searches(self, userId_p: int):

        rows = self.__execute(
            'SELECT num_artist_r_searches(%s) AS num_searches_v', [userId_p])

        return rows[0]['num_searches_v']

    def num_song_r_searches(self, userId_p: str):

        rows = self.__execute(
            'SELECT num_song_r_searches(%s) AS num_searches_v', [userId_p])

        return rows[0]['num_searches_v']

    def num_album_searches(self, userId_p: int):

        rows = self.__execute(
            'SELECT num_album_searches(%s) AS num_searches_v', [userId_p])

        return rows[0]['num_searches_v']

    def num_artist_searches(self, userId_p: int):

        rows = self.__execute(
            'SELECT num_artist_searches(%s) AS num_searches_v', [userId_p])

        return rows[0]['num_searches_v']

    def num_song_searches(self, userId_p: str):

        rows = self.__execute(
            'SELECT num_song_searches(%s) AS num_searches_v', [userId_p])

        return rows[0]['num_searches_v']

def connect_to_db(username: str, password: str):
    connection = pymysql.connect(
        host='localhost', user=username,
        password=password,
        database='music',
        cursorclass=pymysql.cursors.DictCursor,
        charset='utf8mb4',
        autocommit=True)
    return MusicDb(connection)