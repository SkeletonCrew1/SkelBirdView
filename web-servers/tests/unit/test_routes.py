from unittest.mock import patch, MagicMock
from werkzeug.security import generate_password_hash, check_password_hash
import hashlib



@patch("app.routes.ReportedIp.query")
class TestPostRoutes:
    @patch("app.routes.get_presigned_url")
    @patch("app.routes.Post.query")
    def test_index_route_pure_mock(self, mock_post_query, mock_presigned_url,mock_ip_query, client):
        mock_ip_query.filter_by.return_value.first.return_value = None
        fake_post1 = MagicMock()
        fake_post2 = MagicMock()

        fake_post1.image_url = "s3://my-bucket/bear.jpg"
        fake_post2.image_url = "s3://my-bucket/bird.jpg"

        mock_post_query.all.return_value = [fake_post1, fake_post2]
        mock_presigned_url.return_value = "https://fake-aws-url.com/temp-link.jpg"

        response = client.get("/")

        assert response.status_code == 200
        mock_post_query.all.assert_called_once()
        assert mock_presigned_url.call_count == 2
        mock_presigned_url.assert_any_call("bear.jpg")
        mock_presigned_url.assert_any_call("bird.jpg")



@patch("app.routes.ReportedIp.query")
class TestAuthRoutes:

    def test_register_route(self,mock_ip_query, client):
        mock_ip_query.filter_by.return_value.first.return_value = None
        response = client.get("/register")
        assert response.status_code == 200




    @patch("app.routes.db.session")
    @patch("app.routes.User.query")
    def test_user_register(self,mock_user_query,mock_db_query, mock_ip_query,client):
        mock_ip_query.filter_by.return_value.first.return_value = None
        mock_user_query.filter_by.return_value.first.return_value = None
        
        response= client.post("/register", data={
            "email":"bbrbrbr@gmail.com",
            "username": "testuser",
            "password":"secret_password",
            "submit": "Register"
        })
        assert response.status_code == 302, f"Form rejected! HTML output: {response.data.decode('utf-8')}"        
        assert "/login" in response.headers["Location"]

        mock_db_query.add.assert_called_once()
        mock_db_query.commit.assert_called_once()

        added_user = mock_db_query.add.call_args[0][0]

        assert added_user.email == "bbrbrbr@gmail.com"
        assert added_user.username == "testuser"

        assert added_user.password != "secret_password"
        assert check_password_hash(added_user.password,"secret_password")
        


    @patch("app.routes.User.query")
    def test_user_right_login(self,mock_user_query, mock_ip_query,client):
        mock_ip_query.filter_by.return_value.first.return_value = None
        fake_user = MagicMock()

        fake_user.email = "bbrbrbr@gmail.com"
        fake_user.password=generate_password_hash("secret_password")
        fake_user.get_id.return_value="1"

        mock_user_query.filter_by.return_value.first.return_value=fake_user

        response= client.post("/login", data={
            "email":"bbrbrbr@gmail.com",
            "password":"secret_password"
        })
        assert response.status_code == 302 #redirected to app



    @patch("app.routes.User.query")
    def test_user_wrong_login(self,mock_user_query, mock_ip_query,client):
        mock_ip_query.filter_by.return_value.first.return_value = None
        fake_user = MagicMock()

        fake_user.email = "bbrbrbr@gmail.com"
        fake_user.password=generate_password_hash("secret_password")

        mock_user_query.filter_by.return_value.first.return_value=fake_user

        response= client.post("/login", data={
            "email":"bbrbrbr@gmail.com",
            "password":"INCORECT_password"
        })
        assert response.status_code == 200 #no riderect



    @patch("app.routes.logout_user")
    def test_user_logout(self,mock_logout_user, mock_ip_query,client):
        mock_ip_query.filter_by.return_value.first.return_value = None

        response= client.get("/logout",)
        assert response.status_code == 302 # redirected to app,index
        mock_logout_user.assert_called_once() 

@patch("app.routes.ReportedIp.query")
class TestBanHunter:
    @patch("flask_login.utils.current_user")
    @patch("app.routes.db.session")
    def test_user_report_allowed_ips(self, mock_db_session, current_user,mock_ip_query, client):
        current_user.is_authenticated = True

        mock_ip_query.filter_by.return_value.first.return_value = None

        raw_ip = "192.32.32.32"
        expected_hash = hashlib.sha256(raw_ip.encode("utf-8")).hexdigest()

        response= client.post("/hunter/report",data={"ip_address":raw_ip})

        assert response.status_code == 302 

        mock_ip_query.filter_by.assert_any_call(ip=expected_hash)

        added_ip = mock_db_session.add.call_args[0][0]

        assert added_ip.ip == expected_hash
        assert added_ip.is_reported == True

    @patch("flask_login.utils.current_user")
    @patch("app.routes.db.session")

    def test_user_report_forbidden_ips(self,mock_db_session,current_user, mock_ip_query,client):
        current_user.is_authenticated = True

        mock_ip_query.filter_by.return_value.first.return_value = None
        
        response= client.post("/hunter/report",data={"ip_address":"0.0.0.0"})
        assert response.status_code == 200
        assert b"Incorrect ip" in response.data
        mock_db_session.add.assert_not_called()

        response= client.post("/hunter/report",data={"ip_address":"127.0.0.1"})
        assert response.status_code == 200
        assert b"Incorrect ip" in response.data
        mock_db_session.add.assert_not_called()


    def test_blocked_user_redirect(self, mock_ip_query,client):
        mocked_banned_hunter = MagicMock()
        mocked_banned_hunter.is_recorded = True
        mock_ip_query.filter_by.return_value.first.return_value = mocked_banned_hunter
        
        response = client.get("/")        
        assert response.status_code == 302 
        assert "zakon.rada.gov.ua" in response.headers['Location']