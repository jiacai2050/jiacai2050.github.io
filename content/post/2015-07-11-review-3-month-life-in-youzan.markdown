---
categories:
- 热爱生活
date: 2015-07-11 14:36:17
title: 回顾来有赞的这三个月
---

好久没写博客了，上一篇还是写在三个月前，当时应该是在有赞客满毕业后，现在转正也将近半个多月了。本来想的是每个月至少一篇原创技术文章的，没想到坚持还没一年就“食言”了。

## 时间都去哪了
<div>
<iframe frameborder="no" border="0" marginwidth="0" marginheight="0" width=330 height=86 src="http://music.163.com/outchain/player?type=2&id=28126661&auto=0&height=66"></iframe>
</div>
没坚持写博客最直接也最根本的原因就是：懒。

最近几天杭州有[台风登陆](http://nb.ifeng.com/zjxw/detail_2015_07/10/4093975_0.shtml)，周六不用去公司了，公司领导层也决定今后实行双休，我今天也趁此机会好好反思一下最近三个月做的事情，看看时间都去哪了。

## 回顾反思

### 忙工作

新到一家公司，从熟悉业务到最终能够干活，成本还是不小的，尤其是一家创业型公司，一般都是身兼数职，而且我自身定位一开始也不是很清晰，有种忙这忙那的感觉，最后的成果不是很大。用得到知识基本上还是在ucloud学的，翻翻之前的日报（公司要求新人写日报的效果还是大大有益的，最起码我现在回顾的时候有据可循），觉得下面这些东西算是新学到的：

1. 通过调研hadoop streaming任务慢，学习strace命令查看进程到底在做什么。
2. 为了开发hive服务，学习hive权限验证，可以具体到某个表。
3. 为优化hive任务，学习研究hiveQL如何转为mapreduce，尝试explain 一些语句。
4. 为了搭建日志收集系统，学习flume使用方式，不过到目前为止也还是没用的。
5. 日常Hadoop维护，这个包含的东西比较杂乱，因为一个分布式的环境，出了一个问题，可能的原因实在是太多了，从服务本身的问题到机器的问题。其次就是编写各种shell脚本，说实话到现在我觉得写shell也不是十分得心应手，对于一些命令如sed、awk、ps、iftop、find、date等还只是简单的入门级别，写一个脚本有时需要较多的时间。
6. 熟悉python

最近日报不怎么写了，开始写半周报。现在想想一天能干的事好有限，我最近早上醒来的时候，会想一下：我到底想要什么？我的人生目标是什么？今天我该如何去做才能离目标越来越近？张爱玲好像有句话：“出名要趁早”，我不知道是不是我太急功近利了，以至于乱了手脚。我一直能想着为Hadoop社区贡献patch，但是我觉得现在我对他的了解，和之前也差不多，三个月的时间，在这方面貌似只是原地打转。记得之前看过耗子叔写的文章，说他在职业生涯早期通过不断面试来提高自己，我也效仿了下，现在还记得当时人家问我，我回答的不好的问题：

1. 你在日常运维Hadoop时，出现过哪些问题？如何解决的？现在系统的瓶颈是什么？如何解决？
2. 在运行Hadoop任务时，如何出行某些问题特别慢？你会如何排查问题？
3. 有没有遇到过这样的场景：当正在上传一个文件到hdfs上时，另一个程序开始读这个文件，这时会有什么问题？
4. hdfs文件是怎么存储的？有没有用过Arvo？

对于前两个问题，应该属于考察解决问题的思路的，看看你在遇到问题时，能不能保持大脑清晰，有个清晰的方案来排查解决问题。当时我回答道，CPU是系统瓶颈，IO不是，但是当人家在顺着问下去时，我就不能够很好的回答了。其实这个问题就说明了我分析问题的能力不够，遇到问题后没有打破沙锅问到底的精神，经常性就不了了之了。想想前两天出现的resourcemanager假死的情况，我好像也是没什么定论。
第三个问题应该算是看看Hadoop使用经验丰富与否，是否处理过一些不太正常的情况。
最后一个问题应该算是对Hadoop生态系统的考察，也可以说是系统架构的考虑。说实话这个我是真不清楚，之前Hadoop集群只是搭着玩玩，从来没想过如何一个集群保证一年7*24不间断正常运行，如何发挥系统的最佳性能，经过这个问题还是有帮助，最起码现在开始考虑如何处理小文件问题？以什么格式存储文件，文本、二进制还是压缩格式？集群在什么情况下可能崩溃？

### [SICP](https://github.com/jiacai2050/sicp)

当时我能来有赞，也是因为这本书。花了两个月时间算是把第一章给结束了。想想工作之余能够把这本书坚持下来，确实没想的那么简单，这次我们组内四个人，成立了个小组，周末能够讨论上几次，习题一道道过，遇到一些可以扩展的知识点，我们也是尽量发散思维，比如讲找零钱问题，我们扯到了动态规划、尾递归优化、过程执行轨迹的可视化等等，为了找出找零钱的迭代算法，我们讨论了好几次，正好这个周五把第一章所有内容＋习题都过完一遍了，我会抽时间把第一章的内容在总结次，到时候再好好说说找零钱问题，这里就不细说了。

我们这个学习小组看完第一章也是磕磕绊绊，中间还停了两周，刚开始几小节还可以，后来逐渐聚不齐了，要不就是谁有事或者工作忙，总之就是没能够进行下去，想想我今年年初的目标，看完三本书，这样算下来，能够完完整整的把SICP看完，也是不容易了。

后面再接再厉，把进度顶上去。

### 亲情、友情、爱情

这三个月家里发生的事也是蛮多的，五一的时候我姐姐结婚了。怎么说呢，觉得自从上中学后，和姐姐的交流就不多了，我们之间从来没问过各自的理想。姐姐大学毕业后，考过了老师、公务员、事业编，结果也不怎么顺利，一直在家里和我爸爸一起干，开了个淘宝店，最近年逼婚问题也是愈演愈烈，我记得妈妈给我说过姐姐因为这个还哭过，作为一个没什么经验的我，完全不能理解姐姐的心情。这次结婚了，算是对大家最好的交代，端午那天我姐生了个小男孩，在我看来好快，刚结婚没几个月就有小孩了，不过这也好，感觉一下子把好几年要干的事一下解决了。希望我姐姐等家庭稳定后再好好考，以我姐的实力，考个高中老师，绝对没有问题。

至于我自己，我也只能说是随缘了，感情这东西，太深奥。想想现在的处境，也确实不适合找，有个老同学还能谈谈，要是说从头开始的，我觉得就别浪费大家的时间了。这东西也挺耽误时间的，在看网上一些暖文的时候，也挺像有个人能一起谈人生、谈理想，一起奋斗的。

## 总结

革命尚未胜利，同志仍需努力。

我觉得现在的问题一方面是把零碎时间利用好，不要小看这些时间，想想有时候看个10分钟视频，刷会微博，再因为某某好玩的东西，东点点西看看的，时间就这么溜走了。

另一方面就是控制好自己欲望，什么事情都不是一步就能够成功的，慢慢来，稳扎稳打，夯实基础。
