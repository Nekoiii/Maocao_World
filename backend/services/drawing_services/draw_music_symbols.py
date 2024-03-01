import os
import cv2
import numpy as np
from PIL import Image, ImageDraw, ImageFont
from constants.music_constants import music_symbols
from .draw_bounding_boxes import draw_bounding_boxes


FONT_PATH = os.path.join(
    os.path.dirname(os.path.dirname(os.path.dirname(__file__))),
    "static",
    "fonts",
    "NotoMusic-Regular.ttf",
)


CLASSES_COLORS_DICT = {"cable": (255, 0, 0), "tower_wooden": (0, 0, 255)}


def draw_music_symbols(frame, results, if_show_boxes):
    frame = process_result(frame, results, if_show_boxes)
    return frame


def process_result(frame, results, if_show_boxes):
    pil_img = Image.fromarray(cv2.cvtColor(frame, cv2.COLOR_BGR2RGB))
    draw = ImageDraw.Draw(pil_img)

    for result in results:
        boxes = np.array(result.boxes.xyxy.cpu(), dtype="int")
        classes = np.array(result.boxes.cls.cpu(), dtype="int")
        for cls, box in zip(classes, boxes):
            class_name = result.names[cls]

            if if_show_boxes:
                draw_bounding_boxes(
                    draw, class_name, box, CLASSES_COLORS_DICT, if_show_label=True
                )

            if class_name == "cable":  # Only draw symbols for class 'cable'
                draw_notes(draw, box)

    frame = cv2.cvtColor(np.array(pil_img), cv2.COLOR_RGB2BGR)

    return frame


def draw_notes(draw, box):
    x1, y1, x2, y2 = box

    symbols = [item["symbol"] for item in music_symbols]
    weights = [item["weight"] for item in music_symbols]
    total_weight = sum(weights)
    probabilities = [w / total_weight for w in weights]

    center_x = (x1 + x2) // 2
    center_y = (y1 + y2) // 2
    font = ImageFont.truetype(FONT_PATH, size=100)
    symbol_color = (0, 0, 0)

    symbol = np.random.choice(symbols, p=probabilities)

    draw.text((center_x, center_y), symbol, font=font, fill=symbol_color)
