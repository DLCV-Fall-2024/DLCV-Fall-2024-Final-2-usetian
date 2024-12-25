#---------------------------------------------anime-------------------------------------------

real_character=1
seed=$1

if [ ${real_character} -eq 1 ]
then
  # fused_model="experiments/composed_edlora/chilloutmix/cat+dog+pet/combined_model_base"
  fused_model="experiments/composed_edlora/chilloutmix/cat+dog+pet/combined_model_base"
  expdir="org"
  keypose_condition=''
  # keypose_condition='experiments/composed_edlora/chilloutmix/potter+hermione+thanos_chilloutmix/combined_model_base'
  keypose_adaptor_weight=1.0

  # sketch_condition='/home/frieren/r12921062/Mix-of-Show/datasets/validation_spatial_condition/multi-objects/dogA_catA_dogB.jpg'
  sketch_condition='/home/frieren/r12921062/Mix-of-Show/datasets/validation_spatial_condition/characters-objects/try5.jpg'
  sketch_adaptor_weight=1.0

  context_prompt='A <cat1> <cat2> on the right and a <dogB1> <dogB2> on the left'
  context_neg_prompt='low quality, extra digit, cropped, worst quality, missing face, missing legs, missing eyes, animals in the background'

  region1_prompt='[a <dogB1> <dogB2>, young corgi]'
  region1_neg_prompt="[${context_neg_prompt}]"
  # region1='[180, 10, 600, 260]'
  region1='[0, 90, 510, 485]'

  region2_prompt='[a <cat1> <cat2>, gray cat]'
  region2_neg_prompt="[${context_neg_prompt}]"
  # region2='[240, 480, 720, 720]'
  region2='[0, 550, 510, 850]'



  # region1='[4, 6, 1024, 490]'
  # region2='[14, 490, 1024, 920]'
  # region3='[2, 1302, 1024, 1992]'

  region3_prompt='[A <dogB1> <dogB2>, chihuahua, ]'
  region3_neg_prompt="[${context_neg_prompt}]"
  region3='[134, 666, 512, 1005]'
  # |${region2_prompt}-*-${region2_neg_prompt}-*-${region2}
  prompt_rewrite="${region1_prompt}-*-${region1_neg_prompt}-*-${region1}|${region2_prompt}-*-${region2_neg_prompt}-*-${region2}"
  # prompt="{region3_prompt}-*-${region3_neg_prompt}-*-${region3}"

  python regionally_controlable_sampling_no.py \
    --pretrained_model=${fused_model} \
    --sketch_adaptor_weight=${sketch_adaptor_weight}\
    --sketch_condition=${sketch_condition} \
    --keypose_adaptor_weight=${keypose_adaptor_weight}\
    --keypose_condition=${keypose_condition} \
    --save_dir="results/p1_exp/${expdir}" \
    --prompt="${context_prompt}" \
    --negative_prompt="${context_neg_prompt}" \
    --prompt_rewrite="${prompt_rewrite}" \
    --suffix="baseline" \
    --seed=$seed
fi
