import os
import boto3
from datetime import datetime
from flask import Flask, render_template, redirect, url_for
from flask_sqlalchemy import SQLAlchemy
from flask_login import UserMixin, LoginManager, login_user, logout_user, login_required, current_user
from dotenv import load_dotenv
from werkzeug.security import generate_password_hash, check_password_hash
from werkzeug.utils import secure_filename
from forms import RegistrationForm, LoginForm, PostForm

app = Flask(__name__)
app.config["SECRET_KEY"] = "dev-key-123"

load_dotenv()

s3 = boto3.client(
    "s3",
    aws_access_key_id=os.environ.get("AWS_ACCESS_KEY"),
    aws_secret_access_key=os.environ.get("AWS_SECRET_KEY"),
    endpoint_url=os.environ.get("S3_ENDPOINT")
)
BUCKET_NAME = os.environ.get("S3_BUCKET")

app.config["SQLALCHEMY_DATABASE_URI"] = f"mysql+pymysql://{os.environ.get('DB_USER')}:{os.environ.get('DB_PASSWORD')}@{os.environ.get('DB_HOST')}/{os.environ.get('DB_NAME')}"
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False

db = SQLAlchemy(app)
login_manager = LoginManager(app)
login_manager.login_view = "login"

@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))

class User(db.Model, UserMixin):
    __tablename__ = "users"
    id = db.Column(db.Integer, primary_key=True)
    email = db.Column(db.String(64), unique=True, index=True)
    password = db.Column(db.String(512))
    posts = db.relationship("Post", backref="author", lazy=True)

class Post(db.Model):
    __tablename__ = "post"
    likes = db.relationship("Like", backref="post", lazy=True)
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(100), nullable=False)
    image_url = db.Column(db.String(255), nullable=False)
    location = db.Column(db.String(100), nullable=False)
    date_posted = db.Column(db.DateTime, default=datetime.utcnow)
    user_id = db.Column(db.Integer, db.ForeignKey("users.id"), nullable=False)

class Like(db.Model):
    __tablename__ = "likes"
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey("users.id"), nullable=False)
    post_id = db.Column(db.Integer, db.ForeignKey("post.id"), nullable=False)
    __table_args__ = (db.UniqueConstraint('user_id', 'post_id', name='_user_post_uc'),)

@app.route("/")
def index():
    posts = Post.query.all()
    return render_template("index.html", posts=posts)

@app.route("/register", methods=["GET", "POST"])
def register():
    form = RegistrationForm()
    if form.validate_on_submit():
        hashed_pw = generate_password_hash(form.password.data)
        db.session.add(User(email=form.email.data, password=hashed_pw))
        db.session.commit()
        return redirect(url_for("login"))
    return render_template("register.html", form=form)

@app.route("/login", methods=["GET", "POST"])
def login():
    form = LoginForm()
    if form.validate_on_submit():
        user = User.query.filter_by(email=form.email.data).first()
        if user and check_password_hash(user.password, form.password.data):
            login_user(user)
            return redirect(url_for("index"))
    return render_template("login.html", form=form)

@app.route("/logout")
def logout():
    logout_user()
    return redirect(url_for("index"))

@app.route("/create_post", methods=["GET", "POST"])
@login_required
def create_post():
    form = PostForm()
    if form.validate_on_submit():
        file = form.picture.data
        filename = secure_filename(file.filename)

        s3.upload_fileobj(file, BUCKET_NAME, filename, ExtraArgs={'ContentType': file.content_type})

        image_url = f"https://{BUCKET_NAME}.s3.amazonaws.com/{filename}"
        new_post = Post(title=form.title.data, location=form.location.data, 
                        image_url=image_url, user_id=current_user.id)
        db.session.add(new_post)
        db.session.commit()
        return redirect(url_for("index"))
    return render_template("create_post.html", form=form)

@app.route("/post/<int:post_id>")
def post_detail(post_id):
    post = Post.query.get_or_404(post_id)
    return render_template("post.html", post=post)

@app.route("/like/<int:post_id>")
@login_required
def like_post(post_id):
    post = Post.query.get_or_404(post_id)
    existing_like = Like.query.filter_by(user_id=current_user.id, post_id=post_id).first()
    
    if not existing_like:
        db.session.add(Like(user_id=current_user.id, post_id=post_id))
        db.session.commit()
    
    return redirect(url_for("index"))

if __name__ == "__main__":
    with app.app_context():
        db.create_all()
    app.run(host="0.0.0.0", port=80)