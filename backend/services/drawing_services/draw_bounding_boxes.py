import cv2
from PIL import ImageFont

FONT = ImageFont.load_default()

CLASSES_COLORS_DICT = {"default": (255, 0, 0)}
DEFAULT_COLOR = (0, 0, 0)


def draw_bounding_boxes(
    draw, class_name, bbox, colors=CLASSES_COLORS_DICT, if_show_label=True
):
    x1, y1, x2, y2 = bbox
    color = colors.get(class_name, DEFAULT_COLOR)
    draw.rectangle([(x1, y1), (x2, y2)], outline=color, width=2)
    if if_show_label:
        draw.text((x1, y1 - 5), class_name, font=FONT, fill=color)
