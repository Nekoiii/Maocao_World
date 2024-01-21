from flask import Flask, render_template,send_from_directory

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/test-audio')
def test_audio():
    return app.send_static_file('audios/test-song-1.mp3')

@app.route('/test-img')
def test_img():
    return send_from_directory('static','images/test-img-1.jpg')


if __name__ == '__main__':
    app.run()
