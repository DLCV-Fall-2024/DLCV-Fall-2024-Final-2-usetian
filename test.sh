#---------------------------------------------anime-------------------------------------------

real_character=1

if [ ${real_character} -eq 1 ]
then
  fused_model="experiments/composed_edlora/chilloutmix/cat+dog/combined_model_base"
  expdir="cat+dog_chilloutmix"

  keypose_condition=''
  keypose_adaptor_weight=0.0

  sketch_condition='/home/frieren/r12921062/Mix-of-Show/datasets/validation_spatial_condition/multi-objects/dogA_catA_dogB.jpg'
  #  sketch_condition=''
  sketch_adaptor_weight=0.0

  context_prompt='A <cat1> <cat2> in the right and a <dog1> <dog2> in the left'
  context_neg_prompt='extra objects, merge objects, merge animal, extra body, overlap body, long legs'

  region1_prompt='[a <dog1> <dog2>, corgi, on the grass]'
  region1_neg_prompt="[${context_neg_prompt}]"
  region1='[4, 6, 800, 1200]'

  # region2_prompt='[a cute <dog1> <dog2>, fluffy orange and white fur, high quality, tongue out, best quality]'
  # region2_neg_prompt="[${context_neg_prompt}]"
  # region2='[14, 490, 1024, 920]'

  region3_prompt='[A <cat1> <cat2>, on the grass]'
  region3_neg_prompt="[${context_neg_prompt}]"
  region3='[800, 1102, 1324, 1492]'
  # |${region2_prompt}-*-${region2_neg_prompt}-*-${region2}
  prompt_rewrite="${region1_prompt}-*-${region1_neg_prompt}-*-${region1}|${region3_prompt}-*-${region3_neg_prompt}-*-${region3}"

  python regionally_controlable_sampling_no.py \
    --pretrained_model=${fused_model} \
    --sketch_adaptor_weight=${sketch_adaptor_weight}\
    --sketch_condition=${sketch_condition} \
    --keypose_adaptor_weight=${keypose_adaptor_weight}\
    --keypose_condition=${keypose_condition} \
    --save_dir="results/mine/${expdir}" \
    --prompt="${context_prompt}" \
    --negative_prompt="${context_neg_prompt}" \
    --prompt_rewrite="${prompt_rewrite}" \
    --suffix="baseline" \
    --seed=14
fi
