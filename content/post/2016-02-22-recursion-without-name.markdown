---
categories:
- 理解计算机
date: 2016-02-22 21:31:11
tags:
- Lambda
- Lisp
title: 如何实现一个没有名字的递归函数
---

[递归](https://en.wikipedia.org/wiki/Recursion_%28computer_science%29) 作为计算机科学中很重要的一个概念，应用范围非常广泛。比较重要的数据结构，像树、图，本身就是递归定义的。
比较常见的递归算法有`阶乘`、`斐波那契数`等，它们都是在定义函数的同时又引用本身，对于初学者来说也比较好理解，但是如果你对编程语言，特别是函数式语言，有所研究，可能就会有下面的疑问：

> 一个函数在还没有定义完整时，为什么能够直接调用的呢？

这篇文章主要是解答上面这个问题。阅读下面的内容，你需要有些函数式编程的经验，为了保证你能够比较愉快的阅读本文，你至少能看懂`前缀表达式`。相信读完本文后，你将会对编程语言有一全新的认识。
本文所有演示代码有`Scheme`、`JS`两个版本。

## 问题描述

下面的讲解以`阶乘`为例子：
```
; Scheme
(define (FACT n)
  (if (= n 0)
    1
    (* n (FACT (- n 1)))))

; JS
var FACT = function(n) {
    if (n == 0) {
        return 1;
    } else {
        return n * FACT(n-1);
    }
}    
```
上面的阶乘算法比较直观，这里就不再进行解释了。重申下我们要探究的问题

> `FACT` 这个函数为什么在没有被定义完整时，就可以调用了呢？

## 问题分析

解决一个新问题，常见的做法就是类比之前解决的问题。我们要解决的这个问题和求解下面的等式很类似：
```
    2x = x + 1
```
在等号两边都出现了`x`，要想解决这个问题，最简单的方式就是将等号右边的`x`移到左边即可。这样就知道`x`是什么值了。

但是我们的问题比这个要复杂些了，因为我们这里需要用`if`、`n`、`*`、`-`这四个符号来表示`FACT`，可以这么类比是因为一个程序无非就是通过一些具有特定语意的符号（编程语言规定）构成的。

再进一步思考，`FACT` 需要用四个符号来表示，这和我们求解多元方程组的解不是很像嘛：
```
    x + y = 3
    x - y = 1
```
为了求解上面方程组，一般可以转为下面的形式：
```
    x = 3 - y
    y = x - 1
```
即
```
    (x, y) = T (x, y)
```
其中的`T`为一个转换，在线性代数其实就是个矩阵，根据矩阵`T`的一些性质，我们可以判定`(x ,y)`是否有解，以及解的个数。

对比此，我们可以把问题转化为下面的形式：
```
    FACT = F (FACT)
```
上面的`F`为某种转换，在这里其实就是个需要一个函数作为参数并且返回一个函数的函数。如果存在这么个`F`函数，那么我们就可以通过求解`F`的[不动点](https://zh.wikipedia.org/wiki/%E4%B8%8D%E5%8A%A8%E7%82%B9)来求出`FACT`了。

但这里有个问题，即便我们知道了`F`的存在，我们也无法确定其是否存在不动点，以及如果存在，不动点的个数又是多少？

计算机科学并不像数学领域有那么多可以套用的定理。

## 寻找转换函数 F

证明`F`是否存在是个比较难的问题，不在本文的讨论范围内，这涉及到[Denotational semantics](https://en.wikipedia.org/wiki/Denotational_semantics)领域的知识，感兴趣的读者可以自己去网上查找相关资料。

这里直接给出`FACT`对应的函数`F`的定义：
```
; Scheme
(define F
  (lambda (g)
    (lambda (n)
      (if (= n 0)
        1
        (* n (g (- n 1)))))))

; JS
var F = function(g) {
    return function(n) {
        if (n == 0) {
            return 1;
        } else {
            return x * g(n-1);
        }
  }
}

```
可以看到，对比递归版本的`FACT`变动不大，就是把函数内`FACT`的调用换成了参数`g`而已，其实我们常见的递归算法都可以这么做。

## 寻找转换函数 F 的不动点

找到了转换函数`F`后，下一步就是确定其不动点了，而这个不动点就是我们最终想要的`FACT`。
```
    FACT = (F (F (F ...... (F FACT) ...... )))
```
假设我们已经知道了`FACT`非递归版本了，记为`g`，那么
```
E0 = (F g)      这时(E0 0) 对应 (FACT 0)得值，这时用不到 g
E1 = (F E0)     这时(E1 0)、(E1 1)分别对应(FACT 0)、(FACT 1)的值
E2 = (F E1)     这时(E2 0)、(E2 1)、(E2 2)分别对应(FACT 0)、(FACT 1)、(FACT 2)的值
.....
En = (F En-1)   这时....(En n)分别对应.... (FACT n)的值
```

可以看到，我们在求出`(FACT n)`时完全没有用到初始的`g`，换句话说就是`g`的取值不影响我们计算`(FACT n)`。
那么我们完全可以这么定义`FACT`：
```
    FACT = (F (F (F ...... (F 1) ...... )))
```
可惜，我们不能这么写，我们必须想个办法表示无穷。在函数式编程中，最简单的无穷循环是：

```
; Scheme
((lambda (x) (x x))
  (lambda (x) (x x)))

; JS
(function (x) {
    return x(x);
})(function(x) {
    return x(x);
});
```

基于此，我们就得到函数式编程中一重要概念 [Y 算子](https://zh.wikipedia.org/wiki/%E4%B8%8D%E5%8A%A8%E7%82%B9%E7%BB%84%E5%90%88%E5%AD%90)，关于 Y 算子的严格推导，可以在参考这篇文章 [The Y combinator (Slight Return)](http://mvanier.livejournal.com/2897.html)，这里直接给出：

```
; Scheme
(define Y
  (lambda (f)
    ((lambda (x) (f (x x))
      (lambda (x) (f (x x)))))))

(define FACT (Y F))

; JS
var Y = function(f) {
    return (function(x) {
        return f(x(x));
    })(function(x) {
        return f(x(x));
    });
}
var FACT = Y(F);
```

这样我们就得到的`FACT`了，但这里得到的`FACT`并不能在`Scheme`或`JS`解释器中运行，因为就像上面说的，这其实是个死循环，如果你把上面代码拷贝到解释器中运行，一般可以得到下面的错：
```
RangeError: Maximum call stack size exceeded
```

## 正则序 vs. 应用序

为了得到能够在`Scheme`或`JS`解释器中可以运行的代码，这里需要解释复合函数在调用时传入参数的两种求值策略：
- 正则序（Normal Order），完全展开而后归约求值。惰性求值的语言采用这种顺序。
- 应用序（Applicative Order），先对参数求值而后应用。我们常用的大部分语言都采用应用序。

举个简单的例子：
```
; Scheme
(define (p)
  (p))

(define (test x y)
  (if (= x 0)
    0
    y))
(test 0 (p))

; JS
var p = function() {
    return (p);
}
var test = function(x, y) {
    if(x == 0) {
        return 0;
    } else {
        return y;
    }
}
test(0, (p));
```
上面这个例子，采用应用序的语言会产生死循环；而采用正则序的语言可以正常返回`0`，因为`test`的第二个参数只有在`x`不等于0时才会去求值。

我们上面给出的`var FACT = Y(F)`在正则序的语言中是可行的，因为`Y(F)`中的返回值只有在真正需要时才进行求值，而在`F`中，`n`等于0时是不需要对`g(n-1)`进行求值的，所以这时`Y(F)(5)`就能够正常返回`120`了。

> 如果你觉得上面这段话很绕，一时不能理解，这样很正常，我也是花了很久才弄明白，你可以多找些惰性求值的文章看看。

为了能够得出在应用序语言可用的`FACT`，我们需要对上面的`Y`做进一步处理。思路也很简单，为了不立即求值表达式，我们可以在其外部包一层函数，假设这里有个表达式`p`：
```
; Scheme
(define lazy_p
  (lambda () p))

; JS
var lazy_p = function() { return p; }
```
这时如果想得到`p`的值，就需要`(lazy_p)`才可以得到了。基于这个原理，下面给出最终版本的`Y 算子`：
```
; Scheme
(define Y
  (lambda (f)
    ((lambda (x) (x x))
     (lambda (x) (f (lambda (y) ((x x) y)))))))

(define FACT (Y F))
(FACT 5)   ;===> 120

; JS
 var Y = function(f) {
     return function(x) {
         return x(x)
     }(function (x) {
         return f(function(y) {
             return x(x)(y)
         })
     })
 }
 var FACT = Y(F)
 FACT(5)   ;===> 120
```

好了，到现在为止，我们已经得到了可以在`Scheme`或`JS`解释器中运行`FACT`了，可以看到，这里面没有使用函数名也实现了递归方式求阶乘。
本文一开始给出的`FACT`版本在解释器内部也会转换为这种形式，这也就解释了本文所提出的问题。

## 总结

本文大部分内容由 SICP 4.1 小节延伸而来，写的相对比较粗糙，很多点都没有展开讲的原因是我自己也还没理解透彻，为了不误导大家，所以这里就省略了（后面理解的更深刻后再来填坑😊）。希望感兴趣的读者能够自己去搜索相应知识点，相信肯定会受益匪浅。

最后，希望这篇文章对大家理解编程语言有一些帮助。有什么不对的地方请留言指出。
