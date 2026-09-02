from app import create_app, db
import os
app = create_app()

with app.app_context():
    db.create_all()
app.config["SECRET_KEY"] = os.environ.get("SECRET_KEY")
