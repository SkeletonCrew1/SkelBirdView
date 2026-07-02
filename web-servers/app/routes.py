from flask import Blueprint, render_template, redirect, url_for
from flask_login import login_user, logout_user, login_required, current_user
from werkzeug.security import generate_password_hash, check_password_hash
from werkzeug.utils import secure_filename
from . import db, s3, BUCKET_NAME, login_manager
from .models import User, Post, Like
from forms import RegistrationForm, LoginForm, PostForm

app = Blueprint('app', __name__)


@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))


def get_presigned_url(filename):
    """Generates a temporary URL for private S3 objects."""
    try:
        url = s3.generate_presigned_url(
            'get_object',
            Params={'Bucket': BUCKET_NAME, 'Key': filename},
            ExpiresIn=3600
        )
        return url
    except Exception:
        return None


@app.route("/")
def index():
    posts = Post.query.all()
    for post in posts:
        filename = post.image_url.split('/')[-1]
        post.presigned_url = get_presigned_url(filename)
    return render_template("index.html", posts=posts)


@app.route("/register", methods=["GET", "POST"])
def register():
    form = RegistrationForm()
    if form.validate_on_submit():
        hashed_pw = generate_password_hash(form.password.data)
        db.session.add(User(email=form.email.data, password=hashed_pw))
        db.session.commit()
        return redirect(url_for("app.login"))
    return render_template("register.html", form=form)


@app.route("/login", methods=["GET", "POST"])
def login():
    form = LoginForm()
    if form.validate_on_submit():
        user = User.query.filter_by(email=form.email.data).first()
        if user and check_password_hash(user.password, form.password.data):
            login_user(user)
            return redirect(url_for("app.index"))
    return render_template("login.html", form=form)


@app.route("/logout")
def logout():
    logout_user()
    return redirect(url_for("app.index"))


@app.route("/create_post", methods=["GET", "POST"])
@login_required
def create_post():
    form = PostForm()
    if form.validate_on_submit():
        file = form.picture.data
        filename = "id" + str(len(Post.query.all())) + secure_filename(file.filename)
        s3.upload_fileobj(file, BUCKET_NAME, filename, ExtraArgs={'ContentType': file.content_type})

        image_url = f"https://{BUCKET_NAME}.s3.amazonaws.com/{filename}"
        new_post = Post(title=form.title.data, location=form.location.data,
                        image_url=image_url, user_id=current_user.id)
        db.session.add(new_post)
        db.session.commit()
        return redirect(url_for("app.index"))
    return render_template("create_post.html", form=form)


@app.route("/post/<int:post_id>")
def post_detail(post_id):
    post = Post.query.get_or_404(post_id)
    filename = post.image_url.split('/')[-1]
    presigned_url = get_presigned_url(filename)
    return render_template("post.html", post=post, image_url=presigned_url)


@app.route("/like/<int:post_id>")
@login_required
def like_post(post_id):
    existing_like = Like.query.filter_by(user_id=current_user.id, post_id=post_id).first()
    if not existing_like:
        db.session.add(Like(user_id=current_user.id, post_id=post_id))
        db.session.commit()
    return redirect(url_for('app.post_detail', post_id=post_id))
