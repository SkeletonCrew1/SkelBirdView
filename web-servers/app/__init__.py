from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_login import LoginManager
import boto3
from botocore.client import Config
import os
from dotenv import load_dotenv

load_dotenv()

db = SQLAlchemy()
login_manager = LoginManager()
region = os.environ.get("AWS_REGION", "eu-north-1")


def create_app():
    app = Flask(__name__)

    app.config["SECRET_KEY"] = os.environ.get("SECRET_KEY")
    app.config["SQLALCHEMY_DATABASE_URI"] = (
        f"mysql+pymysql://{os.environ.get('DB_USER')}:{os.environ.get('DB_PASSWORD')}"
        f"@{os.environ.get('DB_HOST')}/{os.environ.get('DB_NAME')}"
    )
    app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
    
    db.init_app(app)
    login_manager.init_app(app)
    login_manager.login_view = "app.login"

    region = os.environ.get("AWS_REGION", "eu-north-1")
    bucket_name = os.environ.get("S3_BUCKET")


    app.config["S3_BUCKET"] = bucket_name
    app.s3_client = boto3.client(
        "s3",
        region_name=region,
        endpoint_url=f"https://s3.{region}.amazonaws.com",  
        aws_access_key_id=os.environ.get("AWS_ACCESS_KEY"),
        aws_secret_access_key=os.environ.get("AWS_SECRET_KEY"),
        config=Config(
            signature_version="s3v4",
            s3={"addressing_style": "virtual"}
        ),
    )

    from .routes import app as app_blueprint
    app.register_blueprint(app_blueprint)

    return app