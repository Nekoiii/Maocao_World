import os
from ultralytics import YOLO


def pt_to_tflite(model_path):
    model = YOLO(model_path)
    # model.export(format="tflite")
    model.export(format="tflite", int8=True)


current_dir = os.path.dirname(os.path.abspath(__file__))
model_path = os.path.join(
    current_dir, os.path.pardir, os.path.pardir, "models", "yolov8_wires_dect_best.pt"
)
pt_to_tflite(model_path)
