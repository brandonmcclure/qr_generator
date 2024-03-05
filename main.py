import gradio as gr
import argparse
from PIL import Image
import numpy as np
from amzqr import amzqr
import os
import logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s || %(levelname)s || %(name)s.%(funcName)s:%(lineno)d || %(message)s')

parser = argparse.ArgumentParser(description='QR Code generator')
parser.add_argument(
    '-m', '--model', default=os.environ.get('WHISPER_SERVICE_MODEL','small.en'),
    help='The open AI whisper model to use to detect speech')

args = parser.parse_args()


def generateQR(input_image,input_text,contrast,brightness,colorized,version,error_correction):
    im = Image.fromarray(input_image)
    im.save("img.png")
    version, level, qr_name = amzqr.run(
        input_text,
        version=version,
        level=error_correction,
        picture='./img.png',
        colorized=colorized,
        contrast=(contrast/100.00),
        brightness=(brightness/100.00),
        save_name='qrcode.png',
        save_dir=os.getcwd()
    )

    im_frame = Image.open('./qrcode.png')
    npArray = np.array(im_frame.getdata())
    # logging.info(npArray)
    return im_frame
    
with gr.Blocks(analytics_enabled=False) as grBlock:
    gr.Markdown(
        """
        # QR Code Generator (with an image)

        This app will take a image and some text (usually an URL) and encodes it into a QR code. Play with the contrast, brightness and colorized output to adjust the output to your needs.

        For best results, the image you upload should be square, and have very clear contrast. They can be in color, and you can set the "colorized QR code?" checkbox to output a color image.

        """)
    input_image = gr.Image(label = 'Upload an image to put into the code')
    input_text = gr.Textbox(label="What text to encode")
    contrast = gr.Slider(label='Contrast', value=75, minimum=1, maximum=100)
    brightness = gr.Slider(label='Brightness', value=75, minimum=1, maximum=100)
    version = gr.Slider(label='Version (large numbers make it bigger)', value=1, minimum=1, maximum=40, step=1)
    error_correction = gr.Dropdown(label='Error Correction Level (higher level will reduce the likelihood that the code will have errors) (L=7%, M=15%, Q=25%, H=30%)',value='H', choices=('L','M','Q','H'))
    colorized = gr.Checkbox(label="colorized QR code?")
    btn = gr.Button("Generate code")
    output_image = gr.Image(label='Output QR Code', type='pil',height=400, width=400)
    btn.click(fn=generateQR, inputs=[input_image,input_text,contrast,brightness,colorized,version,error_correction], outputs=[output_image])
grBlock.launch(server_name = '0.0.0.0', server_port = 3008)   