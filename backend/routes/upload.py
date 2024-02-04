from flask import Blueprint, request, jsonify
import os
from werkzeug.utils import secure_filename
from services.video_processor import process_video

upload_bp = Blueprint("upload", __name__)

UPLOAD_FOLDER = "uploads"


@upload_bp.route("/upload", methods=["POST"])
def upload_video():
    print("a--0")
    print("a--1", request.files)
    # return jsonify({"message": "Upload processed"}), 200
    try:
        print("a--1", request.files)
        print("a--2", request.form)
        print("a--3", request)
        video = request.files["video"]
        filename = secure_filename(video.filename)
        save_path = os.path.join(UPLOAD_FOLDER, filename)
        video.save(save_path)

        detections = process_video(save_path)

        # os.remove(save_path)  # 删除临时文件
        print("a--000")
        return jsonify(detections)
    except Exception as e:
        print(f"Error occurred: {e}")
        return jsonify({"error": str(e)}), 500
