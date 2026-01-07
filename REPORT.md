# nanochat training report

Generated: 2026-01-07 10:00:42

## Environment

### Git Information
- Branch: main
- Commit: f2211ff (dirty)
- Message: run inference

### Hardware
- Platform: Linux
- CPUs: 104 cores (208 logical)
- Memory: 1771.7 GB
- GPUs: 8x NVIDIA H100 80GB HBM3
- GPU Memory: 633.5 GB total
- CUDA Version: 12.8
- Hourly Rate: $24.00/hour

### Software
- Python: 3.12.3
- PyTorch: 2.9.1+cu128


### Bloat
- Characters: 317,933
- Lines: 7,347
- Files: 37
- Tokens (approx): 79,483
- Dependencies (uv.lock lines): 3,438

Run started: 2026-01-07 10:00:48

---

## Tokenizer training
timestamp: 2026-01-07 10:01:52

- max_chars: 2,000,000,000
- doc_cap: 10,000
- vocab_size: 65,536
- train_time: 58.6116
- num_special_tokens: 9
- token_bytes_min: 1
- token_bytes_max: 32
- token_bytes_mean: 6.9197
- token_bytes_std: 2.8748


## Tokenizer evaluation
timestamp: 2026-01-07 10:01:57

### Comparison with GPT-2

| Text Type | Bytes | GPT-2 Tokens | GPT-2 Ratio | Ours Tokens | Ours Ratio | Relative Diff % |
|-----------|-------|--------------|--------------|-------------|------------|-----------------|
| news | 1819 | 404 | 4.50 | 375 | 4.85 | +7.2% |
| korean | 893 | 745 | 1.20 | 712 | 1.25 | +4.4% |
| code | 1259 | 576 | 2.19 | 492 | 2.56 | +14.6% |
| math | 1834 | 936 | 1.96 | 966 | 1.90 | -3.2% |
| science | 1112 | 260 | 4.28 | 228 | 4.88 | +12.3% |
| fwe-train | 4208518 | 900364 | 4.67 | 856883 | 4.91 | +4.8% |
| fwe-val | 4908443 | 1059062 | 4.63 | 1010352 | 4.86 | +4.6% |

### Comparison with GPT-4

| Text Type | Bytes | GPT-4 Tokens | GPT-4 Ratio | Ours Tokens | Ours Ratio | Relative Diff % |
|-----------|-------|--------------|--------------|-------------|------------|-----------------|
| news | 1819 | 387 | 4.70 | 375 | 4.85 | +3.1% |
| korean | 893 | 364 | 2.45 | 712 | 1.25 | -95.6% |
| code | 1259 | 309 | 4.07 | 492 | 2.56 | -59.2% |
| math | 1834 | 832 | 2.20 | 966 | 1.90 | -16.1% |
| science | 1112 | 249 | 4.47 | 228 | 4.88 | +8.4% |
| fwe-train | 4208518 | 874799 | 4.81 | 856883 | 4.91 | +2.0% |
| fwe-val | 4908443 | 1029691 | 4.77 | 1010352 | 4.86 | +1.9% |


## Base model training
timestamp: 2026-01-07 13:04:23

- run: dummy
- device_type: 
- depth: 20
- max_seq_len: 2048
- num_iterations: -1
- target_flops: -1.0000
- target_param_data_ratio: 20
- device_batch_size: 32
- total_batch_size: 524,288
- embedding_lr: 0.3000
- unembedding_lr: 0.0040
- weight_decay: 0.0000
- matrix_lr: 0.0200
- grad_clip: 1.0000
- warmup_ratio: 0.0000
- warmdown_ratio: 0.4000
- final_lr_frac: 0.0000
- resume_from_step: -1
- eval_every: 250
- eval_tokens: 10,485,760
- core_metric_every: 2000
- core_metric_max_per_task: 500
- sample_every: 2000
- save_every: -1
- model_tag: None
- Number of parameters: 560,988,160
- Number of FLOPs per token: 3.491758e+09
- Calculated number of iterations: 21,400
- Number of training tokens: 11,219,763,200
- Tokens : Params ratio: 20.0000
- DDP world size: 8
- warmup_ratio: 0.0000
- warmdown_ratio: 0.4000
- final_lr_frac: 0.0000
- Minimum validation bpb: 0.8119
- Final validation bpb: 0.8119
- CORE metric estimate: 0.2126
- MFU %: 47.88%
- Total training flops: 3.917670e+19
- Total training time: 172.26m
- Peak memory usage: 75481.40MiB


## Base model loss
timestamp: 2026-01-07 13:05:01

- train bpb: 0.8146
- val bpb: 0.8119
- sample 0: <|bos|>The capital of France is Paris. It is located in the south of France. Paris is the capital of
- sample 1: <|bos|>The chemical symbol of gold is Au. It is a soft, malleable, ductile, and very malleable metal.
- sample 2: <|bos|>If yesterday was Friday, then tomorrow will be Tuesday. If yesterday was Monday, then tomorrow will be Tuesday. If yesterday was
- sample 3: <|bos|>The opposite of hot is cold. The opposite of hot is cold. The opposite of hot is cold.
- sample 4: <|bos|>The planets of the solar system are: Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune,
- sample 5: <|bos|>My favorite color is blue. I love the color blue. I love the color blue. I love
- sample 6: <|bos|>If 5*x + 3 = 13, then x is a multiple of 3. So, 5*x + 3 =


## Base model evaluation
timestamp: 2026-01-07 13:08:35

- Model: base_model (step 21400)
- CORE metric: 0.1998
- hellaswag_zeroshot: 0.2616
- jeopardy: 0.0879
- bigbench_qa_wikidata: 0.5277
- arc_easy: 0.5387
- arc_challenge: 0.1342
- copa: 0.3000
- commonsense_qa: 0.0643
- piqa: 0.3656
- openbook_qa: 0.1067
- lambada_openai: 0.3854
- hellaswag: 0.2665
- winograd: 0.3114
- winogrande: 0.0971
- bigbench_dyck_languages: 0.1390
- agi_eval_lsat_ar: 0.0707
- bigbench_cs_algorithms: 0.3848
- bigbench_operators: 0.1429
- bigbench_repeat_copy_logic: 0.0000
- squad: 0.2360
- coqa: 0.1977
- boolq: -0.4067
- bigbench_language_identification: 0.1838


## Midtraining
timestamp: 2026-01-07 13:17:37

- run: dummy
- device_type: 
- dtype: bfloat16
- model_tag: None
- model_step: None
- num_iterations: -1
- max_seq_len: 2048
- device_batch_size: 32
- total_batch_size: 524,288
- embedding_lr: 0.2000
- unembedding_lr: 0.0040
- matrix_lr: 0.0200
- weight_decay: 0.0000
- init_lr_frac: 1.0000
- eval_every: 150
- eval_tokens: 10,485,760
- dry_run: False
- Number of iterations: 809
- DDP world size: 8
- Minimum validation bpb: 0.3959


## Chat evaluation mid
timestamp: 2026-01-07 13:24:38

- source: mid
- task_name: None
- dtype: bfloat16
- temperature: 0.0000
- max_new_tokens: 512
- num_samples: 1
- top_k: 50
- batch_size: 8
- model_tag: None
- step: None
- max_problems: None
- device_type: 
- ARC-Easy: 0.3140
- ARC-Challenge: 0.2782
- MMLU: 0.2870
- GSM8K: 0.0394
- HumanEval: 0.1098
- SpellingBee: 0.9844
- ChatCORE metric: 0.2176


## Chat SFT
timestamp: 2026-01-07 13:26:46

- run: dummy
- device_type: 
- dtype: bfloat16
- source: mid
- model_tag: None
- model_step: None
- num_epochs: 1
- num_iterations: -1
- device_batch_size: 4
- target_examples_per_step: 32
- embedding_lr: 0.2000
- unembedding_lr: 0.0040
- matrix_lr: 0.0200
- weight_decay: 0.0000
- init_lr_frac: 0.0200
- eval_every: 100
- eval_steps: 100
- eval_metrics_every: 200
- eval_metrics_max_problems: 1024
- Training rows: 22,439
- Number of iterations: 701
- Training loss: 0.5306
- Validation loss: 1.0123


## Chat evaluation sft
timestamp: 2026-01-07 13:33:24

- source: sft
- task_name: None
- dtype: bfloat16
- temperature: 0.0000
- max_new_tokens: 512
- num_samples: 1
- top_k: 50
- batch_size: 8
- model_tag: None
- step: None
- max_problems: None
- device_type: 
- ARC-Easy: 0.3173
- ARC-Challenge: 0.2858
- MMLU: 0.2891
- GSM8K: 0.0485
- HumanEval: 0.1037
- SpellingBee: 0.9766
- ChatCORE metric: 0.2197


## Summary

- Characters: 317,933
- Lines: 7,347
- Files: 37
- Tokens (approx): 79,483
- Dependencies (uv.lock lines): 3,438

| Metric          | BASE     | MID      | SFT      | RL       |
|-----------------|----------|----------|----------|----------|
| CORE            | 0.1998   | -        | -        | -        |
| ARC-Challenge   | -        | 0.2782   | 0.2858   | -        |
| ARC-Easy        | -        | 0.3140   | 0.3173   | -        |
| GSM8K           | -        | 0.0394   | 0.0485   | -        |
| HumanEval       | -        | 0.1098   | 0.1037   | -        |
| MMLU            | -        | 0.2870   | 0.2891   | -        |
| ChatCORE        | -        | 0.2176   | 0.2197   | -        |

Total wall clock time: 3h32m
