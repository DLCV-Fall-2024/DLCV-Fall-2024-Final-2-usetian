
seeds=(0 14 27 28 30 31 33 36 37 42) # 替換成你需要的種子列表
# 遍歷種子並運行腳本
for seed in "${seeds[@]}"
do
    bash regionally_sample_p1.sh "$seed" # 調用腳本，傳入當前種子
done
