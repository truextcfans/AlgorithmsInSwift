//
//  InsertSort.swift
//  AlgorithmsInSwift
//
//  Created by xlzj on 2024/6/26.
//

import Foundation
import UIKit


class Sort {
    
}


extension Sort {
    func insertSort() {
        var array = [31, 41, 59, 26, 41, 58]
        for i in 1..<array.count {
            let key = array[i]
            var j = i - 1
            
            while j >= 0 && array[j] > key {
                array[j+1] = array[j]
                j = j - 1
            }
            array[j+1] = key
        }
        print(array)
    }
    
}

extension Sort {
    func selectionSort() {
        var array = [31, 41, 59, 26, 41, 58]
        /// 此处不需要循环到最后一个元素 因为每次循环都是寻找最小值 剩余的最后的元素一定是最大值
        for i in 0..<array.count-2 {
            var min = i
            for j in i+1..<array.count {
                if array[j] < array[min] {
                    min = j
                }
            }
            let tempt = array[i]
            array[i] = array[min]
            array[min] = tempt
            print(array)

        }
        print(array)
        
    }    
}
//
//### 如何修改几乎任意算法使其具有良好的最好情况运行时间
//
//在《算法导论》中，讨论了通过修改算法来改善其最好情况运行时间的概念。以下是理解和回答这个问题的结构化方法：
//
//#### 理解最好情况运行时间
//
//**最好情况运行时间**是指算法在最有利的输入情况下所需的最短时间。例如，对于一个排序算法，最有利的输入可能是已经排序的列表。
//
//#### 改善最好情况运行时间的策略
//
//1. **预处理检查**：
//   - 在执行主要算法之前，检查输入是否已经处于最有利的状态。
//   - 例如：对于排序算法，检查数组是否已经排序。如果是，则直接返回数组，实现 O(n) 的最好情况时间。
//
//2. **乐观算法**：
//   - 设计假设输入已经处于最佳状态，并包含验证这种假设的检查。
//   - 例如：在插入排序中，算法假设每个新元素都大于已排序部分的元素。如果这个假设成立，运行时间为 O(n)。
//
//3. **提前终止**：
//   - 在算法内部实现条件检测，如果可以提前结束，则提前终止。
//   - 例如：在搜索算法中，如果很早就找到了目标元素，算法可以提前终止，从而提供良好的最好情况运行时间。
//
//4. **自适应算法**：
//   - 修改算法，使其能动态适应不同类型的输入。
//   - 例如：Python 内置的排序函数使用 Timsort 算法，结合了插入排序和归并排序，根据输入数据的自然顺序来优化排序过程。
//
//#### 示例：改善排序算法的最好情况时间
//
//以冒泡排序为例。普通的冒泡排序算法在最好的情况下时间复杂度为 O(n^2)，但可以通过添加一个标志位来检测数组是否已经排序，从而实现 O(n) 的最好情况时间。
//
//**普通冒泡排序**：
//```python
//def bubble_sort(arr):
//    n = len(arr)
//    for i in range(n):
//        for j in range(0, n-i-1):
//            if arr[j] > arr[j+1]:
//                arr[j], arr[j+1] = arr[j+1], arr[j]
//```
//
//**优化后的冒泡排序**：
//```python
//def optimized_bubble_sort(arr):
//    n = len(arr)
//    for i in range(n):
//        swapped = False
//        for j in range(0, n-i-1):
//            if arr[j] > arr[j+1]:
//                arr[j], arr[j+1] = arr[j+1], arr[j]
//                swapped = True
//        if not swapped:
//            break  # 数组已经排序
//```
//
//在优化版本中，如果在一次遍历中没有发生任何交换，说明数组已经排序，算法提前终止，实现 O(n) 的最好情况时间。
//
//#### 修改任意算法的通用方法
//
//1. **识别最好情况**：确定算法的最好情况输入是什么。
//2. **添加预处理检查**：在执行主要算法之前，检查输入是否符合最好情况条件。
//3. **包括提前终止条件**：设计算法时识别出可以提前终止的条件。
//4. **自适应设计**：实现自适应技术，使算法能够根据输入动态调整行为。
//
//通过这些原则，可以修改几乎任意算法以实现更好的最好情况运行时间，从而在有利的输入情况下提高整体效率。
//
