# A399369 猜想 2 查重记录

核查于 2026-11-25。Antti Karttunen 于 2026-08-27 提交 A399369；第 18 次公开修订日期为 08-31。核对了 18 次修订、作者附的 PARI 程序和关联序列。猜想 2 位于主条目的第二条评论。它允许任意满足条件的较小整数 $j$；另一个猜想以 A399370 选择特定的 $j$。已查资料中没有找到猜想 2 已有完整证明、有效反例或对应的完成形式化。[主条目](https://oeis.org/A399369) · [固定源文本](https://github.com/oeis/oeisdata/blob/be2f360122f661bddebad22b15440935d21ac598/seq/A399/A399369.seq) · [修订 9–18](https://oeis.org/history?seq=A399369) · [修订 1–8](https://oeis.org/history?seq=A399369&start=10) · [A399370](https://oeis.org/A399370)

## 相关反例的复核

Tom Adamczewski 的 *OEIS Open: How many conjectures can language models turn into theorems?*（arXiv:2608.11941v2，2026-08-13）早于 A399369。附录 A 对相关的 A379240 提出 $(56,60)$。其第三个不变量在两个输入上都按 2 计算。根据 A376418 的实际定义，$R(56)=42$，$R(60)=45$，故两个差分别为 14、15。原作者后来也在 A379240 条目中说明了误读。这篇论文没有给出满足 A399369 猜想 2 条件的反例。[预印本附录 A](https://arxiv.org/html/2608.11941v2#A1) · [作者在 A379240 的说明](https://oeis.org/A379240)

A376418 的定义先计算完全可加的素数阶乘对数，再将各进位数字用作连续素数的指数，最后从原数减去所得数。A392878、A392879 和目标条目程序还提供了从最小溢出素数开始直接进位的算法。核查时分别按两条路径计算，得到相同的值。[差值](https://oeis.org/A376418) · [对数](https://oeis.org/A276085) · [指数](https://oeis.org/A276086) · [单步进位](https://oeis.org/A392879) · [稳定结果](https://oeis.org/A392878) · [算术导数](https://oeis.org/A003415)

## 平台与检索词

| 来源 | 检索与观察 |
|---|---|
| Google Scholar | 桌面浏览器查询 `"A399369" "arithmetic derivative"`，页面报告没有匹配文章。独立脚本查询题号或 `"primorial" "arithmetic derivative" collision` 时遇到人机验证。[Scholar 查询](https://scholar.google.com/scholar?q=%22A399369%22+%22arithmetic+derivative%22) |
| arXiv、OpenAlex、DataCite | arXiv all-fields 分别查询 `A399369`、`"primorial" "arithmetic derivative"` 均无条目。OpenAlex 两次主题检索、DataCite 题号检索均返回 0。原猜想的公开载体是 OEIS，目前没有原题 arXiv 编号。[arXiv 查询](https://arxiv.org/search/?searchtype=all&query=A399369) · [OpenAlex 查询](https://api.openalex.org/works?search=A399369) · [DataCite 查询](https://api.datacite.org/dois?query=A399369) |
| 前向引文 | OpenAlex 的相关 Adamczewski 论文记录报告 7 条引文，当天的反向引文过滤列表实际有 8 项；另查 Semantic Scholar 反向引文。按题名筛选后复核了近期 OEIS 研究汇编。返回列表内没有报告本题或这组见证的成果。Semantic Scholar 的单独题号搜索受 429 限流。[OpenAlex 反向引文](https://api.openalex.org/works?filter=cites:W7202344564) · [Semantic Scholar 接口](https://api.semanticscholar.org/graph/v1/paper/ARXIV:2608.11941/citations?fields=title,externalIds&limit=100) · [Athanor 汇编](https://doi.org/10.5281/zenodo.24145039) |
| MathOverflow、Math Stack Exchange | 公开站内 API 以题号查询均无匹配。另使用 `primorial base normalization`、`primorial log exp`、`arithmetic derivative`、`collision`、`same gap` 和 `28 16` 的组合搜索公开网页。[MathOverflow 查询](https://api.stackexchange.com/2.3/search/advanced?site=mathoverflow&q=A399369) · [Math Stack Exchange 查询](https://api.stackexchange.com/2.3/search/advanced?site=math&q=A399369) |
| GitHub | 题号在仓库 README 检索和提交信息检索中均返回 0。Issues/PR 的两项命中是无关的 Docker 更新。`"A376418" "A003415"` 的 Issues/PR 查询无命中。未认证的全站代码 API 返回 401；补查 GitHub 定域网页搜索以及相关项目的公开目录。[仓库查询](https://api.github.com/search/repositories?q=A399369+in:readme) · [Issues/PR 查询](https://api.github.com/search/issues?q=A399369) |
| Lean Zulip、Mathlib | 在公开 Zulip 归档的网页索引检索题号、`primorial` 和 `arithmetic derivative`。本机 Mathlib 固定快照 `fc4f59e5` 中检索 `A399369`、`A376418` 和 `primorialLog` 均无本题声明。素数、分解和 primorial 为已有基础工具。[公开归档](https://leanprover-community.github.io/archive/) · [Mathlib 的 primorial 定义](https://github.com/leanprover-community/mathlib4/blob/v4.36.0/Mathlib/NumberTheory/Primorial.lean) |
| Figshare、Zenodo 与等价见证 | Figshare 原生搜索题号无结果。Zenodo 直接查询受 HTTP 403 限制；另查 DataCite、OpenAlex 及公开研究网页，采用题号、关联序列编号，以及 `3916 1024 241`、`primorial difference`、`prime carry arithmetic derivative collision` 等关键词。没有发现此有限证书。[Figshare 查询端点](https://api.figshare.com/v2/articles/search) |

这些检索结果说明在所列日期、渠道及术语范围内没有发现已公开的相同解答。数据库延迟、其他记号或未收录稿件仍可能影响优先权判断。

## 2026-11-25 发布后的独立复核

直接访问 OEIS 的内部格式页面，修订号仍为 #18（8 月 31 日），COMMENTS 保留 Karttunen 的猜想 1 和猜想 2。GitHub 再查 `"A399369" in:readme` 只返回本项目；代码组合查询 `"A399369" "A376418"` 命中 TrureTuring 先前的有限筛查。该报告在 $k\le100000$ 时仅找到 $(j,k)=(16,28)$。本项目的公开提交给出的是猜想 2 的另一组见证，现有证书没有确定 A399370 选取的最大 $j$。[OEIS 修订 #18](https://oeis.org/A399369/internal) · [先前的有限筛查](https://github.com/the-omega-institute/trureturing/blob/bfe530ad72468226ec6cad375e2d8840cc517f92/Library/Words/oeis2026triage0911.md#L159-L161) · [本项目的反例提交](https://github.com/257-1807/oeis-a399369/commit/5ebeb1175a7c81d36f5da230edc4114f975cbd66)

独立复核下载了两个 OEIS 官方数表。对每个 $1\le n\le4000$，逐次进位和混合进制编解码两种算法算出的进位差都与 A376418 相符。由素因子分解算出的算术导数也与 A003415 全部相符。另行重跑仓库自带的离线脚本，在限定为 4000 的搜索中重新得到核心 $(1024,3916)$ 和尺度 $241^{67}$，随后核验了缩放见证的两个不变量。下载文件的 SHA-256 分别为 `ba53cadda811e206ba4ee20888cbae2314ceefe13c5744d6c1dcd8962e06e552`（A376418）与 `c2b8a9271a472a34b1eca8eb1a7f6f58e9bb2470026f85542b072821e6895588`（A003415）。[A376418 数据表](https://oeis.org/A376418/b376418.txt) · [A003415 数据表](https://oeis.org/A003415/b003415.txt) · [仓库离线脚本](../scripts/check_witness.py)
