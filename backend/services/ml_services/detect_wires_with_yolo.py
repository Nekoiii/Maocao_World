import os

import cv2
from ultralytics import YOLO
from services.drawing_services.draw_bounding_boxes import draw_bounding_boxes

from services.video_services.video_processor import (
    read_video_frames,
    get_latest_video_file,
)

current_dir = os.path.dirname(os.path.abspath(__file__))
MODEL_PATH = os.path.join(
    current_dir, os.path.pardir, os.path.pardir, "models", "yolov8_wires_dect_best.pt"
)


def detect_wires_with_yolo(video_path):
    frames = read_video_frames(video_path)
    print(frames)


def detect():
    model = YOLO(MODEL_PATH)
    return
