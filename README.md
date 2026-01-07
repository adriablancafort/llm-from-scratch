# Training an LLM from scratch

Based on the nanochat architecture, this repository contains all the code required to train a Large Language Model from scratch for less than $100 just by running the [training.sh](training.sh) script.

[<img src="https://img.youtube.com/vi/Nd94u8Ij86A/sddefault.jpg" alt="Demo Video" style="width: 100%;">](https://www.youtube.com/watch?v=Nd94u8Ij86A "Watch the demo video")

The training process takes about 4 hours in a 8xH100 node. It consists of the following phases:

### Phase 1: Tokenizer Training

The journey begins by creating a custom tokenizer, the component that converts text into numbers the model can process. The training downloads ~2 billion characters from the FineWeb-Edu dataset and trains a Byte Pair Encoding (BPE) tokenizer with a vocabulary of 65,536 tokens.

It includes special tokens like `<|user_start|>`, `<|assistant_start|>`, and `<|python_start|>` that will later enable chat formatting and tool use. The tokenizer achieves about 4.8 characters per token, making it efficient at compressing text.

**Files**: [scripts/tok_train.py](scripts/tok_train.py), [scripts/tok_eval.py](scripts/tok_eval.py)

### Phase 2: Base Model Pretraining

This is where the actual neural network learns language. The model architecture (called "d20") has 561 million parameters organized into 20 transformer layers with a model dimension of 1,280. It uses features like:

- **Rotary Position Embeddings (RoPE)** for understanding word positions
- **Group Query Attention (GQA)** for efficiency
- **ReLU² activation** in the feedforward layers
- **QK normalization** for training stability

Following the Chinchilla scaling laws (20× tokens as parameters), the training processes about 11.2 billion tokens from 240 data shards, roughly 24GB of internet text. The script downloads these in the background while the tokenizer trains.

The training uses a hybrid optimizer: **Muon** (a momentum-based optimizer) for the transformer weights and **AdamW** for embeddings. With a batch size of 524K tokens across 8 GPUs, the model learns to predict the next token, developing fundamental language understanding.

Evaluation happens on multiple fronts: validation loss measured in bits-per-byte (a tokenizer-agnostic metric) and the CORE benchmark suite for language understanding tasks.

**Files**: [scripts/base_train.py](scripts/base_train.py), [scripts/base_eval.py](scripts/base_eval.py)

### Phase 3: Midtraining

Now that the model understands language, it needs to learn conversation structure. Midtraining introduces 848K examples from a carefully crafted mixture:

- **SmolTalk (460K)**: General conversational data
- **MMLU auxiliary (100K)**: Multiple-choice questions teaching reasoning
- **GSM8K (8K)**: Math problems with Python calculator tool use
- **Identity conversations (2K)**: Synthetic data giving the model personality
- **Spelling tasks (280K)**: Simple educational tasks

This phase teaches the model how to use those special tokens from the tokenizer, how conversations are structured with user and assistant turns, and crucially, how to use tools like a Python calculator to solve math problems. The training runs for one epoch with a lower learning rate than pretraining.

**Files**: [scripts/mid_train.py](scripts/mid_train.py), [scripts/chat_eval.py](scripts/chat_eval.py)

### Phase 4: Supervised Fine-Tuning

SFT takes the conversational model and aligns it to be helpful and accurate. Using a curated 23K examples from datasets like ARC (science questions), GSM8K (math), and SmolTalk conversations, the model learns to follow instructions precisely.

Each conversation is treated independently with variable-length batches. The model only learns from the assistant's responses, the user prompts are masked out. This prevents the model from imitating user behavior and focuses it on generating good responses.

**Files**: [scripts/chat_sft.py](scripts/chat_sft.py)

### Phase 5: Reinforcement Learning

The final optional phase uses reinforcement learning to improve mathematical reasoning. Using a simplified version of GRPO (Group Relative Policy Optimization), the model:

1. Generates 16 solution attempts per math problem
2. Receives binary rewards (correct/incorrect) by checking answers
3. Updates its policy to favor successful reasoning paths

This uses on-policy learning without a reference model or PPO clipping. The model learns directly from its own sampled solutions with token-level advantage normalization. Evaluation tracks pass@k metrics (success rate when sampling k attempts).

**Files**: [scripts/chat_rl.py](scripts/chat_rl.py)

## Implementation

### The Model Architecture ([llm/gpt.py](llm/gpt.py))

The GPT implementation includes several modern features:
- **RMSNorm** (functional, no learnable parameters) for layer normalization
- **Logit soft-capping** (tanh scaling to ±15) preventing extreme outputs
- Vocabulary padding to multiples of 64 for distributed training efficiency
- Untied embedding/unembedding matrices (separate input and output embeddings)

### Data Pipeline ([llm/dataset.py](llm/dataset.py))

The dataset module downloads FineWeb-Edu shards on-demand from HuggingFace. With 1,822 total shards available (each ~250M characters), it streams data efficiently using Parquet format without loading everything into memory.

### Inference Engine ([llm/engine.py](llm/engine.py))

The inference system implements:
- **KV caching** for efficient generation (reusing computed attention states)
- **Batch prefill** then parallel decode across multiple prompts
- **Tool integration** where the model can invoke a Python calculator and incorporate results
- Per-conversation state tracking for multi-turn interactions

### Reporting ([llm/report.py](llm/report.py))

Throughout training, the system generates markdown reports tracking metrics across all phases, hardware specifications, estimated costs, and comparative performance between base/mid/sft/rl checkpoints.

## Inference

After training completes, you can interact with your model through two interfaces:

### Web UI

The [inference.sh](inference.sh) script launches a FastAPI server with a ChatGPT-like web interface. The UI ([ui/index.html](ui/index.html)) provides a clean chat experience with:
- Real-time streaming responses
- Multi-turn conversation history
- Support for temperature and sampling parameters

The web server ([scripts/chat_web.py](scripts/chat_web.py)) supports multi-GPU inference with automatic load balancing across available workers.

### CLI

For command-line interaction, use [scripts/chat_cli.py](scripts/chat_cli.py):

```bash
# Interactive chat
python -m scripts.chat_cli

# Single prompt
python -m scripts.chat_cli -p "Why is the sky blue?"
```

Both interfaces support the model's tool use capabilities, including the integrated Python calculator for math problems.
