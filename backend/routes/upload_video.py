from flask import Blueprint, request, jsonify
import os
from datetime import datetime
from werkzeug.utils import secure_filename
from services.ml_services.detect_wires_with_yolo import detect_wires_with_yolo

upload_video_bp = Blueprint("upload_video", __name__)

UPLOAD_FOLDER = "uploads"


@upload_video_bp.route("/upload_video", methods=["POST"])
def upload_video():
    try:
        print("a--1-request.files", request.files)
        print("a--2-request.form", request.form)
        print("a--3-request", request)

        video = request.files["video"]
        filename = secure_filename(video.filename)
        save_path = os.path.join(UPLOAD_FOLDER, filename)
        video.save(save_path)

        detections = detect_wires_with_yolo(save_path)

        # os.remove(save_path)  # 删除临时文件
        return jsonify(detections)
    except Exception as e:
        print(f"Error occurred: {e}")
        return jsonify({"error": str(e)}), 500
