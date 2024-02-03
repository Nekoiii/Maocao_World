from flask import Blueprint, request, jsonify
import os
from werkzeug.utils import secure_filename
from services.video_processor import process_video

upload_bp = Blueprint('upload', __name__)

@upload_bp.route('/upload', methods=['POST'])
def upload_video():
    video = request.files['video']
    filename = secure_filename(video.filename)
    video.save(os.path.join('path/to/save', filename))

    detections = process_video(os.path.join('path/to/save', filename))

    return jsonify(detections)

