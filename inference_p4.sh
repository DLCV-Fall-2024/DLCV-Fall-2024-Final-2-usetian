
seeds=(0 1 3 4 6 11 13 15 18 19 22 24 25 27 29) # 替換成你需要的種子列表
# 遍歷種子並運行腳本
for seed in {1..100};
do
    bash regionally_sample_p4.sh "$seed" # 調用腳本，傳入當前種子
done
