//
//  File.swift
//  AlgorithmsInSwift
//
//  Created by xlzj on 2024/6/29.
//

import Foundation

class MaxSubArray {
    func findMaxSubArray() {
        var array = [13, -3, -25, 20, -3, -16, -23, 18, 20, -7, 12, -5, -22, 15, -4, 7]
        let max = findMaxSubArrayInIndexOf(&array, 0, array.count - 1)
        
        print("max = \(max)")
    }
    
    func findMaxSubArrayInIndexOf(_ array: inout [Int], _ left: Int, _ right: Int) -> (max: Int, start: Int, end :Int) {
        /// 递归出口 数组长度为 1 或者 2
        let count = right - left + 1
        if count == 1 {
            return (array[left], left, left)
        }
        if count == 2 {
            let max = max(array[left], array[right], array[left] + array[right])
            if max ==  array[left]{
                return (max, left, left)

            }
            if max ==  array[right]{
                return (max, right, right)
            }
            
            return (max, left, right)
        }
        /// 找出mid 最小位left+1 因为count大于等于3
        let mid = left + count / 2
        /// 递归查找左侧数组的最大子数组
        let leftMax = findMaxSubArrayInIndexOf(&array, left, mid - 1)
        print("leftMax = \(leftMax) left = \(left) right = \(right) mid = \(mid)")
        /// 递归查找右侧数组的最大子数组
        let rightMax = findMaxSubArrayInIndexOf(&array, mid + 1, right)
        print("rightMax = \(rightMax) left = \(left) right = \(right) mid = \(mid)")
        /// 查找跨越 mid的最大子数组
        let midMax = findMaxSubArrayInIndexWithMid(&array, left, right, mid)
        print("midMax = \(midMax) left = \(left) right = \(right) mid = \(mid)")
        print("=====================")

        /// 比较左侧最大子数组 右侧最大子数组 以及跨越mid的最大子数组 大小
        let max = max(leftMax.max, rightMax.max, midMax.max)
        
        if max == leftMax.max {
            return leftMax
        }
        
        if max == rightMax.max {
            return leftMax
        }
        
        return midMax
        
    }
    
    func findMaxSubArrayInIndexWithMid(_ array: inout [Int], _ left: Int, _ right: Int, _ mid: Int) -> (max: Int, start: Int, end :Int) {
        ///  分为三部分 求和
        ///  左侧数组 left --- mid - 1
        ///  array[mid]
        ///  右侧数组 mid + 1 --- right
        ///  左右测数组个数最少为1
        ///  遍历左右求和 求出最大和 此时记录 leftIndex 或者 rightIndex 注意 左侧数组求和需要从右往左
        ///   如最和最大小于0则不应该加入最大子数组 只会把最大子数组变小 所以leftSum 和 rightSum 初始值设置为0即可
        ///   算法导论的伪代码里设置 leftSum rightSum 为负无穷是不必要的 只要和小于0 均可丢弃 故以0为阈值 代码简洁度 可读性均更高
        ///   leftIndex 和 rightIndex 也是一样思路 初始值设置为 mid
        var sum = 0
        var leftSum = 0
        var leftIndex = mid
        
        for i in (left..<mid).reversed() {
            sum += array[i]
            if sum > leftSum {
                leftSum = sum
                leftIndex = i
            }
        }
        
        sum = 0
        var rightSum = 0
        var rightIndex = mid
        
        for i in mid+1...right {
            sum += array[i]
            if sum > rightSum {
                rightSum = sum
                rightIndex = i
            }
        }
        return (leftSum + array[mid] + rightSum, leftIndex, rightIndex)
    }
    
    
    func findMaxSubArray_kadane() {
        var array = [13, -3, -25, 20, -3, -16, -23, 18, 20, -7, 12, -5, -22, 15, -4, 7]
        
        let max = maxSubArray_kadane(array)
        print("max = \(max)")


    }
    
    /// 最大子数组0(n) 线性复杂度算法 kadane 利用动态规划实现
    ///
    func maxSubArray_kadane(_ nums: [Int]) -> (sum: Int, start: Int, end: Int) {
        guard !nums.isEmpty else { return (0, -1, -1) }

        /// 当前最大子数组和 重点：包括当前节点i
        var currentMax = nums[0]
        /// 全局的最大子数组和
        var globalMax = nums[0]
        /// 当前最大子数组的起点 （不必要记录终点 因为终点必须是当前节点 i ）
        var currentStart = 0
        /// 全局的最大子数组 起点 由currentStart决定
        var globalStart = 0
        /// 全局的最大子数组 起点 由当前节点 i决定
        var globalEnd = 0

        for i in 1..<nums.count {
            /// 此处计算 包括当前节点i 的 当前最大子数组和
            /// 重点 上一个节点i-1的最大子数组已确定 即为 currentMax
            /// 如果 currentMax小于0 说明 左侧任意长度的数组和均小于0
            /// 此时包括nums[i]的最大子数组必然只能是nums[i]
            /// 因为如果给 nums[i] 加上任意左边数组（和小于0） 所得倒的数组和 均会小于 nums[i]
            /// GPT 给的代码是 if nums[i] > currentMax + nums[i] { 可优化为下方 我只需要关注上一个节点的当前数组和是否小于0
            /// 此处和 findMaxSubArrayInIndexWithMid 思想类似
               
            if currentMax < 0 {
                currentMax = nums[i]
                currentStart = i
            } else {
                currentMax += nums[i]
            }

            
            if currentMax > globalMax {
                globalMax = currentMax
                globalStart = currentStart
                globalEnd = i
            }
        }

        return (globalMax, globalStart, globalEnd)
    }

    
    
}
