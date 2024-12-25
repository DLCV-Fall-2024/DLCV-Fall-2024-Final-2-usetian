#---------------------------------------------anime-------------------------------------------

real_character=1
seed=$1

if [ ${real_character} -eq 1 ]
then
  # fused_model="experiments/composed_edlora/chilloutmix/cat+dog+pet/combined_model_base"
  fused_model="experiments/composed_edlora/chilloutmix/cat+glasses+watercolor_log/combined_model_base"
  expdir="log"
  keypose_condition=''
  # keypose_condition='experiments/composed_edlora/chilloutmix/potter+hermione+thanos_chilloutmix/combined_model_base'
  keypose_adaptor_weight=1.0

  # sketch_condition='/home/frieren/r12921062/Mix-of-Show/datasets/validation_spatial_condition/multi-objects/dogA_catA_dogB.jpg'
  sketch_condition='/home/frieren/r12921062/Mix-of-Show/datasets/validation_spatial_condition/multi-objects/try6.jpg'
  sketch_adaptor_weight=0.6
  

  context_prompt='A <cat1> <cat2> wearing <glasses1> <glasses2> in a <watercolor1> <watercolor2> style.'
  context_neg_prompt='colorful, low quality, extra digit, cropped, worst quality, missing face, missing legs, eyes cropped, animals in the background'

  region1_prompt='[a <cat1> <cat2>, gray cat]'
  region1_neg_prompt="[${context_neg_prompt}]"
  # region1='[180, 10, 600, 260]'
  region1='[13, 120, 510, 440]'

  region2_prompt='[a <glasses1> <glasses2>, wearable glasses, tortoiseshell glasses, brown, amber, teal highlights]'
  region2_neg_prompt="[${context_neg_prompt}]"
  # region2='[240, 480, 720, 720]'
  region2='[0, 150, 510, 350]'

  
  region3_prompt='[in a <watercolor1> <watercolor2> style, watercolor painting, watercolor illustration, cover the whole image, watercolor background, watercolor texture]'
  region3_neg_prompt="[${context_neg_prompt}]"
  # region2='[240, 480, 720, 720]'
  region3='[0, 0, 512, 512]'

  # |${region2_prompt}-*-${region2_neg_prompt}-*-${region2}
  prompt_rewrite="${region1_prompt}-*-${region1_neg_prompt}-*-${region1}|${region2_prompt}-*-${region2_neg_prompt}-*-${region2}|${region3_prompt}-*-${region3_neg_prompt}-*-${region3}"

  python regionally_controlable_sampling_no.py \
    --pretrained_model=${fused_model} \
    --sketch_adaptor_weight=${sketch_adaptor_weight}\
    --sketch_condition=${sketch_condition} \
    --keypose_adaptor_weight=${keypose_adaptor_weight}\
    --keypose_condition=${keypose_condition} \
    --save_dir="results/p4_exp/${expdir}" \
    --prompt="${context_prompt}" \
    --negative_prompt="${context_neg_prompt}" \
    --prompt_rewrite="${prompt_rewrite}" \
    --suffix="baseline" \
    --seed=$seed
fi
