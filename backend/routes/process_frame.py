from flask import Blueprint, request, jsonify
import cv2
import numpy as np
from services.ml_services.detect_wires_with_yolo import detect_wires_with_yolo

process_frame_bp = Blueprint("process_frame", __name__)


@process_frame_bp.route("/process_frame", methods=["POST"])
def process_frame():
    file = request.files["frame"].read()
    nparr = np.frombuffer(file, np.uint8)
    frame = cv2.imdecode(nparr, cv2.IMREAD_COLOR)

    results = detect_wires_with_yolo(frame)

    return jsonify(results)
