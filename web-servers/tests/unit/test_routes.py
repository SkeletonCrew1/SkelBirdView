from unittest.mock import patch


@patch("app.routes.ReportedIp.query")
class TestBanHunter:
    # def test_user_logout(self, mock_ip_query,client):
    #     mock_ip_query.filter_by.return_value.first.return_value = None

    #     response= client.get("/logout",)
    #     assert response.status_code == 302 # redirected to app,index

    @patch("flask_login.utils.current_user")
    @patch("app.routes.db.session")
    @patch("app.routes.ReportedIp.query")
    def test_user_report_allowed_ips(
        self, mock_reported_ip, mock_db_session, current_user, mock_ip_query, client
    ):
        current_user.is_authenticated = True

        mock_ip_query.filter_by.return_value.first.return_value = None

        mock_reported_ip.filter_by.return_value.first.return_value = None

        response = client.post("/hunter/report", data={"ip_address": "192.32.32.32"})

        assert response.status_code == 302

        mock_ip_query.filter_by.assert_any_call(ip="192.32.32.32")

        added_ip = mock_db_session.add.call_args[0][0]

        assert added_ip.ip == "192.32.32.32"
        assert added_ip.is_reported is True

    @patch("flask_login.utils.current_user")
    @patch("app.routes.db.session")
    @patch("app.routes.ReportedIp.query")
    def test_user_report_forbidden_ips(
        self, mock_reported_ip, mock_db_session, current_user, mock_ip_query, client
    ):
        current_user.is_authenticated = True

        mock_ip_query.filter_by.return_value.first.return_value = None
        mock_reported_ip.filter_by.return_value.first.return_value = None

        response = client.post("/hunter/report", data={"ip_address": "0.0.0.0"})
        assert response.status_code == 200
        mock_reported_ip.filter_by.assert_not_called()
        assert b"Incorrect ip" in response.data
        mock_db_session.add.assert_not_called()

        response = client.post("/hunter/report", data={"ip_address": "127.0.0.1"})
        assert response.status_code == 200
        mock_reported_ip.filter_by.assert_not_called()
        assert b"Incorrect ip" in response.data
        mock_db_session.add.assert_not_called()
