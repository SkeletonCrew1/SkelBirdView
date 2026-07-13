import pytest
from app import create_app, db
from app.models import User, Post, Like, ReportedIp
from flask import Flask
import os

@pytest.fixture()
def test_app():

    app = create_app()

    app.config.update({
        "TESTING": True,
        "WTF_CSRF_ENABLED": False,
        "SECRET_KEY": "test_secret"
    })
    with app.app_context():

        db.create_all()    
        yield app
        db.drop_all()


@pytest.fixture()
def client(test_app):
    return test_app.test_client()


@pytest.fixture()
def test_user(app):
    with app.app_context():
        user = User(email='denisnegtuns@gmail.com',
                    username='test_denis',
                    password='pnpnpnpnppnpnpn')
        db.session.add(user)
        db.session.commit()
        db.session.refresh(user) 
        
        return user