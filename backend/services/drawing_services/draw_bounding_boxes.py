import cv2


def draw_bounding_boxes(frame, bboxes):
    for x1, y1, x2, y2 in bboxes:
        cv2.rectangle(frame, (x1, y1), (x2, y2), (0, 0, 255), 2)
    return frame
