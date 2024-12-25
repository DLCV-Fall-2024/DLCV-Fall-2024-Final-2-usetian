#---------------------------------------------anime-------------------------------------------

real_character=1
seed=$1

if [ ${real_character} -eq 1 ]
then
  fused_model="experiments/composed_edlora/chilloutmix/cat+dog+pet_log/combined_model_base"
  expdir="log_p3"
  keypose_condition=''
  # keypose_condition='experiments/composed_edlora/chilloutmix/potter+hermione+thanos_chilloutmix/combined_model_base'
  keypose_adaptor_weight=1.0

  # sketch_condition='/home/frieren/r12921062/Mix-of-Show/datasets/validation_spatial_condition/multi-objects/dogA_catA_dogB.jpg'
  sketch_condition='/home/frieren/r12921062/Mix-of-Show/datasets/validation_spatial_condition/multi-objects/try4.jpg'
  sketch_adaptor_weight=1.0

  context_prompt='A <dogA1> <dogA2>, a <pet_cat1> <pet_cat2> and a <dogB1> <dogB2> near a forest.'
  context_neg_prompt='low quality, extra digit, cropped, worst quality, missing face, missing legs, missing eyes, animals in the background'

  region1_prompt='[a <dogA1> <dogA2>, orange flur, corgi, near a forest]'
  region1_neg_prompt="[${context_neg_prompt}]"
  region1='[122, 13, 506, 322]'

  region2_prompt='[a cute <pet_cat1> <pet_cat2>, persian cat, near a forest]'
  region2_neg_prompt="[${context_neg_prompt}]"
  region2='[122, 350, 500, 712]'

  region3_prompt='[a <dogB1> <dogB2>, young corgi,near a forest]'
  region3_neg_prompt="[${context_neg_prompt}]"
  region3='[122, 716, 500, 1010]'
  # |${region2_prompt}-*-${region2_neg_prompt}-*-${region2}
  prompt_rewrite="${region1_prompt}-*-${region1_neg_prompt}-*-${region1}|${region2_prompt}-*-${region2_neg_prompt}-*-${region2}|${region3_prompt}-*-${region3_neg_prompt}-*-${region3}"

  python regionally_controlable_sampling_no.py \
    --pretrained_model=${fused_model} \
    --sketch_adaptor_weight=${sketch_adaptor_weight}\
    --sketch_condition=${sketch_condition} \
    --keypose_adaptor_weight=${keypose_adaptor_weight}\
    --keypose_condition=${keypose_condition} \
    --save_dir="results/p3_exp/${expdir}" \
    --prompt="${context_prompt}" \
    --negative_prompt="${context_neg_prompt}" \
    --prompt_rewrite="${prompt_rewrite}" \
    --suffix="baseline" \
    --seed=$seed
fi

