from flask import Blueprint, send_from_directory

get_video_bp = Blueprint("get_video", __name__)


@get_video_bp.route("/get_video")
def get_video():
    return send_from_directory("outputs", "output_video.mp4")
