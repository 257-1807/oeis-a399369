# A379240 的已报道反例与 A399369 猜想 2

核查日期为 2026-11-25。A399369 猜想 2 只比较有正进位差的数对。A379240 的相关判据还要求两数分别与其算术导数的最大公约数相等。因而，一个对 A379240 **按正确定义成立**的反例会同时推翻猜想 2。反向蕴涵不成立。[A399369 原文](https://oeis.org/A399369) · [A379240 的等价表述与作者勘误](https://oeis.org/A379240)

## 对原论文与源代码的核对

arXiv:2608.11941 最新仍是 2026-08-13 的 v2。Adamczewski 在附录 A 第 19 页给出的两个整数是 56 与 60，声称对应的三元组都为 $(92,4,2)$。复核发现，第三项的 Lean 定义枚举满足 $a^a\mid n$ 的正整数 $a$ 并计数。这一实现确实在两处都得到 2。OEIS A376418 的真正定义是 $D(n)=n-R(n)$，其中 $R(n)$ 把按素数基数进位后的指数还原为整数。两者算术导数和最大公约数相同，真正的第三项则如下。[版本历史](https://arxiv.org/abs/2608.11941v2) · [原论文第 19 页](https://arxiv.org/pdf/2608.11941v2#page=19) · [基准 Lean 定义第 35–37 行](https://github.com/epoch-research/LeanOpenProblems/blob/6d71225ff2a3793a48d85b46c8c329d6046c473d/apn/data/oeis/Isolated/A379240_conjecture_equality.lean#L35) · [OEIS A376418](https://oeis.org/A376418)

| $n$ | 素因子分解 | 将两个 2 进位成一个 3 后的 $R(n)$ | $n-R(n)$ |
|---:|---|---:|---:|
| 56 | $2^3\cdot7$ | $2\cdot3\cdot7=42$ | 14 |
| 60 | $2^2\cdot3\cdot5$ | $3^2\cdot5=45$ | 15 |

数字 14 和 15 也直接出现在 A376418 的官方数据前缀。检查 Epoch 结果仓库里四份针对 A379240 的 `Submission/Spec.lean`，四份都采用了上述计数定义并处理 56、60。它们未给出原进位差碰撞。A399369 项目的新见证也没有连带推翻 A379240：将两个最大公约数分别除以 $241^{66}$ 后，较小参数一侧为 1024，较大参数一侧为 4。[固定版本的 A376418 数据](https://github.com/oeis/oeisdata/blob/892a05dd4941ae76caee5906ea33ceedf3389b1d/seq/A376/A376418.seq) · [Epoch 的一份完整提交](https://github.com/epoch-research/LeanOpenProblems-results/blob/cbb7cb657f24157d9ebb7640ec50bd35bad78ad8/runs/oeis-full-50usd-oai-jajpvieznaevpoyg/A379240_conjecture_equality/Submission/Spec.lean)

## 其他可能构成先例的记录

- 查看 A399369 的 18 项历史修订、A399370 的 11 项以及 A379240 的 26 项。A399370 指定每个 $k$ 的最大 $j$，对应 A399369 猜想 1 的选择规则。A399369 猜想 2 允许满足条件的任一较小 $j$。历史中可以查到提出这两个断言的过程，以及针对上述论文的更正，未见另一组经过原定义验证的反例。[A399369 修订](https://oeis.org/history?seq=A399369) · [A399370 修订](https://oeis.org/history?seq=A399370) · [A379240 修订](https://oeis.org/history?seq=A379240)
- TrureTuring 的独立筛选记录明确采用正进位差和原始算术导数。作者报告枚举至 100,000，仅发现 $(k,j)=(28,16)$，并将项目标为 `open`、`note-only`。这项先行计算验证了搜索范围内的行为，不能排除更大的见证。[固定版本筛选报告，A399369 段](https://github.com/the-omega-institute/trureturing/blob/941008c61d5dfccd7ad1e65f9f17c283be8932f4/Library/Words/oeis2026triage0911.md#L159-L161)
- 在 OpenAlex 的 `fulltext.search` 接口逐个查询。A399369、A399370 及组合短语 `"primorial base" "arithmetic derivative"` 各为零条。A379240 与 A376418 各返回一条，均为上述 Adamczewski 论文。[OpenAlex 全文查 A379240](https://api.openalex.org/works?filter=fulltext.search%3AA379240) · [全文查 A399369](https://api.openalex.org/works?filter=fulltext.search%3AA399369)
- GitHub 已授权默认分支代码检索 `"A399369" "A376418"`、`"A399370" "A003415"` 都只命中 TrureTuring 的筛选段。以 A379240 与 A376418 组合检索，主要命中 Epoch 的定义与上述多次提交。限定 Google DeepMind formal-conjectures 仓库分别查 A379240 与 A399369 均无结果；限定 Epoch 结果库查 A399369 也无结果。另查 `"A379240" "counterexample"`，其中一个看似独立的数学档案实际仅在 SHA-256 字串中包含编号，另一份 CSV 只是评测题目清单。[GitHub 检索](https://github.com/search?q=%22A399369%22+%22A376418%22&type=code) · [DeepMind 仓库](https://github.com/google-deepmind/formal-conjectures)

此次复核未发现此前在正确的 A376418 定义下完成的第二组正差碰撞。该判断限于查过的公开版本与可检索范围。
