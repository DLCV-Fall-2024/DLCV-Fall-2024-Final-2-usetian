
seeds=(34 36 40 4 7 9 15 23 24 26 48 57 62 68) # 替換成你需要的種子列表
# 遍歷種子並運行腳本
for seed in "${seeds[@]}"
do
    bash regionally_sample_p3.sh "$seed" # 調用腳本，傳入當前種子
done
