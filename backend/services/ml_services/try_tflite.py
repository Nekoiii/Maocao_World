import os
import numpy as np
import tensorflow as tf
from PIL import Image


current_dir = os.path.dirname(os.path.abspath(__file__))
MODEL_PATH = os.path.join(
    current_dir,
    "..",
    "..",
    "models",
    "yolov8_wires_dect_best_saved_model",
    "yolov8_wires_dect_best_float32.tflite",
)
# MODEL_PATH = os.path.join(
#     current_dir,
#     "..",
#     "..",
#     "models",
#     "yolov8n_saved_model",
#     "yolov8n_float16.tflite",
# )
INPUT_IMG_PATH = os.path.join(current_dir, "..", "..", "static", "images", "sky-1.jpg")
interpreter = tf.lite.Interpreter(model_path=MODEL_PATH)

interpreter.allocate_tensors()

input_details = interpreter.get_input_details()
output_details = interpreter.get_output_details()


print("try_tflite-- input_details: ", input_details, "output_details: ", output_details)


input_image = Image.open(INPUT_IMG_PATH).resize((640, 640))
input_tensor = np.array(input_image, dtype=np.float32)[np.newaxis, ...] / 255.0
interpreter.set_tensor(input_details[0]["index"], input_tensor)

interpreter.invoke()
print("try_tflite-- output_details[0]: ", output_details[0])

output_data = interpreter.get_tensor(output_details[0]["index"])
# print("try_tflite-- output_data: ", output_data)
print("try_tflite-- output_data.shape: ", output_data.shape)


# for i in range(output_data.shape[2]):
#     detection = output_data[0, :, i]
#     x, y, width, height, confidence, class_prob = detection

#     if confidence > 0.5:
#         print(
#             f"try_tflite-- Detected bbox: [{x}, {y}, {width}, {height}], confidence: {confidence}, class_prob: {class_prob}"
#         )
