# DLCV Final Project ( Multiple Concept Personalization )

# Data prepare
```shell script=
bash get_dataset.sh
# put my_data into datasets/
```

# How to run your code?
* TODO: Please provide the scripts for TAs to reproduce your results, including training and inference. For example, 

```shell script=
# training
bash run_single.sh
# change the config_file names to the target one you want.
# we use cat+dog+pet
bash fuse.sh

# inference
bash inference_p1.sh
bash inference_p3.sh
bash inference_p4.sh
```

# Usage
Download the pretrain model first
```shell script=
git clone https://github.com/DLCV-Fall-2024/DLCV-Fall-2024-Final-2-usetian.git

cd experiments/pretrained_models

# Diffusers-version ChilloutMix
git-lfs clone https://huggingface.co/windwhinny/chilloutmix.git
```
Our checkpoints can be download here [model_checkpoints](https://drive.google.com/drive/folders/1fKEP08YXgBCP95pgMtQrSlO1_hwAETgm?usp=sharing)

Our model should be put under 
```
experiments
|_____ composed_edlora
    |_______ our models folder

```


For more details, please click [this link](https://docs.google.com/presentation/d/1eeXx_dL0OgkDn9_lhXnimTHrE6OYvAiiVOBwo2CTVOQ/edit?usp=sharing) to view the slides of Final Project - Multiple Concept Personalization. **The introduction video for final project can be accessed in the slides.**

# Submission Rules
### Deadline
113/12/26 (Thur.) 23:59 (GMT+8)
    
# Q&A
If you have any problems related to Final Project, you may
- Use TA hours
- Contact TAs by e-mail ([ntudlcv@gmail.com](mailto:ntudlcv@gmail.com))
- Post your question under `[Final challenge 2] Discussion` section in NTU Cool Discussion
