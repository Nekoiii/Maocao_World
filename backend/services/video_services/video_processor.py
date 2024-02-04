import os
import cv2


def read_video_frames(video_path):
    cap = cv2.VideoCapture(video_path)
    frames = []

    while cap.isOpened():
        ret, frame = cap.read()
        if not ret:
            break
        frames.append(frame)

    cap.release()
    return frames


def get_latest_video_file(upload_folder):
    video_files = [
        os.path.join(upload_folder, f)
        for f in os.listdir(upload_folder)
        if os.path.isfile(os.path.join(upload_folder, f))
    ]
    if not video_files:
        return None

    latest_file = max(video_files, key=os.path.getmtime)
    return latest_file
