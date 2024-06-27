//
//  MergeSort.swift
//  AlgorithmsInSwift
//
//  Created by xlzj on 2024/6/26.
//

import Foundation

extension Sort {
    
    ///  归并排序 2.3-2
    func MergeSort() {
        var array = [9,11,10, 8, 7, 6, 5, 4]
        
        mergeSort(&array, 0, array.count-1)
        print(array)
    }
    
    func mergeSort(_ array: inout [Int], _ left: Int, _ right: Int) {
        if left < right {
            let mid = (left + right) / 2
            
            mergeSort(&array, left, mid)
            mergeSort(&array, mid + 1, right)
            merge(&array, left, mid, right)
        }
    }

    
    /// p <= q < r
    ///array[p...q]  以及 array[q+1...r]是已排序数组
    ///合并这两个数组后array[p...r] 为已排序数组
    
    func merge(_ array: inout [Int], _ p: Int, _ q: Int, _ r: Int) {
        var left = p
        var right = q + 1
        var tempArray: [Int] = []
        
        while left <= q && right <= r  {
            if array[left] < array[right] {
                tempArray.append(array[left])
                left += 1
            } else {
                tempArray.append(array[right])
                right += 1
            }
        }
        
        if left <= q {
            for i in left...q {
                tempArray.append(array[i])
            }
        }
        
        if right <= r {
            for i in right...r {
                tempArray.append(array[i])
            }
        }
        
        for index in p...r {
            array[index] = tempArray[index - p]
        }
        
    }
    
}


extension Sort {
    /// 插入排序的 递归 版本 2.3-4
    ///
    func insert_recurve() {
        var array = [9,11,10, 8, 7, 6, 5, 4]
        insert_recurve_index(&array, array.count - 1)
    }
    
    func insert_recurve_index(_ array: inout [Int], _ index: Int) {
        if index == 0 {
            return
        }
        insert_recurve_index(&array, index - 1)
        var j = index - 1
        let key = array[index]
        while j >= 0 && array[j] > key {
            array[j+1] = array[j]
            j = j - 1
        }
        array[j+1] = key
        print(array)

    }
    
    
    func findSum() {
        var array = [9,11,10, 8, 7, 6, 5, 4]
        var sum = 17

        if let set = findTwoSum(array, sum) {
            print("find \(set.0) + \(set.1) = \(sum)")
        } else {
            print("no find")
        }
        
    }
    
    func findTwoSum(_ nums: [Int], _ target: Int) -> (Int, Int)? {
        // 对数组进行排序
        let sortedNums = nums.sorted()
        
        // 初始化两个指针
        var left = 0
        var right = sortedNums.count - 1
        
        // 使用双指针查找
        while left < right {
            let sum = sortedNums[left] + sortedNums[right]
            if sum == target {
                // 找到两个元素
                return (sortedNums[left], sortedNums[right])
            } else if sum < target {
                // 如果当前和小于目标值，移动左指针
                left += 1
            } else {
                // 如果当前和大于目标值，移动右指针
                right -= 1
            }
        }
        
        // 如果没有找到，返回 nil
        return nil
    }


    
}


extension Sort {
    
    func bubbleSort(){
        var array = [9,11,10, 8, 7, 6, 5, 4]

        for i in 0..<array.count {
            for j in (i+1..<array.count).reversed() {
                if array[j] < array[j-1] {
                    array.swapAt(j, j-1)
                    print(array)
                }
            }
        }
        
        
    }
}
