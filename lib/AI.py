import tensorflow as tf

# تحميل النموذج المدرب
model = tf.keras.models.load_model('keras_model.h5')

# تحويل النموذج إلى TensorFlow Lite
converter = tf.lite.TFLiteConverter.from_keras_model(model)
tflite_model = converter.convert()

# حفظ نموذج TensorFlow Lite إلى ملف
with open('mnist_model.tflite', 'wb') as f:
    f.write(tflite_model)

converter.optimizations = [tf.lite.Optimize.DEFAULT]
tflite_model = converter.convert()
with open('mnist_model_optimized.tflite', 'wb') as f:
    f.write(tflite_model)
