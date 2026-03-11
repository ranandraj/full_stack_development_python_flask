from flask import Flask, render_template, request, redirect, session
import pymysql
db = pymysql.connect(
    host="localhost",
    user="root",
    password="root123",
    database="admission_portal_db"
)

cursor = db.cursor()

app = Flask(__name__)
app.secret_key = "admission_portal_secret_key"

@app.route("/")
def home():
    return render_template("index.html")

@app.route("/register", methods=["GET","POST"])
def register():

    if request.method == "POST":

        name = request.form['name']
        email = request.form['email']
        password = request.form['password']
        phone = request.form['phone']

        sql = """
        INSERT INTO students(full_name,email,password,phone)
        VALUES(%s,%s,%s,%s)
        """

        values = (name,email,password,phone)

        cursor.execute(sql,values)

        db.commit()

        return redirect("/login")

    return render_template("register.html")

@app.route("/login", methods=["GET", "POST"])
def login():

    if request.method == "POST":

        email = request.form["email"]
        password = request.form["password"]

        query = "SELECT * FROM students WHERE email=%s AND password=%s"
        cursor.execute(query, (email, password))

        user = cursor.fetchone()

        if user:
            session["student_id"] = user[0]
            return redirect("/dashboard")
        else:
            return "Invalid Email or Password"

    return render_template("login.html")

@app.route("/dashboard")
def dashboard():
    return "Logged in successfully!"


@app.route("/admin_login")
def admin_login():
    return render_template("admin_login.html")

@app.route("/admin-dashboard")
def admin_dashboard():
    return render_template("admin_dashboard.html")

if __name__ == "__main__":
    app.run(debug=True)