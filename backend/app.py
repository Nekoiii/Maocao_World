from flask import Flask, render_template, send_from_directory
from flask_cors import CORS

from routes.maocao_logo_route import maocao_logo_bp
from routes.upload_video import upload_video_bp
from routes.get_video import get_video_bp
from routes.process_frame import process_frame_bp

app = Flask(__name__)
CORS(app)

app.register_blueprint(maocao_logo_bp)
app.register_blueprint(upload_video_bp)
app.register_blueprint(get_video_bp)
app.register_blueprint(process_frame_bp)


@app.route("/")
def index():
    return render_template("index.html")


@app.route("/test-audio")
def test_audio():
    return app.send_static_file("audios/test-song-1.mp3")


if __name__ == "__main__":
    app.run(debug=True)
