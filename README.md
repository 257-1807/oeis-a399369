# OEIS A399369：算术导数与素数进位差的一组新碰撞

Antti Karttunen 的猜想 2 认为，在指定范围内，只有 $(16,28)$ 同时具有相同的算术导数和相同的素数进位差。取

$$c=241^{67},\qquad j=1024c,\qquad k=3916c.$$

这是另一组满足全部条件的整数。它们的共同进位差为 $979c$，共同算术导数为 $1\,302\,528\cdot241^{66}$。Lean 4 从原始混合进位定义计算并验证了两者，因此该唯一性猜想为假。[反例与主定理](PrimeCarry/Result.lean) · [实际公理输出](audit/axioms.log)

## 原题

Karttunen 于 2026 年 8 月 27 日提出 OEIS A399369。该公开条目描述了满足以下性质的正整数 $k$：有素数 $p$ 使 $p^p\mid k$，并有更小的正整数 $j$ 使 A376418 在两处取值相同。原题编号为 **Conjecture 2**，没有独立的 arXiv 编号。其唯一性断言逐字为

> Conjecture 2: k = 28, j = 16 is the only such pair that A376418(k) = A376418(j) and A003415(k) = A003415(j).

[OEIS 原条目](https://oeis.org/A399369) · [固定版本中的猜想与上下文](https://github.com/oeis/oeisdata/blob/be2f360122f661bddebad22b15440935d21ac598/seq/A399/A399369.seq#L7)

## 两个不变量

**算术导数。** 写 $D(n)=\mathrm{A003415}(n)$，约定 $D(0)=D(1)=0$，对素数 $p$ 有 $D(p)=1$，并满足乘法法则 $D(ab)=aD(b)+bD(a)$。若 $n=\prod p^{e_p}>0$，则 $D(n)=\sum_p e_p(n/p)$。Lean 证明了这个按素因子计数的函数满足原定义，且是满足这些规则的唯一函数。[A003415](https://oeis.org/A003415) · [导数定义与唯一性](PrimeCarry/Derivative.lean)

**素数进位差。** 写 $G(n)=\mathrm{A376418}(n)=n-R(n)$。为求 $R(n)$，把素因子指数 $e_p$ 放在以 $p$ 为进制的数位上。该位置满 $p$ 时向下一个素数进一位。例如 $2^2$ 进成一个 $3$，$3^3$ 进成一个 $5$。所有指数都小于各自的进制后，再以这些指数作素因子乘积便得到 $R(n)$。

原作者也直接定义 $R=\mathrm{A276086}\circ\mathrm{A276085}$。令 $W(p)$ 为所有小于 $p$ 的素数之积。先编码为 $L(n)=\sum_p e_p W(p)$，再依次以 $2,3,5,\ldots$ 取余和整除，用所得余数作为素因子指数。Lean 采用这个复合定义，Python 则分别计算复合定义和逐次进位的结果。[A376418](https://oeis.org/A376418) · [A392878 的定义与两套原始算法](https://oeis.org/A392878) · [Lean 编码与解码](PrimeCarry/Reduction.lean)

## 反例是怎样构造的

先找一对进位差已相等的小整数，再乘同一个数调整算术导数。原始两个整数的计算为

| $u$ | 因子分解 | $R(u)$ | $u-R(u)$ | $D(u)$ |
|---:|---|---:|---:|---:|
| $1024$ | $2^{10}$ | $3^2\cdot5=45$ | $979$ | $5120$ |
| $3916$ | $2^2\cdot11\cdot89$ | $3\cdot11\cdot89=2937$ | $979$ | $4316$ |

第一行的十个因子 2 进为五个因子 3，再进为两个因子 3 和一个因子 5。第二行只有一组 $2^2$ 需要进位。若把两行都乘 $c$，由乘法法则，两边的算术导数恰在下式成立时相等：

$$
\frac{D(c)}c=\frac{5120-4316}{3916-1024}=\frac{67}{241}.
$$

因为 241 是素数，取 $c=241^{67}$ 即得 $D(c)=67\cdot241^{66}$。又因为 $67<241$，而小整数部分的进位均止于更低的数位，添上这 67 个因子 241 对两边的低位进位没有影响。于是 $R(j)=45c$、$R(k)=2937c$。具体地，

$$
G(j)=(1024-45)c=(3916-2937)c=G(k)=979c>0.
$$

算术导数的两边分别为 $(5120\cdot241+1024\cdot67)241^{66}$ 和 $(4316\cdot241+3916\cdot67)241^{66}$，括号内均为 $1\,302\,528$。最后，$0<16<j<k$，且 $2^2\mid k$，所以 $k$ 满足原条目的素数幂条件，$j$ 是符合要求的更小正整数。[两个编码值的证明](PrimeCarry/Encoding.lean) · [两条解码证书](PrimeCarry/Certificate.lean)

本结果解决猜想 2。猜想 1 对 $j$ 有额外的最大性条件，本项目没有核定该最大性。A379240 还比较 $\gcd(n,D(n))$；对本见证，两值分别为 $1024\cdot241^{66}$ 和 $4\cdot241^{66}$。这组见证直接反驳的是上述双重相等的唯一性断言。[关联命题与先例核对](audit/related-work.md)

## 忠实性对照

| 原数学对象 | Lean 4 中的对象 | 对应关系 |
|---|---|---|
| 任意正整数 $j<k$，有 $p^p\mid k$ | `GapPair` | 直接量化自然数与素数，要求 $0<j<k$。连同同差条件，保证 $k$ 确为原序列的一项。 |
| A003415 | `derivative`、`derivative_unique` | 重复的素因子逐个贡献 $n/p$。乘法法则和素数初值已证。 |
| A276085、A276086 | `primorialLog`、`primorialExp` | `weight_eq_primorial` 核对数位权重；`nextPrime_spec` 核对相邻素数；`decode` 是对非负编码的终止递归。 |
| A376418 | `gap n = n - reduced n` | `reduced` 是上述两个函数的复合；对见证，实际验证了两项正规化结果和严格为正的差。 |
| 无界唯一性断言 | `Conjecture2`、`refute_A399369_conjecture2` | 原断言量化全部合格数对。有限证书只用于精确核验反例。`decodePrefix_eq` 证明了证书计算与原递归一致。 |

## 查重与选择

2026-11-25 核查了 OEIS 正文及历史修订、arXiv 与引用、Google Scholar、GitHub、Lean Zulip、MathOverflow、Mathlib 和相关研究档案。精确检索词包括 `A399369` 与 `arithmetic derivative`、`A376418`、`primorial base`、`counterexample` 的组合。与本题最接近的 *OEIS Open* 附录使用了另一函数处理 A379240。其数对 56、60 按本题真实定义所得进位差分别为 14、15。已核查材料中没有发现针对 A399369 猜想 2 的完整先行反例；检索不能确定全球优先权。[逐平台检索](audit/prior-art.md) · [原始论文、代码与后续筛查](audit/related-work.md)

选题时还检查了 Václav Kotesovec 的 OEIS A400585 求和渐近猜想和 Chai Wah Wu 的 A399755 广义 Pell 解类猜想，两者均有公开完整证明，遂排除。A399369 入选的原因是，只需一组数就能否定其全称量词，而两个不变量可以用独立的整数算法精确核验。[A400585 已有证明](https://the-omega-institute.github.io/trureturing-mdbook/Problems/oeis-a400585-odd-cofactor-asymptotic.html) · [A399755 已有证明](https://the-omega-institute.github.io/trureturing-mdbook/Problems/oeis-a399755-pell-class-successor.html)

## 复现

安装 Elan 后在仓库根目录运行。项目锁定 Lean 4.36.0 和 Mathlib v4.36.0，全部依赖提交保存在 `lake-manifest.json`。[Elan 安装说明](https://github.com/leanprover/elan)

```sh
lake exe cache get Mathlib.Tactic Mathlib.Data.Nat.Factorization.Induction Mathlib.NumberTheory.Primorial Mathlib.NumberTheory.Bertrand
lake build
lake --wfail build
lake env lean -DwarningAsError=true PrimeCarry.lean
for m in Derivative Reduction Encoding Certificate Result; do
  lake env leanchecker --verbose "PrimeCarry.$m" || exit 1
done
python3 scripts/check_witness.py
```

Python 先在不超过 4000 的正整数中寻找同差的小整数对，再由算术导数确定缩放因子，并用两种进位算法分别复核最终结果。[实验脚本](scripts/check_witness.py) · [实际输出](audit/numeric.log)

严格构建零错误、零警告，含证明的模块均逐个通过内核重放。项目源码没有 `sorry`、`admit` 或自定义公理。根文件末尾运行 `#print axioms` 的主定理输出为

```text
'PrimeCarry.refute_A399369_conjecture2' depends on axioms: [propext, Classical.choice, Quot.sound]
```

[构建日志](audit/build.log) · [完整公理清单](audit/axioms.log) · [内核重放日志](audit/kernel-replay.log)

本项目原创代码和说明采用 Apache-2.0 许可证。OEIS 引文保留原作者和来源。[许可证](LICENSE)
