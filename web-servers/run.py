from app import create_app, db

app = create_app()

app.config["SECRET_KEY"] = os.environ.get("SECRET_KEY")
# with app.app_context():
#     db.create_all()
