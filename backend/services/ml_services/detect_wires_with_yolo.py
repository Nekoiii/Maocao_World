import os
import pdb

import cv2
import numpy as np
from ultralytics import YOLO
from services.drawing_services.draw_bounding_boxes import draw_bounding_boxes
from services.drawing_services.draw_music_symbols import draw_music_symbols

from services.video_services.video_processor import read_video_frames, frames_to_video

current_dir = os.path.dirname(os.path.abspath(__file__))
MODEL_PATH = os.path.join(
    current_dir, os.path.pardir, os.path.pardir, "models", "yolov8_wires_dect_best.pt"
)
OUTPUT_FOLDER = "outputs"
if not os.path.exists(OUTPUT_FOLDER):
    os.makedirs(OUTPUT_FOLDER)

model = YOLO(MODEL_PATH)

IF_SHOW_BBOXES = True


def detect_wires_with_yolo(video_path):
    frames, fps, size = read_video_frames(video_path)

    processed_frames = []

    for frame in frames:
        results = detect(frame)

        processed_frame = draw_music_symbols(frame, results, IF_SHOW_BBOXES)
        processed_frames.append(processed_frame)

    output_path = os.path.join(OUTPUT_FOLDER, "output_video.mp4")
    frames_to_video(processed_frames, output_path, fps, size)


def detect(frame):
    results = model(frame)
    return results
