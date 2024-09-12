import unittest
from app import app

class FlaskTestCase(unittest.TestCase):

    def setUp(self):
        self.app = app.test_client()
        self.app.testing = True

    def test_hello(self):
        response = self.app.get('/api/hello')
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.json, {'hello': 'world'})

    def test_hello_name(self):
        response = self.app.get('/api/hello/ben')
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.json, {'hello': 'ben'})

    def test_whoami(self):
        response = self.app.get('/api/whoami')
        self.assertEqual(response.status_code, 200)
        self.assertIn('name', response.json)
        self.assertIn('ip', response.json)
        self.assertIn('useragent', response.json)

    def test_whoami_name(self):
        response = self.app.get('/api/whoami/john')
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.json['name'], 'john')
        self.assertIn('ip', response.json)
        self.assertIn('useragent', response.json)

if __name__ == '__main__':
    unittest.main()
