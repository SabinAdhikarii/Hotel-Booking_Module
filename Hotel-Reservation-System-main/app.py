from flask import Flask, render_template, request, redirect, url_for
import mysql.connector
from mysql.connector import Error
from datetime import datetime

app = Flask(__name__)

def get_db_connection():
    return mysql.connector.connect(
        host='localhost',
        user='root',
        password='Namratha@9113~',
        database='hotel_reservation'
    )

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/book_room', methods=['GET', 'POST'])
def book_room():
    if request.method == 'POST':
        guest_id = request.form['guest_id']
        room_id = request.form['room_id']
        check_in = request.form['check_in']
        check_out = request.form['check_out']
        
        connection = get_db_connection()
        cursor = connection.cursor()
        cursor.execute('INSERT INTO reservations (guest_id, room_id, check_in, check_out) VALUES (%s, %s, %s, %s)', 
                       (guest_id, room_id, check_in, check_out))
        
        connection.commit()
        cursor.close()
        connection.close()
        return redirect(url_for('index'))
    
    connection = get_db_connection()
    cursor = connection.cursor()
    cursor.execute('SELECT id, type_name FROM room_types')
    room_types = cursor.fetchall()
    cursor.close()
    connection.close()
    return render_template('book_room.html', room_types=room_types)

@app.route('/manage_reservations')
def manage_reservations():
    connection = get_db_connection()
    cursor = connection.cursor()
    cursor.execute('SELECT * FROM reservations')
    reservations = cursor.fetchall()
    cursor.close()
    connection.close()
    return render_template('manage_reservations.html', reservations=reservations)

@app.route('/guest_details')
def guest_details():
    connection = get_db_connection()
    cursor = connection.cursor()
    query = '''
    SELECT g.first_name, g.last_name, rt.type_name, rt.description, rt.price * DATEDIFF(r.check_out, r.check_in) as total_price
    FROM reservations r
    JOIN guests g ON r.guest_id = g.id
    JOIN rooms ro ON r.room_id = ro.id
    JOIN room_types rt ON ro.type_id = rt.id;
    '''
    cursor.execute(query)
    guest_details = cursor.fetchall()
    cursor.close()
    connection.close()
    return render_template('guest_details.html', guest_details=guest_details)

if __name__ == '__main__':
    app.run(debug=True)
