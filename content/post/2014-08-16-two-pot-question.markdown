---
categories:
- 理解计算机
date: 2014-08-16 13:04:37 +0800
tags:
- 算法
title: 两个水壶问题
---

问题描述是这样的：
假设有一个池塘，里面有无穷多的水。现有2个空水壶a，b，其容积分别为6升和5升。如何只用这2个水壶从池塘里取得3升的水**（最后，这三升水，在其中一个壶里）。

这个问题不难，大家自己完成可以推理出来，但是如何让计算机程序自己推算出来呢？一般而言，想把计算机理解这些自然问题，需要某些数学理论作为支撑，这里突然想起前些天看[码农13期Lisp之父约翰•麦卡锡——不走寻常路的常识逻辑学家](http://www.ituring.com.cn/article/117596)的一段关于用逻辑描述事实的话：
> 利用逻辑表达世界中的事实的进展一直都很缓慢。亚里士多德没有发明形式体系。莱布尼茨没有发明命题演算，尽管这种形式体系比他和牛顿同时发明的微积分更加简单。乔治·布尔发明了命题演算，却没有发明谓词演算。戈特洛布·弗雷格发明了谓词演算，但从未尝试过将非单调推理形式化。我想我们人类明白，要明确地表征我们思维过程中的各种事实，表面来看似乎简单，实际上是很困难的。

我觉得大家可以在看完我这篇文章后去完整的看看这篇文章。

言归正转，接着说咱们的水壶问题。

看到这种类似的题目，我就特想知道，题目要求我们取得3升水，为什么不是2升或4升，这其中是不是说有些值取不到，换一个通俗说法，给了容量为a，b的两个水壶，能够取出（测量出）的水的体积可以是多少？是不是有个公式可以套用？

我觉得这种对于题目本身的反问对于理解题目本身十分有帮助，它能够有助于你看出题目到底想考查那部分数学知识，我们目前水平解决的问题都是有据可寻的，也就是说肯定是考查的对某一个或多个知识点的理解与运用（当然，牛人们遇到的问题可能需要自己创造新理论）。

把我上面的猜测用数学语言描述出来就是
> 5x+6y=n   #我们这个题目n=3

看到这里，如果你的数学还算可以，应该会想到数论中下的的定理：

> 如果gcd(x,y) = 1  #gcd函数用以计算两个数的最大公约数greatest common divisor简写
> 那么肯定有整数（正的或负的）m与n，使得
> mx + ny = 1

大家从直观上也很好理解这个定理，两个数的线性组合肯定是能凑出它们的最大公约数的呀。

也就是说，如果这里的a，b两个水壶的体积互质，可以测量出的水的范围x是

> 1<=x<=max(a,b)

很多题目出的时候（比如本题），一般也都会让a，b互质，因为这样更具有一般性。

好了，现在我们知道在给定水壶容量为5升与6升的前提下，为什么能够测量出体积为3升的水了，下面就是如何如何操作了，处于21世纪的我们是幸运的，因为这个问题早在2000多年前，就被欧几里得给解决了。没错就是[辗转相除法](http://zh.wikipedia.org/wiki/%E8%BE%97%E8%BD%AC%E7%9B%B8%E9%99%A4%E6%B3%95)。这个方法大家早就在中学阶段就直接接触了，但这个算法本身所蕴涵的东西远比课本上那些公式来的深刻。但为了描述，还是要用公式，

> gcd(a,b)=gcd(b,a-b) #这里假设a>b

上面这个就是辗转相除法的精髓，简洁(simple)巧妙(ingenious)，而这就是[优雅（elegant）](http://www.oxforddictionaries.com/us/definition/american_english/elegant?q=elegant)。

把辗转相除法运用到我们的两个水壶a（6升），b（5升）上，就是不断把a的水向b里面倒，具体操作如下：
1. 查看a，b壶中水的体积是否为目标t（我们这个题目中t=3升），如果是，停止运算，否则到2
2. 如果a壶空，就装满，否则，到3
3. 如果b壶满，就把水倒掉，否则到4
4. 尽可能多的从a壶向b壶倒水

重复递归执行步骤1-4即可得到最终的结果。
这样做可行，原因可以从两方面讲：

1. 因为a，b壶容量互质，所以在不断重复1-4时肯定会测量出体积为1升的水来（我们这里可以判断1升水第一次出现一定在a壶里，因为6-5=1,也就是说只需要进行一边1-4步骤，就能够得到1升水）
2. 为了得到我们的目标——3升水，我们从6-5=1这个算式分析，只要等号两边同时乘以3,就能得到我们的目标，所以说整个过程中，我们需要把空壶a加满3次，把装满水的b壶倒掉3次，就能得到结果。

我想分析到这里，你也肯定是大腿一拍，“原来这么简单，小学数学嘛”！

但其实我们到这里只是成功了一半，因为gcd(a,b)=gcd(b,a)，对应我们这个题，就是说a壶向b壶倒能得到最终3升水，b向a倒也能得到最终的3升水。

这个问题看似简单，但其实这涉及到我们对数字，负数一些本质上的理解，我这里有收藏的[Matrix67大神一个关于负数的视频](http://pan.baidu.com/s/1i321Tvn)，大家可以自行看之，Matrix67这么总结了一句：负数的真正涵义是把减法变为加法。好了到这里一切明朗了，我从新整理一遍。


> gcd(5,6)=gcd(5,5+(-6))=gcd(6,5)=gcd(6,6+(-5))

也就是说不管我们是从a向b倒水，还是从b向a倒水，其本质上进行的都是加法操作。如果你对这句话还是有疑问，想想Matrix67说的，什么样的动物有负数只腿吧。

通过上面的分析可以看到，我们解题的最终思路统一起来了，都是用的加法。再一次证明了优雅的含义——简洁巧妙。

理论部分算是说完了，下面编码实现了，我这里采用了Clojure语言，好久没用了，复习一下：
```
(defn gcd [a b]
  (if (zero? b)
    a
    (recur b (rem a b))))

(defn pot [target a-vol b-vol]
  (letfn [(solve [a-current-vol b-current-vol]
            (let [pour-volumn (min a-current-vol (- b-vol b-current-vol))] ;; 返回a壶能够向b壶倒入的最大值
              (println " -> " a-current-vol " " b-current-vol)
              (cond
                (or (= a-current-vol target) (= b-current-vol target)) (println "------- OK! ------")
                (= a-current-vol 0) (do (print "Fill A full") (solve a-vol b-current-vol))
                (= b-current-vol b-vol) (do (print "Empty pot B") (solve a-current-vol 0))
                :else (do (print "Pour A to B") (solve (- a-current-vol pour-volumn) (+ b-current-vol pour-volumn))))))]
    (cond
      (or (< a-vol 1) (< b-vol 1) (< target 0) (> target (max a-vol b-vol))) (print "Arg out of range")
      (not (= (rem target (gcd a-vol b-vol)) 0)) (print "No solve!")
      :else
      (do (print "Start with ") (solve 0 0)))))
```
下面是REPL中的调用结果：
```
user=> (pot 3 5 6)
Start with  ->  0   0
Fill A full ->  5   0
Pour A to B ->  0   5
Fill A full ->  5   5
Pour A to B ->  4   6
Empty pot B ->  4   0
Pour A to B ->  0   4
Fill A full ->  5   4
Pour A to B ->  3   6
------- OK! ------

user=> (pot 3 6 5)
Start with  ->  0   0
Fill A full ->  6   0
Pour A to B ->  1   5
Empty pot B ->  1   0
Pour A to B ->  0   1
Fill A full ->  6   1
Pour A to B ->  2   5
Empty pot B ->  2   0
Pour A to B ->  0   2
Fill A full ->  6   2
Pour A to B ->  3   5
------- OK! ------

```

题目来源：

[http://www.ituring.com.cn/article/117608](http://www.ituring.com.cn/article/117608)

PS：第一次写算法方面的总结，其实有些观点很早前就有了，但是一直存在于脑海中，现在写出来觉得不一定能够描述清楚，感觉很多地方写的有些罗嗦，应该是还没理解透，以后有了更深刻的理解再来修改吧。
