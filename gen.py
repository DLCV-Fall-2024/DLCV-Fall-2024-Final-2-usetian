import json
import os

import torch
from diffusers import DPMSolverMultistepScheduler

from mixofshow.pipelines.pipeline_edlora import EDLoRAPipeline

pretrained_model_path = 'experiments/composed_edlora/chilloutmix/cat+glasses+watercolor/combined_model_base'
enable_edlora = True  # True for edlora, False for lora

pipe = EDLoRAPipeline.from_pretrained(pretrained_model_path, scheduler=DPMSolverMultistepScheduler.from_pretrained(pretrained_model_path, subfolder='scheduler'), torch_dtype=torch.float16).to('cuda')
with open(f'{pretrained_model_path}/new_concept_cfg.json', 'r') as fr:
    new_concept_cfg = json.load(fr)
pipe.set_new_concept_cfg(new_concept_cfg)

# TOK = '<thanos1> <thanos2>'  # the TOK is th800, 500, 1200, 1000e concept name when training lora/edlora
prompt = f'A cat wearing a glasses in a  <watercolor1> <watercolor2> style.'
negative_prompt = 'extra objects, extra animals'

image = pipe(prompt, negative_prompt=negative_prompt, height=512, width=1024, num_inference_steps=50, generator=torch.Generator('cuda').manual_seed(42), guidance_scale=10.0).images[0]

image.save(f'res.jpg')