from app import create_app
import os
app = create_app()

app.config["SECRET_KEY"] = os.environ.get("SECRET_KEY")
